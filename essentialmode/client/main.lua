--       Licensed under: AGPLv3        --
--  GNU AFFERO GENERAL PUBLIC LICENSE  --
--     Version 3, 19 November 2007     --

local enablePositionSending = true
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsSessionStarted() then
			TriggerServerEvent('es:firstJoinProper')
			TriggerEvent('es:allowedToSpawn')
			return
		end
	end
end)

TriggerServerEvent('es:firstJoinProper')

local oldPos

Citizen.CreateThread(function()
	while enablePositionSending do
		Citizen.Wait(3000)
		local pos = GetEntityCoords(PlayerPedId())
		if not oldPos then
			TriggerServerEvent('es:updatePositions', pos.x, pos.y, pos.z)
			oldPos = pos
		elseif #(oldPos-pos)>10.0 then
			TriggerServerEvent('es:updatePositions', pos.x, pos.y, pos.z)
			oldPos = pos
		end
	end
end)

local myDecorators = {}

RegisterNetEvent("es:setPlayerDecorator")
AddEventHandler("es:setPlayerDecorator", function(key, value, doNow)
	myDecorators[key] = value
	DecorRegister(key, 3)

	if(doNow)then
		DecorSetInt(PlayerPedId(), key, value)
	end
end)

AddEventHandler("playerSpawned", function()
	for k,v in pairs(myDecorators)do
		DecorSetInt(PlayerPedId(), k, v)
	end

	TriggerServerEvent('playerSpawn')
end)

RegisterNetEvent("es:disableClientPosition")
AddEventHandler("es:disableClientPosition", function()
	enablePositionSending = false
end)

local ped
Citizen.CreateThread(function()
	while true do
		ped=PlayerPedId()
		Wait(500)
	end
end)

--esto es para renguear--
local hurt = false
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if GetEntityHealth(ped) <= 140 then
			setHurt()
			DisableControlAction(0,22,true)
        elseif hurt and GetEntityHealth(ped) > 141 then
			setNotHurt()
			DisableControlAction(0,22,false)
        end
		if IsPedArmed(ped, 6) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
        end
    end
end)



function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

function setNotHurt()
    hurt = false
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end

--Esto es para activar o desactivar el pvp--
AddEventHandler("playerSpawned", function()
	Citizen.CreateThread(function()
  
	  local player = PlayerId()
	  local playerPed = ped
  
	  -- Enable pvp
	  NetworkSetFriendlyFireOption(true)
	  SetCanAttackFriendly(playerPed, true, true)
  
	end)
  end)
