ESX = nil
local ped, coords
local PlayerData = {}
local onDuty = false
local truckerBlip, deliveryblip = nil, nil
local currentDelivery = nil
local blockVehicle = false
local lastDelivery, cooldown = nil, GetGameTimer()
local currentIndex = 0

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(15)
	end

    PlayerData = ESX.GetPlayerData()
    refreshBlip()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    refreshBlip()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    onDuty = false
    if(deliveryblip)then
    RemoveBlip(deliveryblip)
    end
    deliveryblip = nil
    currentDelivery = nil
    currentIndex=0
    deleteBlip()
    refreshBlip()
end)

function deleteBlip()
    if(deliveryblip)then
    RemoveBlip(deliveryblip)
    end
    RemoveBlip(truckerBlip)
    truckerBlip = nil
end

function refreshBlip()
    if PlayerData ~= nil then
        if PlayerData.job.name == "trucker" then
            truckerBlip = AddBlipForCoord(Config.Blip.Pos.x, Config.Blip.Pos.y, Config.Blip.Pos.z)
            SetBlipSprite(truckerBlip, Config.Blip.Id)
            SetBlipDisplay(truckerBlip, 4)
            SetBlipScale(truckerBlip, 1.0)
            SetBlipColour(truckerBlip, Config.Blip.Colour)
            SetBlipAsShortRange(truckerBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Blip.Title)
            EndTextCommandSetBlipName(truckerBlip)
        end
    end
end

function showHelp(message)
    SetTextComponentFormat('STRING')
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function OpenCloakRoom()
    if (IsPedInAnyVehicle(ped, false)) then
        ESX.ShowNotification("Debes estar a pie para acceder al vestuario")
        return
    end
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
        title = "Vestuario",
        align = 'top-left',
        elements = {{
            label = "Ropa de trabajo",
            value = 'job_wear'
        }, {
            label = "Ropa de civil",
            value = 'citizen_wear'
        }}
    }, function(data, menu)
        if data.current.value == 'citizen_wear' then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
            onDuty = false
            if deliveryblip then
            RemoveBlip(deliveryblip)
            end
            deliveryblip = nil
            currentDelivery = nil
            currentIndex=0
        elseif data.current.value == 'job_wear' then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadClothes', skin, skin.sex == 0 and jobSkin.skin_male or jobSkin.skin_female)
            end)
            onDuty = true
        end
        menu.close()
        ESX.UI.Menu.CloseAll()
    end, function(data, menu)
        menu.close()
        ESX.UI.Menu.CloseAll()
    end)
end

function getDeliveries()
    if(currentIndex==0)then
        local inVehicle = IsPedInAnyVehicle(ped,false)
        local vehicle = GetVehiclePedIsIn(ped,false)
        local plate = GetVehicleNumberPlateText(vehicle)
        
        if inVehicle then
            if (not tonumber(plate)) or (tonumber(plate) and tonumber(plate) ~= GetPlayerServerId(PlayerId())) then
                ESX.ShowNotification("Debes estar a pie para comenzar una entrega")
                return
            end
        end

        local cars = {"benson3"}

        if (not IsPedInAnyVehicle(ped, false)) then
            if ESX.Game.IsSpawnPointClear(Config.VehicleSpawnPoint.Pos, 5.0) then
                ESX.Game.SpawnVehicle(cars[1], Config.VehicleSpawnPoint.Pos, 180.53, function(entity)
                    SetVehicleNumberPlateText(entity, GetPlayerServerId(PlayerId()))
                    SetEntityHeading(entity,270.4)
                    TaskWarpPedIntoVehicle(PlayerPedId(), entity, -1)
                    TriggerServerEvent('esx_jobs:spawnVehicle', currentDelivery)
                end)
            else return end
        end
    end

    if(currentDelivery==nil)then
        if deliveryblip~=nil then
            RemoveBlip(deliveryblip)
        end

        local deliveries = {}
        for k, v in pairs(Config.Delivery) do
            table.insert(deliveries, v)
        end
        local myDelivery = deliveries[math.random(1, #deliveries)]
        currentDelivery = {
            Route = myDelivery.Route,
            Pos = myDelivery.Pos,
            Duty = true,
            Color = {
                r = 204,
                g = 204,
                b = 0
            },
            Size = {
                x = 3.0,
                y = 3.0,
                z = 3.0
            },
            Hint = "Presiona ~INPUT_CONTEXT~ para descargar la mercaderia",
            Payment = myDelivery.Payment
            }
            currentIndex = 1
        else
            currentIndex=currentIndex+1
        end
    if(currentIndex==1)then
    blockVehicle=true
    TriggerEvent("pNotify:SendNotification", {
    text = "Cargando mercaderia.",
    type = "success",
    timeout = 3000,
    layout = "centerLeft"
    })
    
    Citizen.Wait(3500)
    cooldown= GetGameTimer()+90000
    blockVehicle=false
    FreezeEntityPosition(vehicle, false)
    end

    --print(ESX.DumpTable(currentDelivery))
    --print("currentindex:"..currentIndex)
    local thisIndex = currentDelivery.Route[currentIndex]

	deliveryblip = AddBlipForCoord(thisIndex.x,thisIndex.y,thisIndex.z)
	SetBlipSprite(deliveryblip, 1)
	SetBlipDisplay(deliveryblip, 4)
	SetBlipScale(deliveryblip, 1.0)
	SetBlipColour(deliveryblip, 5)
	SetBlipAsShortRange(deliveryblip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Punto de entrega")
	EndTextCommandSetBlipName(deliveryblip)

	SetBlipRoute(deliveryblip, true)
end

function delivery()
    if(currentDelivery~=nil)then
        if(not IsPedInAnyVehicle(ped))then
            return
        end
        local vehicle = GetVehiclePedIsIn(ped)
        local plate = GetVehicleNumberPlateText(vehicle)
        if tonumber(plate)~=nil and tonumber(plate) ~= GetPlayerServerId(PlayerId()) then
            return
        else
            if(deliveryblip)then                
            RemoveBlip(deliveryblip)
            end
            blockVehicle=true
            TriggerEvent("pNotify:SendNotification", {
            text = "Descargando producto.",
            type = "success",
            timeout = 3000,
            layout = "centerLeft"
            })

            Citizen.Wait(3500)
            FreezeEntityPosition(vehicle,false)
            blockVehicle=false
            TriggerServerEvent("esx_jobs:delivery", currentDelivery)
            if currentIndex == #currentDelivery.Route then
                ESX.ShowNotification('Recorrido completado, regresa por mas entregas!')
                currentDelivery = nil
                SetNewWaypoint(Config.Zones.VehicleSpawner.Pos.x, Config.Zones.VehicleSpawner.Pos.y)
                deliveryblip = nil
            else
                getDeliveries()
            end
            --[[ deliveryblip = AddBlipForCoord(Config.Zones.VehicleSpawner.Pos.x, Config.Zones.VehicleSpawner.Pos.y, Config.Zones.VehicleSpawner.Pos.z)

            SetBlipSprite(deliveryblip, 1)
            SetBlipDisplay(deliveryblip, 4)
            SetBlipScale(deliveryblip, 1.0)
            SetBlipColour(deliveryblip, 5)
            SetBlipAsShortRange(deliveryblip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Destino")
            EndTextCommandSetBlipName(deliveryblip)

            SetBlipRoute(deliveryblip, true) ]]
        end
	end
end

function returnTruck(vehicle)
    DeleteVehicle(vehicle)
    TriggerServerEvent('esx_jobs:returnVehicle',vehicle)
    RemoveBlip(deliveryblip)
    deliveryblip = nil
    currentDelivery = nil
    currentIndex=0
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
		if (PlayerData.job ~= nil and PlayerData.job.name == "trucker") then
            ped = PlayerPedId()
            coords = GetEntityCoords(ped)
            local vehicle = GetVehiclePedIsIn(ped,true)
            if(blockVehicle)then
                if(vehicle)then
                FreezeEntityPosition(vehicle, true)
                end
            elseif blockVehicle~=nil then
                if(vehicle)then
                FreezeEntityPosition(vehicle, false)
                end
                blockVehicle=nil
            end
        else
            Citizen.Wait(3000)
        end
    end
end)

Citizen.CreateThread(function()
    ped = PlayerPedId()
    coords = GetEntityCoords(ped)
    while true do
        Citizen.Wait(5)
        if (PlayerData.job ~= nil and PlayerData.job.name == "trucker") then
            for k, v in pairs(Config.Zones) do
                local distance = #(vector3(coords.x, coords.y, coords.z) - vector3(v.Pos.x, v.Pos.y, v.Pos.z))
                if (distance <= 30.0) then
                    if not v.Duty or onDuty then
                        DrawMarker(1, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y,
                            v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
                        if (distance <= v.Size.x) then
                            showHelp(v.Hint)
                            if (IsControlJustReleased(0, 38)) and not IsPedDeadOrDying(ped) then
                                if (v.Type == "cloakroom") then
                                    OpenCloakRoom()
                                    Citizen.Wait(5)
                                elseif (v.Type == "vehiclespawner") then
                                    if v.Duty and not onDuty then
                                        return
									end
									if currentDelivery==nil then
									getDeliveries()
                                    else 
                                        if (GetGameTimer() < cooldown) then 
                                        ESX.ShowNotification("Acabas de comenzar una entrega.")
                                        else
											currentDelivery=nil
											currentIndex=0
                                            getDeliveries()
                                        end
                                    end
                                    Citizen.Wait(5)
                                elseif (v.Type == "vehicledelete") then
                                    if v.Duty and not onDuty then
                                        return
                                    end

                                    if IsPedInAnyVehicle(ped,false) then
                                        local vehicle = GetVehiclePedIsIn(ped, false)
                                        local plate = GetVehicleNumberPlateText(vehicle)

                                        if tonumber(plate) and tonumber(plate) == GetPlayerServerId(PlayerId()) then
                                            returnTruck(vehicle)
                                        else
                                            ESX.ShowNotification("Este no es tu vehiculo")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
			end
			
			if currentDelivery ~= nil then
				local distance = #(vector3(coords.x, coords.y, coords.z) - vector3(currentDelivery.Route[currentIndex].x, currentDelivery.Route[currentIndex].y, currentDelivery.Route[currentIndex].z))
				if (distance <= 30.0) then
					if not currentDelivery.Duty or onDuty then
						DrawMarker(1, currentDelivery.Route[currentIndex].x, currentDelivery.Route[currentIndex].y, currentDelivery.Route[currentIndex].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, currentDelivery.Size.x, currentDelivery.Size.y, currentDelivery.Size.z, currentDelivery.Color.r,
							currentDelivery.Color.g, currentDelivery.Color.b, 100, false, true, 2, false, false, false, false)
						if (distance <= currentDelivery.Size.x) then
							showHelp(currentDelivery.Hint)
                            if (IsControlJustReleased(0, 38)) and not IsPedDeadOrDying(ped) then
								delivery()
							end
						end
					end
				end
			end
        else
            Citizen.Wait(1500)
        end
    end
end)