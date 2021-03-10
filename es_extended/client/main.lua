
local isLoadoutLoaded, isPaused, isPlayerSpawned, isDead = false, false, false, false
local lastLoadout, pickups = {}, {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerLoaded = true
	ESX.PlayerData = xPlayer
	if xPlayer then
		if xPlayer.rolename=="" or xPlayer.rolename==" " then
			--TriggerEvent('esx_skin:firstJoin')
			TriggerEvent('esx_identity:showRegisterIdentity', source)
			--TriggerEvent('esx_skin:openSaveathecrowsrp2bleMenu', myIdentifiers.id)
		end
	end
	
	TriggerEvent('es:setMoneyDisplay', 0.0)
	
end)

AddEventHandler('playerSpawned', function()
	while not ESX.PlayerLoaded do
		Citizen.Wait(1)
	end

	local playerPed = PlayerPedId()

	-- Restore position
	if ESX.PlayerData.lastPosition then
		SetEntityCoords(playerPed, ESX.PlayerData.lastPosition.x, ESX.PlayerData.lastPosition.y, ESX.PlayerData.lastPosition.z)
	end

	TriggerEvent('esx:restoreLoadout') -- restore loadout

	isLoadoutLoaded = true
	isPlayerSpawned = true
	isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

AddEventHandler('skinchanger:loadDefaultModel', function()
	isLoadoutLoaded = false
end)

AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Citizen.Wait(1)
	end

	TriggerEvent('esx:restoreLoadout')
end)

AddEventHandler('esx:restoreLoadout', function()
	local playerPed = PlayerPedId()
	local ammoTypes = {}

	RemoveAllPedWeapons(playerPed, true)

	for k,v in ipairs(ESX.PlayerData.loadout) do
		local weaponName = v.name
		local weaponHash = GetHashKey(weaponName)

		GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
		local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

		for k2,v2 in ipairs(v.components) do
			local componentHash = ESX.GetWeaponComponent(weaponName, v2).hash

			GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
		end

		if not ammoTypes[ammoType] then
			AddAmmoToPed(playerPed, weaponHash, v.ammo)
			ammoTypes[ammoType] = true
		end
	end

	isLoadoutLoaded = true
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for k,v in ipairs(ESX.PlayerData.accounts) do
		if v.name == account.name then
			ESX.PlayerData.accounts[k] = account
			break
		end
	end

	if Config.EnableHud then
		ESX.UI.HUD.UpdateElement('account_' .. account.name, {
			money = ESX.Math.GroupDigits(account.money)
		})
	end
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(money)
	ESX.PlayerData.money = money
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
	if(item~="cash")then
		for k,v in ipairs(ESX.PlayerData.inventory) do
			if v.name == item.name then
				ESX.PlayerData.inventory[k] = item
				break
			end
		end
	end

	ESX.UI.ShowInventoryItemNotification(true, item, count)

	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
	for k,v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item.name then
			ESX.PlayerData.inventory[k] = item
			break
		end
	end

	ESX.UI.ShowInventoryItemNotification(false, item, count)

	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function(weaponName, ammo)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
	--AddAmmoToPed(playerPed, weaponHash, ammo) possibly not needed
end)

RegisterNetEvent('esx:addWeaponComponent')
AddEventHandler('esx:addWeaponComponent', function(weaponName, weaponComponent)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function(weaponName, ammo)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	RemoveWeaponFromPed(playerPed, weaponHash)

	if ammo then
		local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
		local finalAmmo = math.floor(pedAmmo - ammo)
		SetPedAmmo(playerPed, weaponHash, finalAmmo)
	else
		SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
	end
end)


RegisterNetEvent('esx:removeWeaponComponent')
AddEventHandler('esx:removeWeaponComponent', function(weaponName, weaponComponent)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
end)

-- Commands
RegisterNetEvent('esx:teleport')
AddEventHandler('esx:teleport', function(pos)
	pos.x = pos.x + 0.0
	pos.y = pos.y + 0.0
	pos.z = pos.z + 0.0

	RequestCollisionAtCoord(pos.x, pos.y, pos.z)

	while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
		RequestCollisionAtCoord(pos.x, pos.y, pos.z)
		Citizen.Wait(1)
	end

	SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if Config.EnableHud then
		ESX.UI.HUD.UpdateElement('job', {
			job_label   = job.label,
			grade_label = job.grade_label
		})
	end
end)

RegisterNetEvent('esx:loadIPL')
AddEventHandler('esx:loadIPL', function(name)
	Citizen.CreateThread(function()
		LoadMpDlcMaps()
		RequestIpl(name)
	end)
end)

RegisterNetEvent('esx:unloadIPL')
AddEventHandler('esx:unloadIPL', function(name)
	Citizen.CreateThread(function()
		RemoveIpl(name)
	end)
end)

RegisterNetEvent('esx:playAnim')
AddEventHandler('esx:playAnim', function(dict, anim)
	Citizen.CreateThread(function()
		local playerPed = PlayerPedId()
		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end

		TaskPlayAnim(playerPed, dict, anim, 1.0, -1.0, 20000, 0, 1, true, true, true)
	end)
end)

RegisterNetEvent('esx:playEmote')
AddEventHandler('esx:playEmote', function(emote)
	Citizen.CreateThread(function()

		local playerPed = PlayerPedId()

		TaskStartScenarioInPlace(playerPed, emote, 0, false);
		Citizen.Wait(20000)
		ClearPedTasks(playerPed)

	end)
end)

RegisterNetEvent('esx:spawnVehicle')
AddEventHandler('esx:spawnVehicle', function(model)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
	end)
end)


RegisterNetEvent('esx:spawnObject')
AddEventHandler('esx:spawnObject', function(model)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local forward   = GetEntityForwardVector(playerPed)
	--local coords = vector3(2195.2912597656, 5595.16796875, 53.757919311523)
	--local forward = vector3(0.968674, -0.2483359, 0)
	local x, y, z   = table.unpack(coords + forward * 1.0)

	print("x:"..x.." y:"..y.." z:"..z)
	print("forard: "..forward)
	print("heading: "..GetEntityHeading(playerPed))
	ESX.Game.SpawnObject(model, {
		x = x,
		y = y,
		z = z
	}, function(obj)
		SetEntityHeading(obj, GetEntityHeading(playerPed))
		PlaceObjectOnGroundProperly(obj)
	end)
end)

RegisterNetEvent('esx:pickup')
AddEventHandler('esx:pickup', function(id, label, player)
	local ped     = GetPlayerPed(GetPlayerFromServerId(player))
	local coords  = GetEntityCoords(ped)
	local forward = GetEntityForwardVector(ped)
	local x, y, z = table.unpack(coords + forward * -2.0)

	ESX.Game.SpawnLocalObject('prop_money_bag_01', {
		x = x,
		y = y,
		z = z - 2.0,
	}, function(obj)
		SetEntityAsMissionEntity(obj, true, false)
		PlaceObjectOnGroundProperly(obj)

		pickups[id] = {
			id = id,
			obj = obj,
			label = label,
			inRange = false,
			coords = {
				x = x,
				y = y,
				z = z
			}
		}
	end)
end)

RegisterNetEvent('esx:removePickup')
AddEventHandler('esx:removePickup', function(id)
	ESX.Game.DeleteObject(pickups[id].obj)
	pickups[id] = nil
end)

RegisterNetEvent('esx:pickupWeapon')
AddEventHandler('esx:pickupWeapon', function(weaponPickup, weaponName, ammo)
	local playerPed = PlayerPedId()
	local pickupCoords = GetOffsetFromEntityInWorldCoords(playerPed, 2.0, 0.0, 0.5)
	local weaponHash = GetHashKey(weaponPickup)

	CreateAmbientPickup(weaponHash, pickupCoords, 0, ammo, 1, false, true)
end)

RegisterNetEvent('esx:spawnPed')
AddEventHandler('esx:spawnPed', function(model)
	model           = (tonumber(model) ~= nil and tonumber(model) or GetHashKey(model))
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local forward   = GetEntityForwardVector(playerPed)
	local x, y, z   = table.unpack(coords + forward * 1.0)

	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(1)
		end

		CreatePed(5, model, x, y, z, 0.0, true, false)
	end)
end)

RegisterNetEvent('esx:deleteVehicle')
AddEventHandler('esx:deleteVehicle', function(plate, bypass)
	if plate then
		for vehicle in EnumerateVehicles() do
			if ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)) == tostring(plate) then
				if bypass then
					if NetworkGetNetworkIdFromEntity(vehicle) ~= bypass then
						ESX.Game.DeleteEntity(vehicle,true)
					end
				else
					ESX.Game.DeleteEntity(vehicle,true)
				end
			end
		end
	else
		local vehicle, distance = ESX.Game.GetClosestVehicle()
		
		if distance ~= -1 and distance <= 5.0 and DoesEntityExist(vehicle) then
			ESX.Game.DeleteEntity(vehicle, true)
		end
	end
end)

local blips,blipList = false,{}

RegisterNetEvent('esx:toggleBlips')
AddEventHandler('esx:toggleBlips',function()
	if not blips then
		for vehicle in EnumerateVehicles() do
			local blip = AddBlipForEntity(vehicle)
			SetBlipSprite(blip,56)
			table.insert(blipList,blip)
		end
		blips=true
	else 
		for k,v in pairs(blipList) do
			RemoveBlip(v)
		end
		blips=false
	end
end)

--[[RegisterNetEvent('esx:deleteVehicle')
AddEventHandler('esx:deleteVehicle', function(radius)
	local playerPed = PlayerPedId()

	if radius and tonumber(radius) then
		radius = tonumber(radius) + 0.01
		local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerPed), radius)

		for k,entity in ipairs(vehicles) do
			local attempt = 0

			while not NetworkHasControlOfEntity(entity) and attempt < 100 and DoesEntityExist(entity) do
				Citizen.Wait(100)
				NetworkRequestControlOfEntity(entity)
				attempt = attempt + 1
			end

			if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
				ESX.Game.DeleteVehicle(entity)
			end
		end
	else
		local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0

		if IsPedInAnyVehicle(playerPed, true) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		end

		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(vehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			ESX.Game.DeleteVehicle(vehicle)
		end
	end
end)]]

-- Pause menu disable HUD display
if Config.EnableHud then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(300)

			if IsPauseMenuActive() and not isPaused then
				isPaused = true
				TriggerEvent('es:setMoneyDisplay', 0.0)
				ESX.UI.HUD.SetDisplay(0.0)
			elseif not IsPauseMenuActive() and isPaused then
				isPaused = false
				TriggerEvent('es:setMoneyDisplay', 1.0)
				ESX.UI.HUD.SetDisplay(1.0)
			end
		end
	end)
end

-- Save loadout
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)

		local playerPed      = PlayerPedId()
		local loadout        = {}
		local loadoutChanged = false

		if IsPedDeadOrDying(playerPed) then
			isLoadoutLoaded = false
		end

		for k,v in ipairs(Config.Weapons) do
			local weaponName = v.name
			local weaponHash = GetHashKey(weaponName)
			local weaponComponents = {}

			if HasPedGotWeapon(playerPed, weaponHash, false) and weaponName ~= 'WEAPON_UNARMED' then
				local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)

				for k2,v2 in ipairs(v.components) do
					if HasPedGotWeaponComponent(playerPed, weaponHash, v2.hash) then
						table.insert(weaponComponents, v2.name)
					end
				end

				if not lastLoadout[weaponName] or lastLoadout[weaponName] ~= ammo then
					loadoutChanged = true
				end

				lastLoadout[weaponName] = ammo

				table.insert(loadout, {
					name = weaponName,
					ammo = ammo,
					label = v.label,
					components = weaponComponents
				})
			else
				if lastLoadout[weaponName] then
					loadoutChanged = true
				end

				lastLoadout[weaponName] = nil
			end
		end

		if loadoutChanged and isLoadoutLoaded then
			ESX.PlayerData.loadout = loadout
			TriggerServerEvent('esx:updateLoadout', loadout)
		end
	end
end)

--[[Menu interactions


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, 289) and IsInputDisabled(0) and not isDead and not ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
			ESX.ShowInventory()
		end
	end
end)]]


-- Disable wanted level
if Config.DisableWantedLevel then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)

			local playerId = ESX.GetPlayerId()
			if GetPlayerWantedLevel(playerId) ~= 0 then
				SetPlayerWantedLevel(playerId, 0, false)
				SetPlayerWantedLevelNow(playerId, false)
			end
		end
	end)
end

-- Last position
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local playerPed = ESX.GetPlayerPed()

		if ESX.PlayerLoaded and isPlayerSpawned then
			local coords = GetEntityCoords(playerPed)

			if not IsEntityDead(playerPed) then
				ESX.PlayerData.lastPosition = {x = coords.x, y = coords.y, z = coords.z}
			end
		end

		if IsEntityDead(playerPed) and isPlayerSpawned then
			isPlayerSpawned = false
		end
	end
end)

-- SISTEMA DE NIVELES
RegisterNetEvent('esx:addLevel')
AddEventHandler('esx:addLevel', function()
    ESX.PlayerData.level=ESX.PlayerData.level+1
end)