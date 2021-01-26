ESX = nil
local Status, isPaused = {}, false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function GetStatusData(minimal)
	local status = {}

	for i=1, #Status, 1 do
		if minimal then
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				percent = (Status[i].val / Config.StatusMax) * 100
			})
		else
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				color   = Status[i].color,
				visible = Status[i].visible(Status[i]),
				max     = Status[i].max,
				percent = (Status[i].val / Config.StatusMax) * 100
			})
		end
	end

	return status
end

AddEventHandler('esx_status:registerStatus', function(name, default, color, visible, tickCallback)
	local status = CreateStatus(name, default, color, visible, tickCallback)
	table.insert(Status, status)
end)

AddEventHandler('esx_status:unregisterStatus', function(name)
	for k,v in ipairs(Status) do
		if v.name == name then
			table.remove(Status, k)
			break
		end
	end
end)

local armour,health

RegisterNetEvent('esx_status:load')
AddEventHandler('esx_status:load', function(status)
	--TriggerEvent('esx_status:loaded')
	for i=1, #Status, 1 do
		for j=1, #status, 1 do
			if(status[j].name=="armour") then
				armour=status[j].value
			elseif(status[j].name=="health")then
				health=status[j].value
			elseif Status[i].name == status[j].name then
				Status[i].set(status[j].val)
			end
		end
	end

	Citizen.CreateThread(function()
		while true do
			for i=1, #Status, 1 do
				Status[i].onTick()
			end

			SendNUIMessage({
				update = true,
				status = GetStatusData()
			})

			TriggerEvent('esx_status:onTick', GetStatusData(true))
			Citizen.Wait(Config.TickTime)
		end
	end)
end)

local first = true
AddEventHandler('skinchanger:modelLoaded',function()
	if(first==true)then
		if(health~=nil and armour~=nil)then
			if health==100 then health=200 end
			if health==0 then health=100 end
			SetEntityHealth(PlayerPedId(),health)
			SetPedArmour(PlayerPedId(),armour)
			first=false
		end
	end
end)

RegisterNetEvent('esx_status:set')
AddEventHandler('esx_status:set', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].set(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('esx_status:update', GetStatusData(true))
end)

RegisterNetEvent('esx_status:add')
AddEventHandler('esx_status:add', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].add(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('esx_status:update', GetStatusData(true))
end)

RegisterNetEvent('esx_status:remove')
AddEventHandler('esx_status:remove', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].remove(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('esx_status:update', GetStatusData(true))
end)

AddEventHandler('esx_status:getStatus', function(name, cb)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			cb(Status[i])
			return
		end
	end
end)

AddEventHandler('esx_status:setDisplay', function(val)
	SendNUIMessage({
		setDisplay = true,
		display    = val
	})
end)

-- Pause menu disable hud display
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		if IsPauseMenuActive() and not isPaused then
			isPaused = true
			TriggerEvent('esx_status:setDisplay', 0.0)
		elseif not IsPauseMenuActive() and isPaused then
			isPaused = false 
			TriggerEvent('esx_status:setDisplay', 1)
		end
	end
end)

--mierda
Citizen.CreateThread(function()
	TriggerEvent('esx_status:loaded')
end)

-- Update server
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.UpdateInterval)

		TriggerServerEvent('esx_status:update', GetStatusData(true))
	end
end)

-- Healty status bars
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
		
        SendNUIMessage({
            health = GetEntityHealth(GetPlayerPed(-1)) - 100,
            armor = GetPedArmour(GetPlayerPed(-1)),
            stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
			diving = 2.5 * GetPlayerUnderwaterTimeRemaining(PlayerId())
        })
    end
end)
