ESX = nil
local holstered = true
local blocked = false
local isDriving, ped
local PlayerData = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		ped = PlayerPedId()
		isDriving = IsPedInAnyVehicle(ped,false)
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	loadAnimDict("rcmjosh4")
	loadAnimDict("reaction@intimidation@cop@unarmed")
	loadAnimDict("reaction@intimidation@1h")
	while true do
		Citizen.Wait(2)
		
		if not IsEntityInAir(ped) and GetEntityAttachedTo(ped) == 0 then
			if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
				if not IsPedInAnyVehicle(ped, false) then
					if GetVehiclePedIsTryingToEnter(ped) == 0 and not IsPedInParachuteFreeFall(ped) then
						if CheckWeapon(ped) then
							if holstered then
								blocked = true
								TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0) -- Change 50 to 30 if you want to stand still when removing weapon
								Citizen.Wait(Config.CooldownPolice)
								TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
								Citizen.Wait(400)
								ClearPedTasks(ped)
								holstered = false
							else
								blocked = false
							end
						else
							if not holstered then
								TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
								Citizen.Wait(500)
								TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0) -- Change 50 to 30 if you want to stand still when holstering weapon
								Citizen.Wait(60)
								ClearPedTasks(ped)
								holstered = true
							end
						end
					else
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
					end
				else
					holstered = true
				end
			else
				if not IsPedInAnyVehicle(ped, false) then
					if GetVehiclePedIsTryingToEnter(ped) == 0 and not IsPedInParachuteFreeFall(ped) then
						if CheckWeapon(ped) then
							if holstered then
								blocked = true
								TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 50, 0, 0, 0, 0)
								Citizen.Wait(Config.cooldown)
								ClearPedTasks(ped)
								holstered = false
							else
								blocked = false
							end
						else
							if not holstered then
								TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 50, 0, 0, 0.125, 0) -- Change 50 to 30 if you want to stand still when holstering weapon
								Citizen.Wait(1700)
								ClearPedTasks(ped)
								holstered = true
							end
						end
					else
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
					end
				else
					holstered = true
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		if(not isDriving)then
			if blocked then
				DisableControlAction(1, 25, true)
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
				DisableControlAction(1, 23, true)
				DisableControlAction(1, 37, true)
				DisablePlayerFiring(ped, true)
			end
		else
			Citizen.Wait(500)
		end
	end
end)


function CheckWeapon(ped)
	if IsEntityDead(ped) then
		blocked = false
		return false
	else
		for i = 1, #Config.Weapons do if GetHashKey(Config.Weapons[i]) == GetSelectedPedWeapon(ped) then return true end end
		return false
	end
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end
