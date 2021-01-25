Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local menuOpen = false
local wasOpen = false
local lastEntity = nil
local currentAction = nil
local currentData = nil
local musics = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx_music:place_music')
AddEventHandler('esx_music:place_music', function(music)
    startAnimation("anim@heists@money_grab@briefcase","put_down_case")
    Citizen.Wait(1000)
    ClearPedTasks(PlayerPedId())
    TriggerEvent('esx:spawnObject', 'prop_boombox_01')
    musics=music
end)

RegisterNetEvent('esx_music:play_music')
AddEventHandler('esx_music:play_music', function(id, object)
    if distance(object) < Config.distance then
        SendNUIMessage({
            transactionType = 'playSound',
            transactionData = id
        })

        SendNUIMessage({
            transactionType = 'volume',
            transactionData = 50
        })

        Citizen.CreateThread(function()
            local stoped=false
            while true do
                Citizen.Wait(100)
                
                if distance(object) > Config.distance then
                    SendNUIMessage({
                        transactionType = 'volume',
                        transactionData = 0
                    })
                    stoped=true
                end

                if stoped and distance(object)<Config.distance then
                    SendNUIMessage({
                        transactionType = 'volume',
                        transactionData = 15
                    })
                    stoped=false
                end
            end
        end)
    else
        Citizen.CreateThread(function()
            local stoped=false
            SendNUIMessage({
                transactionType = 'playSound',
                transactionData = id
            })
            SendNUIMessage({
                transactionType = 'volume',
                transactionData = 0
            })
            while true do
                Citizen.Wait(500)
                
                if distance(object) > Config.distance then
                    SendNUIMessage({
                        transactionType = 'volume',
                        transactionData = 0
                    })
                    stoped=true
                end

                if stoped and distance(object)<Config.distance then
                    SendNUIMessage({
                        transactionType = 'volume',
                        transactionData = 50
                    })
                    stoped=false
                end
            end
        end)
    end
end)

RegisterNetEvent('esx_music:setVolume')
AddEventHandler('esx_music:setVolume', function(volume, object)
    if distance(object) < Config.distance then
        SendNUIMessage({
            transactionType = 'volume',
            transactionData = volume
        })
    end
end)

function distance(object)
    local playerPed = PlayerPedId()
    local lCoords = GetEntityCoords(playerPed)
    local distance  = #(lCoords- object)
    return distance
end

RegisterNetEvent('esx_music:stop_music')
AddEventHandler('esx_music:stop_music', function(object,music)    
    SendNUIMessage({
        transactionType = 'stopSound'
    })
    print("hola")
    musics=music
end)

function OpenmusicMenu()
    menuOpen = true
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'music', {
        title   = 'La music a momo',
        align   = 'top-left',
        elements = {
            {label = _U('get_music'), value = 'get_music'},
            {label = _U('play_music'), value = 'play'},
            {label = _U('volume_music'), value = 'volume'},
            {label = _U('stop_music'), value = 'stop'}
        }
    }, function(data, menu)
        local playerPed = PlayerPedId()
        local lCoords = GetEntityCoords(playerPed)
        if data.current.value == 'get_music' then
            ESX.PlayerData = ESX.GetPlayerData()
            local alreadyOne = false
            for i=1, #ESX.PlayerData.inventory, 1 do
                if ESX.PlayerData.inventory[i].name == 'music' and ESX.PlayerData.inventory[i].count > 0 then
                    alreadyOne = true
                end
            end
            if not alreadyOne then
                NetworkRequestControlOfEntity(currentData)
                menu.close()
                menuOpen = false
                startAnimation("anim@heists@narcotics@trash","pickup")
                Citizen.Wait(700)
                SetEntityAsMissionEntity(currentData,false,true)
                DeleteEntity(currentData)
                ESX.Game.DeleteObject(currentData)
                if not DoesEntityExist(currentData) then
                    print("hola")
                    TriggerServerEvent('esx_music:remove_music', lCoords)
                    currentData = nil
                end
                Citizen.Wait(500)
                ClearPedTasks(PlayerPedId())
            else
                menu.close()
                menuOpen = false
                TriggerEvent('esx:showNotification', _U('music_alreadyOne'))
            end
        elseif data.current.value == 'play' then
            play(lCoords)
        elseif data.current.value == 'stop' then
            TriggerServerEvent('esx_music:stop_music', lCoords)
            menuOpen = false
            menu.close()
        elseif data.current.value == 'volume' then
            setVolume(lCoords)
        end
    end, function(data, menu)
        menuOpen = false
        menu.close()
    end)
end

function setVolume(coords)
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'setvolume',
        {
            title = _U('set_volume'),
        }, function(data, menu)
            local value = tonumber(data.value)
            if value < 0 or value > 100 then
                ESX.ShowNotification(_U('sound_limit'))
            else
                TriggerServerEvent('esx_music:setVolume', value, coords)
                menu.close()
            end
        end, function(data, menu)
            menu.close()
        end)
end

function play(coords)
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'play',
        {
            title = _U('play'),
        }, function(data, menu)
            TriggerServerEvent('esx_music:play_music', data.value, coords)
            menu.close()
        end, function(data, menu)
            menu.close()
        end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        local playerPed = PlayerPedId()
        local coords    = GetEntityCoords(playerPed)

        local closestDistance = -1
        local closestEntity   = nil

        local object = GetClosestObjectOfType(coords, 3.0, GetHashKey('prop_boombox_01'), false, false, false)
        local objCoords
        if DoesEntityExist(object) then
            objCoords = GetEntityCoords(object)
            local distance  = #(coords- objCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestDistance = distance
                closestEntity   = object
            end
        end

        if closestDistance ~= -1 and closestDistance <= 3.0 then
            if lastEntity ~= closestEntity and not menuOpen then
                local id = GetPlayerServerId(PlayerId())
                for k,v in pairs(musics) do
                    if #(v.coords-objCoords)<2.0 and v.owner==id then
                        ESX.ShowHelpNotification(_U('music_help'))
                        lastEntity = closestEntity
                        currentAction = "music"
                        currentData = closestEntity
                        break
                    end
                end
            end
        else
            if lastEntity then
                lastEntity = nil
                currentAction = nil
                currentData = nil
            end
        end
    end
end)

RegisterNetEvent('esx_music:delete')
AddEventHandler('esx_music:delete',function()
    local playerPed = PlayerPedId()
        local coords    = GetEntityCoords(playerPed)

        local closestDistance = -1
        local closestEntity   = nil

        local object = GetClosestObjectOfType(coords, 3.0, GetHashKey('prop_boombox_01'), false, false, false)
        local objCoords
        if DoesEntityExist(object) then
            objCoords = GetEntityCoords(object)
            local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

            if closestDistance == -1 or closestDistance > distance then
                closestDistance = distance
                closestEntity   = object
            end
        end

        if closestDistance ~= -1 and closestDistance <= 3.0 then
            if lastEntity ~= closestEntity and not menuOpen then
                NetworkRequestControlOfEntity(closestEntity)
                SetEntityAsMissionEntity(closestEntity,false,true)
                DeleteEntity(closestEntity)
                ESX.Game.DeleteObject(closestEntity)
                TriggerServerEvent('esx_music:remove_music', objCoords)
            end
        end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(8)
        if IsControlJustReleased(0, 38) and currentAction then
            OpenmusicMenu()
        end
    end
end)

function startAnimation(lib,anim)
    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 1, 0, false, false, false)
    end)
end