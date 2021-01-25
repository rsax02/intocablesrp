ESX = nil
local IsCarring = 0
local IsBeingCarried = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_carry:carry')
AddEventHandler('esx_carry:carry',function()
	if IsEntityInAir(GetPlayerPed(-1)) then return end
	liftup()
end)

local player,ped
Citizen.CreateThread(function()
	while true do
		player=PlayerId()
		ped=PlayerPedId()
		Citizen.Wait(1000)
	end
end)

RegisterCommand('carry', function()
	if IsEntityInAir(ped) or IsEntityDead(ped) then return end
	liftup()
end)

function liftup()
	if not IsBeingCarried then
		local player, distance = ESX.Game.GetClosestPlayer()
		if player and distance then
		end
		if distance ~= -1 and distance <= 3.0 then
			if IsPedInAnyVehicle(GetPlayerPed(player)) then
				return
			end
			if IsCarring > 0 then
				ClearPedTasksImmediately(PlayerPedId())
				TriggerServerEvent('triggerClientEvent', GetPlayerServerId(player), "liftup:setstate", GetPlayerServerId(PlayerId()))
				IsCarring = 0
			else
				ESX.Streaming.RequestAnimDict("anim@heists@box_carry@", function()
					TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
				end)
				TriggerServerEvent('triggerClientEvent', GetPlayerServerId(player), "liftup:setstate", GetPlayerServerId(PlayerId()))
				IsCarring = GetPlayerServerId(player)
			end
		else
			if IsCarring > 0 then
				ClearPedTasksImmediately(PlayerPedId())
				IsCarring = 0
			end
			ESX.ShowNotification('No hay jugadores cerca')
		end
	end
end

RegisterNetEvent("liftup:setstate")
AddEventHandler("liftup:setstate", function(target)
	local ped = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	if targetPed ~= -1 then
		if IsBeingCarried then
			DetachEntity(ped, true, false)
			ClearPedTasksImmediately(ped)
			ClearPedTasksImmediately(targetPed)
		else
			ESX.Streaming.RequestAnimDict("amb@code_human_in_car_idles@generic@ps@base", function()
				TaskPlayAnim(ped, "amb@code_human_in_car_idles@generic@ps@base", "base", 8.0, -8, -1, 33, 0, 0, 40, 0)
			end)
			AttachEntityToEntity(ped, targetPed, 9816, 0.015, 0.38, 0.11, 0.9, 0.30, 90.0, false, false, false, false, 2, false)
		end
		IsBeingCarried = not IsBeingCarried
		TriggerEvent('esx_carry:carried')
	end
end)



Citizen.CreateThread(function()
	local player = PlayerId()
	local ped = PlayerPedId()
	while true do
		Citizen.Wait(5)

		if IsBeingCarried then
			if not IsEntityPlayingAnim(ped, "amb@code_human_in_car_idles@generic@ps@base", "base", 3) then
				ESX.Streaming.RequestAnimDict("amb@code_human_in_car_idles@generic@ps@base", function(dict)
					TaskPlayAnim(ped, dict, "base", 8.0, -8, -1, 33, 0, 0, 40, 0)
				end)
			end
			DisablePlayerFiring(player, true)
		elseif IsCarring > 0 then
			if IsPedFatallyInjured(ped) then
				TriggerServerEvent('esx:triggerClientEvent', IsCarring, "liftup:setstate", GetPlayerServerId(player))
				IsCarring = 0
			else
				if not IsEntityPlayingAnim(ped, "anim@heists@box_carry@", "idle", 3) then
					ESX.Streaming.RequestAnimDict("anim@heists@box_carry@", function(dict)
						TaskPlayAnim(ped, dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
					end)
				end
				DisablePlayerFiring(player, true)
			end
		else
			Citizen.Wait(600)
		end
	end
end)
