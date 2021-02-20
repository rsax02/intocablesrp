ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do		
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(15)
	end
end)

local group = "user"
local states = {}
states.frozen = false
states.frozenPos = nil

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false)
end)

RegisterNUICallback('quick', function(data, cb)
	if data.type == "slay_all" or data.type == "bring_all" or data.type == "slap_all" then
		TriggerServerEvent('es_admin:all', data.type)
	else
		TriggerServerEvent('es_admin:quick', data.id, data.type)
	end
end)

RegisterNUICallback('set', function(data, cb)
	TriggerServerEvent('es_admin:set', data.type, data.user, data.param)
end)

RegisterNetEvent('es_admin:heal')
AddEventHandler('es_admin:heal',function()
	SetEntityHealth(PlayerPedId(),GetEntityMaxHealth(PlayerPedId()))
end)

RegisterNetEvent('es_admin:giveWeapon')
AddEventHandler('es_admin:giveWeapon',function()
	local ped = PlayerPedId()
	if(not HasPedGotWeapon(ped,GetHashKey('weapon_snspistol'))) then
		GiveWeaponToPed(ped,GetHashKey("weapon_snspistol"),250,false,false)
	end
end)

local noclip = false
RegisterNetEvent('es_admin:quick')
AddEventHandler('es_admin:quick', function(t, target)
	if t == "slay" then SetEntityHealth(PlayerPedId(), 0) end
	if t == "goto" then SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) end
	if t == "bring" then 
		states.frozenPos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))
		SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) 
	end
	if t == "crash" then 
		Citizen.Trace("You're being crashed, so you know. This server sucks.\n")
		Citizen.CreateThread(function()
			while true do end
		end) 
	end
	if t == "slap" then ApplyForceToEntity(PlayerPedId(), 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false) end
	if t == "noclip" then
		local msg = "disabled"
		if(noclip == false)then
			noclip_pos = GetEntityCoords(PlayerPedId(), false)
		end

		noclip = not noclip

		if(noclip)then
			msg = "enabled"
		end

		TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
	end
	if t == "freeze" then
		local player = PlayerId()

		local ped = PlayerPedId()

		states.frozen = not states.frozen
		states.frozenPos = GetEntityCoords(ped, false)

		if not state then
			if not IsEntityVisible(ped) then
				SetEntityVisible(ped, true)
			end

			if not IsPedInAnyVehicle(ped) then
				SetEntityCollision(ped, true)
			end

			FreezeEntityPosition(ped, false)
			SetPlayerInvincible(player, false)
		else
			SetEntityCollision(ped, false)
			FreezeEntityPosition(ped, true)
			SetPlayerInvincible(player, true)

			if not IsPedFatallyInjured(ped) then
				ClearPedTasksImmediately(ped)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if(states.frozen)then
			ClearPedTasksImmediately(PlayerPedId())
			SetEntityCoords(PlayerPedId(), states.frozenPos)
		else
			Citizen.Wait(200)
		end
	end
end)

local heading = 0

RegisterNetEvent('es_admin:information')
AddEventHandler('es_admin:information', function(data)
	local jobLabel = nil
	local sexLabel = nil
	local sex = nil
	local dobLabel = nil
	local idLabel = nil
	local Money = 0
	local Bank = 0
	local blackMoney = 0
	local Inventory = nil

	if data.job.grade_label ~= nil and data.job.grade_label ~= '' then
		jobLabel = 'Job: ' .. data.job.label .. ' - ' .. data.job.grade_label
	else
		jobLabel = 'Job: ' .. data.job.label
	end
	if data.sex ~= nil then
		if (data.sex == 'm') or (data.sex == 'M') then
			sex = 'Male'
		else
			sex = 'Female'
		end
		sexLabel = 'Sex: ' .. sex
	else
		sexLabel = 'Sex: Unknown'
	end
	if data.money ~= nil then
		Money = data.money
	else
		Money = 'No Data'
	end
	if data.bank ~= nil then
		Bank = data.bank
	else
		Bank = 'No Data'
	end
	if data.black then
		blackMoney = data.black
	else
		blackMoney = 'No Data'
	end
	if data.dob ~= nil then
		dobLabel = 'DOB: ' .. data.dob
	else
		dobLabel = 'DOB: Unknown'
	end
	if data.steam ~= nil then
		idLabel = 'Steam Name: ' .. data.steam
	else
		idLabel = 'Steam Name: Unknown'
	end
	local elements = {
		{label = 'Name: ' .. data.rolename, value = nil},
		{label = 'Money: ' .. data.money, value = nil},
		{label = 'Bank: ' .. data.bank, value = nil},
		{label = 'Black Money: ' .. blackMoney, value = nil, itemType = 'item_account', amount = blackMoney},
		{label = 'Level: ' .. data.level, value = nil},
		{label = jobLabel, value = nil},
		{label = idLabel, value = nil}
	}

	ESX.TriggerServerCallback('esx_donations:getPlayerTokens',function(tokens)
		table.insert(elements,{
			label="Tokens: "..tokens
		})
		
		table.insert(elements, {label = 'Inventory:', value = nil})
		for k, v in pairs(data.inventory) do
			if(v.count>0)then
			table.insert(elements, {
				label = v.label .. ' x' .. v.count,
				value = nil,
				itemType = 'item_standard',
				amount = v.count
			})
		end
		end

		table.insert(elements, {label = 'Weapons:', value = nil})
		for k, v in pairs(data.loadout) do
			table.insert(elements, {
				label = v.label.." x"..v.ammo,
				value = nil,
				itemType = 'item_weapon',
				amount = v.ammo
			})
		end
		
		if data.licenses ~= nil then
			table.insert(elements, {label = ' ', value = nil})
			for i = 1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label, value = nil})
			end
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title = 'Informacion [' .. data.source .. ']',
			align = 'top-left',
			elements = elements
		}, function(data, menu)
		end, function(data, menu)
			menu.close()
		end)
	end,data.id)
end)

RegisterNetEvent('es_admin:freezePlayer')
AddEventHandler("es_admin:freezePlayer", function(state)
	local player = PlayerId()

	local ped = PlayerPedId()

	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)

	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)

RegisterNetEvent('es_admin:teleportUser')
AddEventHandler('es_admin:teleportUser', function(x, y, z)
	local player = GetPlayerPed(-1)
	if IsPedInAnyVehicle(player, false)then
		local vehicle = GetVehiclePedIsIn(player, false)
		SetEntityCoordsNoOffset(vehicle, x, y, z, 0, 0, 1)
		TaskWarpPedIntoVehicle(player, vehicle, -1)
	else
		SetEntityCoords(PlayerPedId(), x, y, z)
		states.frozenPos = {x = x, y = y, z = z}
	end
	
end)

RegisterNetEvent('es_admin:slap')
AddEventHandler('es_admin:slap', function()
	local ped = PlayerPedId()

	ApplyForceToEntity(ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent('es_admin:kill')
AddEventHandler('es_admin:kill', function()
	SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('es_admin:heal')
AddEventHandler('es_admin:heal', function()
	SetEntityHealth(PlayerPedId(), 200)
end)

RegisterNetEvent('es_admin:crash')
AddEventHandler('es_admin:crash', function()
	while true do
	end
end)

RegisterNetEvent("es_admin:noclip")
AddEventHandler("es_admin:noclip", function(t)
	local msg = "disabled"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(PlayerPedId(), false)
	end

	noclip = not noclip

	if(noclip)then
		msg = "enabled"
	end

	TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
end)

function getPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        table.insert(players, {id = GetPlayerServerId(player), name = GetPlayerName(player)})
    end
    return players
end


RegisterNetEvent('es_admin:showInService')
AddEventHandler('es_admin:showInService',function(elements)
	ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'service_list', elements, function(data, menu)
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end)

AddTextEntry('FE_THDR_GTAO', 'Intocables RP')
