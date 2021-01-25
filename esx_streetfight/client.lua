ESX = nil
local activated = false
local betAmount = 0
local fightStatus = STATUS_INITIAL
local STATUS_INITIAL = 0
local STATUS_JOINED = 1
local STATUS_STARTED = 2
local blueJoined = false
local redJoined = false
local players = 0
local showCountDown = false
local participando = false
local rival = nil
local Gloves = {}
local showWinner = false
local winner = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(
            'esx:getSharedObject',
            function(obj)
                ESX = obj
            end
        )
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()

    CreateBlip(Config.BLIP.coords, Config.BLIP.text, Config.BLIP.sprite, Config.BLIP.color, Config.BLIP.scale)
    RunThread()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('xex_streetfight:playerJoined')
AddEventHandler('xex_streetfight:playerJoined', function(side, id)

        if side == 1 then
            blueJoined = true
        else
            redJoined = true
        end

        if id == GetPlayerServerId(PlayerId()) then
            participando = true
            putGloves()
        end
        players = players + 1
        fightStatus = STATUS_JOINED

end)

RegisterNetEvent('esx_streetfight:ringActivated')
AddEventHandler('esx_streetfight:ringActivated',function(active)
    activated=active
end)

RegisterNetEvent('xex_streetfight:startFight')
AddEventHandler('xex_streetfight:startFight', function(fightData)

    for index,value in ipairs(fightData) do
        if(value.id ~= GetPlayerServerId(PlayerId())) then
            rival = value.id      
        elseif value.id == GetPlayerServerId(PlayerId()) then
            participando = true
        end
    end

    fightStatus = STATUS_STARTED
    showCountDown = true
    countdown()

end)

RegisterNetEvent('xex_streetfight:playerLeaveFight')
AddEventHandler('xex_streetfight:playerLeaveFight', function(id)

    if id == GetPlayerServerId(PlayerId()) then
        ESX.ShowNotification('Te has alejado demasiado, has abandonado la pelea')
        SetPedMaxHealth(PlayerPedId(), 200)
        SetEntityHealth(PlayerPedId(), 200)
        removeGloves()
    elseif participando == true then
        TriggerServerEvent('xex_streetfight:pay', betAmount)
        local wn = betAmount - betAmount/10
        ESX.ShowNotification('Has ganado ~r~' .. (wn*2) .. '$')
        SetPedMaxHealth(PlayerPedId(), 200)
        SetEntityHealth(PlayerPedId(), 200)
        removeGloves()
    end
    reset()

end)

RegisterNetEvent('xex_streetfight:fightFinished')
AddEventHandler('xex_streetfight:fightFinished', function(looser)

    if participando == true then
        local ped = PlayerPedId()
        if(looser ~= GetPlayerServerId(PlayerId()) and looser ~= -2) then
            TriggerServerEvent('xex_streetfight:pay', betAmount)
            ESX.ShowNotification('Has ganado ~r~' .. betAmount .. '$')
            SetPedMaxHealth(ped, 200)
            SetEntityHealth(ped, 200)
    
            TriggerServerEvent('xex_streetfight:showWinner', GetPlayerServerId(PlayerId()))
        end
    
        if(looser == GetPlayerServerId(PlayerId()) and looser ~= -2) then
            ESX.ShowNotification('Has perdido la pelea ~r~-' .. betAmount .. '$')
            SetPedMaxHealth(ped, 200)
            SetEntityHealth(ped, 200)
        end
    
        if looser == -2 then
            ESX.ShowNotification('La pelea ha terminado por límite de tiempo')
            SetPedMaxHealth(ped, 200)
            SetEntityHealth(ped, 200)
        end

        removeGloves()
    end
    
    reset()

end)

RegisterNetEvent('xex_streetfight:raiseActualBet')
AddEventHandler('xex_streetfight:raiseActualBet', function()
    betAmount = betAmount * 2
    if betAmount == 0 then
        betAmount = 500
    elseif betAmount > 16000 then
        betAmount = 0
    end
end)

RegisterNetEvent('xex_streetfight:winnerText')
AddEventHandler('xex_streetfight:winnerText', function(id)
    showWinner = true
    winner = id
    Citizen.Wait(5000)
    showWinner = false
    winner = nil
end)

local actualCount = 0
function countdown()
    for i = 5, 0, -1 do
        actualCount = i
        Citizen.Wait(1000)
    end
    showCountDown = false
    actualCount = 0

    if participando == true then
        SetPedMaxHealth(PlayerPedId(), 500)
        SetEntityHealth(PlayerPedId(), 500)
    end
end

function putGloves()
    local ped = GetPlayerPed(-1)
    SetEntityHealth(ped,200)
    local hash = GetHashKey('prop_boxing_glove_01')
    while not HasModelLoaded(hash) do RequestModel(hash); Citizen.Wait(0); end
    local pos = GetEntityCoords(ped)
    local gloveA = CreateObject(hash, pos.x,pos.y,pos.z + 0.50, true,false,false)
    local gloveB = CreateObject(hash, pos.x,pos.y,pos.z + 0.50, true,false,false)
    table.insert(Gloves,gloveA)
    table.insert(Gloves,gloveB)
    SetModelAsNoLongerNeeded(hash)
    FreezeEntityPosition(gloveA,false)
    SetEntityCollision(gloveA,false,true)
    ActivatePhysics(gloveA)
    FreezeEntityPosition(gloveB,false)
    SetEntityCollision(gloveB,false,true)
    ActivatePhysics(gloveB)
    if not ped then ped = GetPlayerPed(-1); end -- gloveA = L, gloveB = R
    AttachEntityToEntity(gloveA, ped, GetPedBoneIndex(ped, 0xEE4F), 0.05, 0.00,  0.04,     00.0, 90.0, -90.0, true, true, false, true, 1, true) -- object is attached to right hand 
    AttachEntityToEntity(gloveB, ped, GetPedBoneIndex(ped, 0xAB22), 0.05, 0.00, -0.04,     00.0, 90.0,  90.0, true, true, false, true, 1, true) -- object is attached to right hand 
end

function removeGloves()
    for k,v in pairs(Gloves) do DeleteObject(v); end
end

AddEventHandler('onResourceStop',function(resource)
    if(resource==GetCurrentResourceName())then
        for k,v in pairs(Gloves) do DeleteObject(v); end    
    end
end)

function spawnMarker(coords)
    local centerRing = #(coords- vector3(-517.61,-1712.04,20.46))
    if centerRing < Config.DISTANCE and fightStatus ~= STATUS_STARTED then
        
        DrawText3D(Config.CENTER.x, Config.CENTER.y, Config.CENTER.z +1.5, 'Peleadores: ~r~' .. players .. '/2 \n ~w~Apuesta: ~r~'.. betAmount ..'$ ', 0.65)

        local blueZone = #(coords- vector3(Config.BLUEZONE.x, Config.BLUEZONE.y, Config.BLUEZONE.z))
        local redZone = #(coords- vector3(Config.REDZONE.x, Config.REDZONE.y, Config.REDZONE.z))
        local betZone = #(coords-vector3(Config.BETZONE.x, Config.BETZONE.y, Config.BETZONE.z))

        if blueJoined == false and activated then
            DrawText3D(Config.BLUEZONE.x, Config.BLUEZONE.y, Config.BLUEZONE.z +1.5, 'Unirse a la pelea [~b~E~w~]', 0.4)
            if blueZone < Config.DISTANCE_INTERACTION then
                ESX.ShowHelpNotification("Pulsa ~INPUT_CONTEXT~ para unirte al lado azul.")
                if IsControlJustReleased(0, 38) and participando == false then
                    TriggerServerEvent('xex_streetfight:join', betAmount, 0 )
                end
            end
        end

        if redJoined == false and activated then
            DrawText3D(Config.REDZONE.x, Config.REDZONE.y, Config.REDZONE.z +1.5, 'Unirse a la pelea [~r~E~w~]', 0.4)
            if redZone < Config.DISTANCE_INTERACTION then
                ESX.ShowHelpNotification("Pulsa ~INPUT_CONTEXT~ para unirte al lado rojo.")
                if IsControlJustReleased(0, 38) and participando == false then
                    TriggerServerEvent('xex_streetfight:join', betAmount, 1)
                end
            end
        end

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'boxing' then
            DrawMarker(1, Config.BETZONE.x, Config.BETZONE.y, Config.BETZONE.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 204,204, 0, 100, false, true, 2, false, false, false, false)
            if betZone < Config.DISTANCE_INTERACTION and fightStatus ~= STATUS_JOINED and fightStatus ~= STATUS_STARTED then
                ESX.ShowHelpNotification("Presione ~INPUT_CONTEXT~ para administrar el ring")
                if IsControlJustReleased(0, 38) then
                    local elements= {
                            {label="Subir apuesta", value="bet"},
                            {label="Activar o desactivar ring", value="ring"}
                            } 
                    ESX.UI.Menu.Open('default',GetCurrentResourceName(),'ring',{
                            title="Administrar ring",
                            align='top-left',
                            elements=elements
                        }, function(data,menu)                            
                            if(data.current.value=="bet")then
                                TriggerServerEvent('xex_streetfight:raiseBet', betAmount)
                            elseif(data.current.value=="ring") then
                                TriggerServerEvent('esx_streetfight:activateRing')
                            end
                        end, function(data,menu)
                            menu.close()
                        end)
                end
            end
        end
    end
end

function get3DDistance(x1, y1, z1, x2, y2, z2)
    local a = (x1 - x2) * (x1 - x2)
    local b = (y1 - y2) * (y1 - y2)
    local c = (z1 - z2) * (z1 - z2)
    return math.sqrt(a + b + c)
end

function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)
    AddTextComponentString(text)
    DrawText(_x, _y)
end

function CreateBlip(coords, text, sprite, color, scale)
	local blip = AddBlipForCoord(coords.x, coords.y)
	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, scale)
	SetBlipColour(blip, color)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandSetBlipName(blip)
end

function reset() 
    redJoined = false
    blueJoined = false
    participando = false
    players = 0
    fightStatus = STATUS_INITIAL
end

local ped,player,coords

function RunThread()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5)
            coords = GetEntityCoords(ped)
            spawnMarker(coords)
        end
    end)
end

-- Alejar player - 1000 loop
Citizen.CreateThread(function()
    while true do
        ped=PlayerPedId()
        player = PlayerId()
        if fightStatus == STATUS_STARTED and participando == false and GetEntityCoords(ped) ~= rival then
            local coords = GetEntityCoords(ped)
            if get3DDistance(Config.CENTER.x, Config.CENTER.y, Config.CENTER.z,coords.x,coords.y,coords.z) < 4.7 then
                ESX.ShowNotification('Aléjate del ring!')
                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(ped, -521.58, -1723.58, 19.16)
                    local foundGround, zPos = GetGroundZFor_3dCoord(-521.58, -1723.58, 19.16)
                    if foundGround then
                        SetPedCoordsKeepVehicle(ped, -521.58, -1723.58, 19.16)
                        break
                    end
                    Citizen.Wait(5)
                end
            end
        end
        Citizen.Wait(800)
	end
end)

-- Main 0 loop
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if showCountDown == true then
            distance = #(Config.CENTER.x-coords)
            if(distance<20.0)then
            DrawText3D(Config.CENTER.x, Config.CENTER.y, Config.CENTER.z + 1.5, 'La pelea comienza en: ' .. actualCount, 2.0)
            end
        elseif showCountDown == false and fightStatus == STATUS_STARTED then
            if GetEntityHealth(PlayerPedId()) < 150 then
                TriggerServerEvent('xex_streetfight:finishFight', GetPlayerServerId(player))
                -- Debug: metemos perdedor aleatorio para salir ganadores
                -- TriggerServerEvent('xex_streetfight:finishFight', 20)
                fightStatus = STATUS_INITIAL
            end
        end
       
        if participando == true then
            local coords = GetEntityCoords(ped)
            if get3DDistance(Config.CENTER.x, Config.CENTER.y, Config.CENTER.z,coords.x,coords.y,coords.z) > Config.LEAVE_FIGHT_DISTANCE then
                TriggerServerEvent('xex_streetfight:leaveFight', GetPlayerServerId(player))
            end
        end

        if showWinner == true and winner ~= nil then
            local coords = GetEntityCoords(ped)
            if get3DDistance(Config.CENTER.x, Config.CENTER.y, Config.CENTER.z,coords.x,coords.y,coords.z) < 15 then
                DrawText3D(Config.CENTER.x, Config.CENTER.y, Config.CENTER.z + 2.5, '~r~ID: ' .. winner .. ' gana!', 2.0)
            end
        end
    end
end)