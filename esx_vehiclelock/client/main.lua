ESX = nil

local isRunningWorkaround = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function StartWorkaroundTask()
	if isRunningWorkaround then
		return
	end

	local timer = 0
	local playerPed = PlayerPedId()
	isRunningWorkaround = true

	while timer < 100 do
		Citizen.Wait(0)
		timer = timer + 1

		local vehicle = GetVehiclePedIsTryingToEnter(playerPed)

		if DoesEntityExist(vehicle) then
			local lockStatus = GetVehicleDoorLockStatus(vehicle)

			if lockStatus == 4 then
				ClearPedTasks(playerPed)
			end
		end
	end

	isRunningWorkaround = false
end

function ToggleVehicleLock()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local vehicle

	Citizen.CreateThread(function()
		StartWorkaroundTask()
	end)

	if IsPedInAnyVehicle(playerPed, false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords, 8.0, 0, 71)
	end

	if not DoesEntityExist(vehicle) then
		return
	end

	ESX.TriggerServerCallback('esx_vehiclelock:requestPlayerCars', function(isOwnedVehicle)
		if isOwnedVehicle or (ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))==tostring(GetPlayerServerId(PlayerId()))) then
			local lockStatus = GetVehicleDoorLockStatus(vehicle)

			if lockStatus == 1 then -- BLOQUEAR
				ESX.Streaming.RequestAnimDict("anim@mp_player_intmenu@key_fob@", function()
					TaskPlayAnim(playerPed, "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
				end)
				SetVehicleDoorsLocked(vehicle, 2)
				PlayVehicleDoorCloseSound(vehicle, 1)
				SetVehicleLights(vehicle, 2)
				Citizen.Wait(150)
				SetVehicleLights(vehicle, 0)
				Citizen.Wait(150)
				SetVehicleLights(vehicle, 2)
				Citizen.Wait(150)
				SetVehicleLights(vehicle, 0)

				TriggerServerEvent('carlock:showNotify3')
				
			elseif lockStatus == 2 then -- DESBLOQUEAR
				ESX.Streaming.RequestAnimDict("anim@mp_player_intmenu@key_fob@", function()
					TaskPlayAnim(playerPed, "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
				end)
				SetVehicleDoorsLocked(vehicle, 1)
				PlayVehicleDoorOpenSound(vehicle, 0)
				SetVehicleLights(vehicle, 2)
				Citizen.Wait(150)
				SetVehicleLights(vehicle, 0)
				Citizen.Wait(150)
				SetVehicleLights(vehicle, 2)
				Citizen.Wait(150)
				SetVehicleLights(vehicle, 0)
				TriggerServerEvent('carlock:showNotify4')
			end
		else
			TriggerServerEvent('carlock:showNotify5')
		end

	end, ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		if IsControlJustReleased(0, 182) and IsInputDisabled(0) then
			ToggleVehicleLock()
			Citizen.Wait(3500)
		end
	end
end)
