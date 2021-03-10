local disPlayerNames = 13
local playerDistances,playerPeds = {},{}
local hide = false

local function DrawText3D(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px,py,pz)-vector3(x,y,z))
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        if not useCustomScale then
            SetTextScale(0.0*scale, 0.55*scale)
        else 
            SetTextScale(0.0*scale, customScale)
        end
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local ped,pedId, activePlayers

RegisterNetEvent('es_extended:hideIds')
AddEventHandler('es_extended:hideIds',function()
    hide=not hide
end)

Citizen.CreateThread(function()
    while true do
        ped=PlayerPedId()
        pedId=PlayerId()
        activePlayers=GetActivePlayers()
        x1, y1, z1 = table.unpack(GetEntityCoords(ped, true))
        for _, id in ipairs(activePlayers) do
            local idPed = GetPlayerPed(id)
            if idPed ~= ped then
                x2, y2, z2 = table.unpack(GetEntityCoords(idPed, true))
                distance = math.floor(#(vector3(x1,  y1,  z1)-vector3(x2,  y2,  z2)))
                if distance<=30 then
				playerDistances[id] = {dist=distance,id=GetPlayerServerId(id)}
				playerPeds[id] = idPed
                end
            end
        end
        Citizen.Wait(1250)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        sleep = true
        if(not hide) then
            for _,id in ipairs(activePlayers) do
                local idPed = playerPeds[id]
                    if playerDistances[id] then
                        if IsEntityVisible(idPed) then
                            if (playerDistances[id].dist < disPlayerNames and HasEntityClearLosToEntity(ped, idPed, 13)) then
                                x2, y2, z2 = table.unpack(GetEntityCoords(idPed, true))
                                if NetworkIsPlayerTalking(id) then
                                    DrawText3D(x2, y2, z2+1, playerDistances[id].id, 247,124,24)
                                    PlayFacialAnim(idPed, 'mic_chatter', 'mp_facial')
                                    --DrawMarker(27, x2, y2, z2-0.97, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 173, 216, 230, 100, 0, 0, 0, 0)
                                else
                                    DrawText3D(x2, y2, z2+1, playerDistances[id].id, 255,255,255)
                                    PlayFacialAnim(idPed, 'mood_normal_1', 'facials@gen_male@variations@normal')
                                end
                                sleep=false
                            end
                        end
                    end
            end
        end
        if(sleep)then
            Citizen.Wait(800)
        end
    end
end)

