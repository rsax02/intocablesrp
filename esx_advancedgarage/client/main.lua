local CurrentActionData, PlayerData, userProperties, this_Garage, vehInstance, BlipList, PrivateBlips, JobBlips = {}, {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, WasInPound, WasinJPound = false, false, false
local LastZone, CurrentAction, CurrentActionMsg
local lastDismantle = GetGameTimer()
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	CreateBlips()
end)



local function has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

-- Start of Aircraft Code
function ListOwnedAircraftsMenu()
	local elements = {}

	if Config.Main.ShowVehLoc and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.Main.ShowVehLoc == false and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAircrafts', function(ownedAircrafts)
		if #ownedAircrafts == 0 then
			ESX.ShowNotification(_U('garage_no_aircrafts'))
		else
			for _,v in pairs(ownedAircrafts) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.Main.ShowVehLoc then
					if v.stored then
						labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('loc_garage'))
					else
						labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span> |'):format(_U('loc_pound'))
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_aircraft', {
			title = _U('garage_aircrafts'),
			align = Config.Main.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
				else
					ESX.ShowNotification(_U('aircraft_is_impounded'))
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StoreOwnedAircraftsMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.Main.DamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Aircrafts.PoundP*Config.Main.MultAmount)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Aircrafts.PoundP)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedAircraftsMenu()
	if WasInPound then
		ESX.ShowNotification(_U('must_wait', Config.Main.PoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedAircrafts', function(ownedAircrafts)
			local elements = {}

			if Config.Main.ShowVehLoc == false and Config.Main.Spacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedAircrafts) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_aircraft', {
				title = _U('pound_aircrafts', ESX.Math.GroupDigits(Config.Aircrafts.PoundP)),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyAircrafts', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								SpawnVehicle(data.current.value, data.current.value.plate)
								TriggerServerEvent('esx_advancedgarage:payAircraft')
								if Config.Main.PoundTimer then
									WasInPound = true
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Aircraft Code

-- Start of Boat Code
function ListOwnedBoatsMenu()
	local elements = {}

	if Config.Main.ShowVehLoc and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.Main.ShowVehLoc == false and Config.Main.Spacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedBoats', function(ownedBoats)
		if #ownedBoats == 0 then
			ESX.ShowNotification(_U('garage_no_boats'))
		else
			for _,v in pairs(ownedBoats) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.Main.ShowVehLoc then
					if v.stored then
						labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('loc_garage'))
					else
						labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span> |'):format(_U('loc_pound'))
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_boat', {
			title = _U('garage_boats'),
			align = Config.Main.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
				else
					ESX.ShowNotification(_U('boat_is_impounded'))
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StoreOwnedBoatsMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.Main.DamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Boats.PoundP*Config.Main.MultAmount)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.Boats.PoundP)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function ReturnOwnedBoatsMenu()
	if WasInPound then
		ESX.ShowNotification(_U('must_wait', Config.Main.PoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedBoats', function(ownedBoats)
			local elements = {}

			if Config.Main.ShowVehLoc == false and Config.Main.Spacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedBoats) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_boat', {
				title = _U('pound_boats', ESX.Math.GroupDigits(Config.Boats.PoundP)),
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyBoats', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								SpawnVehicle(data.current.value, data.current.value.plate)
								TriggerServerEvent('esx_advancedgarage:payBoat')
								if Config.Main.PoundTimer then
									WasInPound = true
								end
							end
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end)
				else
					ESX.ShowNotification(_U('cant_take_out'))
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Boat Code

-- Start of Car Code
function ListOwnedCarsMenu()
	local elements = {}

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedCars', function(ownedCars)
			for _,v in pairs(ownedCars) do
				if(v.stored)then
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle = ("<span style='color:white'>%s (%s)</span>"):format(vehicleName,plate)
				table.insert(elements, {label = labelvehicle, value = v})
				end
			end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car', {
			title = _U('garage_cars'),
			align = Config.Main.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
					menu.close()
					SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StoreOwnedCarsMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 590 then --antes 990
					if Config.Main.DamageMult then
						local apprasial = 50 --math.floor((1000 - engineHealth)/1000*Config.Cars.PoundP*Config.Main.MultAmount)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = 50 --math.floor((1000 - engineHealth)/1000*Config.Cars.PoundP)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

local dismantling = false

function DismantleCar()
	Citizen.Wait(1500)
	local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
	local model = GetEntityModel(vehicle)
	ESX.TriggerServerCallback('esx_garage:dismantleVehicle',function(dismantle)
		if dismantle then
			dismantling=true
			ESX.ShowNotification("Desmantelando el vehiculo..")
			Citizen.Wait(1200)
			DeleteVehicle(vehicle)
			dismantling=false
		end
	end,GetDisplayNameFromVehicleModel(model),GetVehicleNumberPlateText(vehicle))
end

function ReturnOwnedCarsMenu()
	if WasInPound then
		ESX.ShowNotification(_U('must_wait', Config.Main.PoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedCars', function(ownedCars)
			local elements = {}

			if Config.Main.ShowVehLoc == false and Config.Main.Spacers then
				--local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				local spacer = "Confiscados"
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedCars) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(v.modelo)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local returnPrice = v.price 
				--local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle = ('<span style="color:white;">%s(%s) - $%s</span>'):format(vehicleName, plate,returnPrice)

				--labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v, model=v.modelo, price=returnPrice})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_car', {
				title = "Confiscados",
				align = Config.Main.MenuAlign,
				elements = elements
			}, function(data, menu)
				if data.current.value==nil then
				else
					menu.close()
					--TriggerEvent('esx:deleteVehicle',data.current.value.plate)
					ESX.Game.SpawnVehicle(data.current.value.model, this_Garage.Spawner, this_Garage.Heading, function(callback_vehicle)
						ESX.Game.SetVehicleProperties(callback_vehicle, data.current.value)
						SetVehicleFixed(callback_vehicle)
						SetVehicleDeformationFixed(callback_vehicle)
						SetVehicleUndriveable(callback_vehicle, false)
						SetVehicleEngineOn(callback_vehicle, true, true)
						--SetVehicleEngineHealth(callback_vehicle, 1000) -- Might not be needed
						--SetVehicleBodyHealth(callback_vehicle, 1000) -- Might not be needed
						local carplate = GetVehicleNumberPlateText(callback_vehicle)
						table.insert(vehInstance, {vehicleentity = callback_vehicle, plate = carplate})
						TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
						TriggerServerEvent('esx_advancedgarage:payCar',data.current.price,data.current.value.plate,NetworkGetNetworkIdFromEntity(callback_vehicle))
					end)

					TriggerServerEvent('esx_advancedgarage:setVehicleState', data.current.value.plate, false)
					
					--SpawnVehicle(data.current.value, data.current.value.plate)
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Car Code

-- Repair Vehicles
function RepairVehicle(apprasial, vehicle, vehicleProps)
	ESX.UI.Menu.CloseAll()

	local elements = {
		{label = _U('return_vehicle').." ($"..apprasial..")", value = 'yes'},
		{label = _U('see_mechanic'), value = 'no'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_menu', {
		title = _U('damaged_vehicle'),
		align = Config.Main.MenuAlign,
		elements = elements
	}, function(data, menu)
		menu.close()

		if data.current.value == 'yes' then
			TriggerServerEvent('esx_advancedgarage:payhealth', apprasial)
			vehicleProps.bodyHealth = 1000.0 -- must be a decimal value!!!
			vehicleProps.engineHealth = 1000
			StoreVehicle(vehicle, vehicleProps)
		elseif data.current.value == 'no' then
			ESX.ShowNotification(_U('visit_mechanic'))
		end
	end, function(data, menu)
		menu.close()
	end)
end

-- Store Vehicles
function StoreVehicle(vehicle, vehicleProps)
	for k,v in pairs (vehInstance) do
		if ESX.Math.Trim(v.plate) == ESX.Math.Trim(vehicleProps.plate) then
			table.remove(vehInstance, k)
		end
	end

	DeleteEntity(vehicle)
	TriggerServerEvent('esx_advancedgarage:setVehicleState', vehicleProps.plate, true)
	--ESX.ShowNotification(_U('vehicle_in_garage'))
end

-- Spawn Vehicles
function SpawnVehicle(vehicle, plate)
	ESX.Game.SpawnVehicle(vehicle.model, this_Garage.Spawner, this_Garage.Heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		--SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		--SetVehicleEngineHealth(callback_vehicle, 1000) -- Might not be needed
		--SetVehicleBodyHealth(callback_vehicle, 1000) -- Might not be needed
		local carplate = GetVehicleNumberPlateText(callback_vehicle)
		table.insert(vehInstance, {vehicleentity = callback_vehicle, plate = carplate})
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)

	TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
end

function SpawnVehicle2(vehicle, plate)
	ESX.Game.SpawnVehicle(vehicle.model, this_Garage.Spawner2, this_Garage.Heading2, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		--SetVehicleEngineHealth(callback_vehicle, 1000) -- Might not be needed
		--SetVehicleBodyHealth(callback_vehicle, 1000) -- Might not be needed
		local carplate = GetVehicleNumberPlateText(callback_vehicle)
		table.insert(vehInstance, {vehicleentity = callback_vehicle, plate = carplate})
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)

	TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
end

-- Check Vehicles
function DoesAPlayerDrivesVehicle(plate)
	local isVehicleTaken = false
	local players = ESX.Game.GetPlayers()
	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		if target ~= PlayerPedId() then
			local plate1 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, true))
			local plate2 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, false))
			if plate == plate1 or plate == plate2 then
				isVehicleTaken = true
				break
			end
		end
	end
	return isVehicleTaken
end

-- Entered Marker
AddEventHandler('esx_advancedgarage:hasEnteredMarker', function(zone)
	--[[ if zone == 'aircraft_garage_point' then
		CurrentAction = 'aircraft_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'aircraft_store_point' then
		CurrentAction = 'aircraft_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'aircraft_pound_point' then
		CurrentAction = 'aircraft_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'boat_garage_point' then
		CurrentAction = 'boat_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'boat_store_point' then
		CurrentAction = 'boat_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'boat_pound_point' then
		CurrentAction = 'boat_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	else ]]if zone == 'car_garage_point' then
		CurrentAction = 'car_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'car_store_point' then
		CurrentAction = 'car_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'car_pound_point' then
		CurrentAction = 'car_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'dismantle_point' then
		CurrentAction = 'dismantle_point'
		CurrentActionMsg = "Presiona ~INPUT_PICKUP~ para desmantelar el vehiculo"
		CurrentActionData = {}
	end
end)

-- Exited Marker
AddEventHandler('esx_advancedgarage:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Resource Stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		ESX.UI.Menu.CloseAll()
	end
end)
local playerPed, playerCoords, playerVeh, model
-- Enter / Exit marker events & Draw Markers
Citizen.CreateThread(function()
	while true do
		playerPed = PlayerPedId()
		playerCoords = GetEntityCoords(playerPed)
		playerVeh = GetVehiclePedIsIn(playerPed, false)
		model = GetEntityModel(playerVeh)
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	ped = PlayerPedId()
	while true do
		Citizen.Wait(5)
		local isInMarker, letSleep, currentZone = false, true
		if dismantling then
    		DisableControlAction(0, 75)
		end
		--[[ if Config.Aircrafts.Garages then
			for k,v in pairs(Config.AircraftGarages) do
				local distance = #(playerCoords - v.Marker)
				local distance2 = #(playerCoords - v.Deleter)

				if distance < Config.Main.DrawDistance then
					letSleep = false

					if Config.Aircrafts.Markers.Points.Type ~= -1 then
						DrawMarker(Config.Aircrafts.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Aircrafts.Markers.Points.x, Config.Aircrafts.Markers.Points.y, Config.Aircrafts.Markers.Points.z, Config.Aircrafts.Markers.Points.r, Config.Aircrafts.Markers.Points.g, Config.Aircrafts.Markers.Points.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.Aircrafts.Markers.Points.x then
						isInMarker, this_Garage, currentZone = true, v, 'aircraft_garage_point'
					end
				end

				if distance2 < Config.Main.DrawDistance then
					letSleep = false

					if Config.Aircrafts.Markers.Delete.Type ~= -1 then
						DrawMarker(Config.Aircrafts.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Aircrafts.Markers.Delete.x, Config.Aircrafts.Markers.Delete.y, Config.Aircrafts.Markers.Delete.z, Config.Aircrafts.Markers.Delete.r, Config.Aircrafts.Markers.Delete.g, Config.Aircrafts.Markers.Delete.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance2 < Config.Aircrafts.Markers.Delete.x then
						isInMarker, this_Garage, currentZone = true, v, 'aircraft_store_point'
					end
				end
			end

			for k,v in pairs(Config.AircraftPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.Main.DrawDistance then
					letSleep = false

					if Config.Aircrafts.Markers.Pounds.Type ~= -1 then
						DrawMarker(Config.Aircrafts.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Aircrafts.Markers.Pounds.x, Config.Aircrafts.Markers.Pounds.y, Config.Aircrafts.Markers.Pounds.z, Config.Aircrafts.Markers.Pounds.r, Config.Aircrafts.Markers.Pounds.g, Config.Aircrafts.Markers.Pounds.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.Aircrafts.Markers.Pounds.x then
						isInMarker, this_Garage, currentZone = true, v, 'aircraft_pound_point'
					end
				end
			end
		end

		if Config.Boats.Garages then
			for k,v in pairs(Config.BoatGarages) do
				local distance = #(playerCoords - v.Marker)
				local distance2 = #(playerCoords - v.Deleter)

				if distance < Config.Main.DrawDistance then
					letSleep = false

					if Config.Boats.Markers.Points.Type ~= -1 then
						DrawMarker(Config.Boats.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Boats.Markers.Points.x, Config.Boats.Markers.Points.y, Config.Boats.Markers.Points.z, Config.Boats.Markers.Points.r, Config.Boats.Markers.Points.g, Config.Boats.Markers.Points.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.Boats.Markers.Points.x then
						isInMarker, this_Garage, currentZone = true, v, 'boat_garage_point'
					end
				end

				if distance2 < Config.Main.DrawDistance then
					letSleep = false

					if Config.Boats.Markers.Delete.Type ~= -1 then
						DrawMarker(Config.Boats.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Boats.Markers.Delete.x, Config.Boats.Markers.Delete.y, Config.Boats.Markers.Delete.z, Config.Boats.Markers.Delete.r, Config.Boats.Markers.Delete.g, Config.Boats.Markers.Delete.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance2 < Config.Boats.Markers.Delete.x then
						isInMarker, this_Garage, currentZone = true, v, 'boat_store_point'
					end
				end
			end

			for k,v in pairs(Config.BoatPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.Main.DrawDistance then
					letSleep = false

					if Config.Boats.Markers.Pounds.Type ~= -1 then
						DrawMarker(Config.Boats.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Boats.Markers.Pounds.x, Config.Boats.Markers.Pounds.y, Config.Boats.Markers.Pounds.z, Config.Boats.Markers.Pounds.r, Config.Boats.Markers.Pounds.g, Config.Boats.Markers.Pounds.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.Boats.Markers.Pounds.x then
						isInMarker, this_Garage, currentZone = true, v, 'boat_pound_point'
					end
				end
			end
		end ]]

		if Config.Cars.Garages then
			for k,v in pairs(Config.CarGarages) do
				local distance = #(playerCoords - v.Marker)
				local distance2 = #(playerCoords - v.Deleter)

				if distance < Config.Main.DrawDistance then
					letSleep = false

					if Config.Cars.Markers.Points.Type ~= -1 then
						DrawMarker(Config.Cars.Markers.Points.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Cars.Markers.Points.x, Config.Cars.Markers.Points.y, Config.Cars.Markers.Points.z, Config.Cars.Markers.Points.r, Config.Cars.Markers.Points.g, Config.Cars.Markers.Points.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.Cars.Markers.Points.x then
						isInMarker, this_Garage, currentZone = true, v, 'car_garage_point'
					end
				end

				if distance2 < Config.Main.DrawDistance then
					letSleep = false

					if Config.Cars.Markers.Delete.Type ~= -1 then
						DrawMarker(Config.Cars.Markers.Delete.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Cars.Markers.Delete.x, Config.Cars.Markers.Delete.y, Config.Cars.Markers.Delete.z, Config.Cars.Markers.Delete.r, Config.Cars.Markers.Delete.g, Config.Cars.Markers.Delete.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance2 < Config.Cars.Markers.Delete.x then
						isInMarker, this_Garage, currentZone = true, v, 'car_store_point'
					end
					break
				end
			end
			if letSleep then
				for k,v in pairs(Config.CarPounds) do
					local distance = #(playerCoords - v.Marker)

					if distance < Config.Main.DrawDistance then
						letSleep = false

						if Config.Cars.Markers.Pounds.Type ~= -1 then
							DrawMarker(Config.Cars.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Cars.Markers.Pounds.x, Config.Cars.Markers.Pounds.y, Config.Cars.Markers.Pounds.z, Config.Cars.Markers.Pounds.r, Config.Cars.Markers.Pounds.g, Config.Cars.Markers.Pounds.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.Cars.Markers.Pounds.x then
							isInMarker, this_Garage, currentZone = true, v, 'car_pound_point'
						end
						break
					end
				end
			end
			
			for k,v in pairs(Config.Dismantle) do
				local distance = #(playerCoords-v.Marker)
				if distance<25 then
					letSleep = false
				
					if Config.Cars.Markers.Pounds.Type ~= -1 then
						DrawMarker(Config.Cars.Markers.Pounds.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Cars.Markers.Pounds.x, Config.Cars.Markers.Pounds.y, Config.Cars.Markers.Pounds.z, 204, 209, 209, 100, false, true, 2, false, nil, nil, false)
					end
					
					if distance < Config.Cars.Markers.Pounds.x then
						isInMarker, this_Garage, currentZone = true, v, 'dismantle_point'
					end
					break
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker, LastZone = true, currentZone
			LastZone = currentZone
			TriggerEvent('esx_advancedgarage:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_advancedgarage:hasExitedMarker', LastZone)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	playerPed = GetPlayerPed(-1)
	while true do
		Citizen.Wait(6)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				--[[ if CurrentAction == 'aircraft_garage_point' then
					ListOwnedAircraftsMenu()
				elseif CurrentAction == 'aircraft_store_point' then
					if IsThisModelAHeli(model) or IsThisModelAPlane(model) then
						if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
							StoreOwnedAircraftsMenu()
						else
							ESX.ShowNotification(_U('driver_seat'))
						end
					else
						ESX.ShowNotification(_U('not_correct_veh'))
					end
				elseif CurrentAction == 'aircraft_pound_point' then
					ReturnOwnedAircraftsMenu()
				elseif CurrentAction == 'boat_garage_point' then
					ListOwnedBoatsMenu()
				elseif CurrentAction == 'boat_store_point' then
					if IsThisModelABoat(model) then
						if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
							StoreOwnedBoatsMenu()
						else
							ESX.ShowNotification(_U('driver_seat'))
						end
					else
						ESX.ShowNotification(_U('not_correct_veh'))
					end
				elseif CurrentAction == 'boat_pound_point' then
					ReturnOwnedBoatsMenu()
				else ]]
				if CurrentAction == 'car_garage_point' then
					ListOwnedCarsMenu()
				elseif CurrentAction == 'dismantle_point' then
					if IsPedInAnyVehicle(playerPed,false) then
						if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
							if GetGameTimer() > lastDismantle then
								DismantleCar()
							else
								ESX.ShowHelpNotification("Debes esperar para desmantelar nuevamente") 
							end
						else
							ESX.ShowNotification(_U('driver_seat'))
						end
					else
						ESX.ShowNotification("Debes estar en un vehículo")
					end
				elseif CurrentAction == 'car_store_point' then
					if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAQuadbike(model) then
						if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
							StoreOwnedCarsMenu()
						else
							ESX.ShowNotification(_U('driver_seat'))
						end
					else
						ESX.ShowNotification(_U('not_correct_veh'))
					end
				elseif CurrentAction == 'car_pound_point' then
					ReturnOwnedCarsMenu()
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Create Blips
function CreateBlips()
	if Config.Aircrafts.Garages and Config.Aircrafts.Blips then
		for k,v in pairs(Config.AircraftGarages) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Garages.Sprite)
			SetBlipColour (blip, Config.Blips.Garages.Color)
			SetBlipDisplay(blip, Config.Blips.Garages.Display)
			SetBlipScale  (blip, Config.Blips.Garages.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_garage'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.AircraftPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Pounds.Sprite)
			SetBlipColour (blip, Config.Blips.Pounds.Color)
			SetBlipDisplay(blip, Config.Blips.Pounds.Display)
			SetBlipScale  (blip, Config.Blips.Pounds.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_pound'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end

	if Config.Boats.Garages and Config.Boats.Blips then
		for k,v in pairs(Config.BoatGarages) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Garages.Sprite)
			SetBlipColour (blip, Config.Blips.Garages.Color)
			SetBlipDisplay(blip, Config.Blips.Garages.Display)
			SetBlipScale  (blip, Config.Blips.Garages.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_garage'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.BoatPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Pounds.Sprite)
			SetBlipColour (blip, Config.Blips.Pounds.Color)
			SetBlipDisplay(blip, Config.Blips.Pounds.Display)
			SetBlipScale  (blip, Config.Blips.Pounds.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_pound'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end

	if Config.Cars.Garages and Config.Cars.Blips then
		for k,v in pairs(Config.CarGarages) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Garages.Sprite)
			SetBlipColour (blip, Config.Blips.Garages.Color)
			SetBlipDisplay(blip, Config.Blips.Garages.Display)
			SetBlipScale  (blip, Config.Blips.Garages.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_garage'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.CarPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.Blips.Pounds.Sprite)
			SetBlipColour (blip, Config.Blips.Pounds.Color)
			SetBlipDisplay(blip, Config.Blips.Pounds.Display)
			SetBlipScale  (blip, Config.Blips.Pounds.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_pound'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end
end
