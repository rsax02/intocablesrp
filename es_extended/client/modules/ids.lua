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
        for _, id in ipairs(activePlayers) do
            local idPed = GetPlayerPed(id)
            if idPed ~= ped then
                x1, y1, z1 = table.unpack(GetEntityCoords(ped, true))
                x2, y2, z2 = table.unpack(GetEntityCoords(idPed, true))
                distance = math.floor(#(vector3(x1,  y1,  z1)-vector3(x2,  y2,  z2)))
				playerDistances[id] = distance
				playerPeds[id] = idPed
            end
        end
        Citizen.Wait(1200)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        sleep = true
        if(not hide) then
            for _,id in ipairs(activePlayers) do
                local idPed = playerPeds[id]
                if v~=pedId and IsEntityVisible(idPed) then
                    if playerDistances[id] then
                        if (playerDistances[id] < disPlayerNames and HasEntityClearLosToEntity(ped, idPed, 17)) then
                            x2, y2, z2 = table.unpack(GetEntityCoords(idPed, true))
                            if NetworkIsPlayerTalking(id) then
                                DrawText3D(x2, y2, z2+1, GetPlayerServerId(id), 247,124,24)
                                --DrawMarker(27, x2, y2, z2-0.97, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 173, 216, 230, 100, 0, 0, 0, 0)
                            else
                                DrawText3D(x2, y2, z2+1, GetPlayerServerId(id), 255,255,255)
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

