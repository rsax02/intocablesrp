ESX = nil
ped=nil
isDead=false
vehicle=nil
inVehicle=false
isArmed=false
driving=false
local playerGender

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	TriggerEvent('skinchanger:getSkin', function(skin)
		playerGender = skin.sex
	end)
end)

function IsAbleToSteal(targetSID, err)
	local playerCoords = GetEntityCoords(ped)
	local streetName1 = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z) 
	local streetName = GetStreetNameFromHashKey(streetName1)
	ESX.TriggerServerCallback('esx_thief:getValue', function(result)
		local result = result
		if result.value then
			err(false)
		elseif result.level1 then
			err("No tienes nivel suficiente para robar")
		elseif result.level2 then
			err("El asaltado no tiene el nivel suficiente")
		elseif result.police then
			err("Se necesitan ~y~4 ~w~policias en servicio para robar")
		elseif result.wait then
			err("Tienes que esperar para robar nuevamente")
		else
			err(_U('no_hands_up'))
		end
	end, targetSID, playerGender, streetName,playerCoords
)
end

function OpenStealMenu(target, target_id)
	ESX.UI.Menu.CloseAll()

	ESX.TriggerServerCallback('esx_thief:getOtherPlayerData', function(data)
		local elements = {}

		if Config.EnableCash then
			if data.money<0 then
				data.money=0
			end
			table.insert(elements, {
				label = (('%s $%s'):format(_U('cash'), ESX.Math.GroupDigits(data.money))),
				value = 'money',
				type = 'item_money',
				amount = data.money
			})
		end

		if Config.EnableBlackMoney then
			local blackMoney = 0

			for i=1, #data.accounts, 1 do
				if data.accounts[i].name == 'black_money' then
					blackMoney = data.accounts[i].money
					break
				end
			end

			table.insert(elements, {
				label = (('%s $%s'):format(_U('black_money'), ESX.Math.GroupDigits(blackMoney))),
				value = 'black_money',
				type = 'item_account',
				amount = blackMoney
			})
		end

		if Config.EnableInventory then
			for i=1, #data.inventory, 1 do
				if data.inventory[i].count > 0 then
					table.insert(elements, {
						label = data.inventory[i].label .. ' x' .. data.inventory[i].count,
						value = data.inventory[i].name,
						type  = 'item_standard',
						amount = data.inventory[i].count,
					})
				end
			end
		end

		if Config.EnableWeapons then
		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = ESX.GetWeaponLabel(data.weapons[i].name) .." x".. data.weapons[i].ammo..' balas',
				value    = data.weapons[i].name,
				type = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

	end	
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'steal_inventory', {
			title  = _U('target_inventory'),
			elements = elements,
			align = 'top-left'
		}, function(data, menu)

			if data.current.value ~= nil then

				local itemType = data.current.type
				local itemName = data.current.value
				local amount   = data.current.amount
				local elements = {}
				table.insert(elements, {label = _U('steal'), action = 'steal', itemType, itemName, amount})
				table.insert(elements, {label = _U('return'), action = 'return'})

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'steal_inventory_item', {
					title = _U('action_choice'),
					align = 'top-left',
					elements = elements
				}, function(data2, menu2)
					if data2.current.action == 'steal' then
						if itemType == 'item_standard' then
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'steal_inventory_item_standard', {
								title = _U('amount')
							}, function(data3, menu3)
								local quantity = tonumber(data3.value)
								
								TriggerServerEvent('esx_thief:stealPlayerItem', GetPlayerServerId(target), itemType, itemName, quantity)
								OpenStealMenu(target)
							
								menu3.close()
								menu2.close()
							end, function(data3, menu3)
								menu3.close()
							end)
						else
							TriggerServerEvent('esx_thief:stealPlayerItem', GetPlayerServerId(target), itemType, itemName, amount)
							OpenStealMenu(target)
						end

					elseif data2.current.action == 'return' then
						ESX.UI.Menu.CloseAll()
						OpenStealMenu(target)
					end

				end, function(data2, menu2)
					menu2.close()
				end)
			end

		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(target))
end

Citizen.CreateThread(function()
	while true do
	ped=PlayerPedId()
	Citizen.Wait(3000)
	end
end)

Citizen.CreateThread(function()
	while true do
		isDead = IsPedDeadOrDying(ped)

		inVehicle = IsPedInAnyVehicle(ped, true)

		if(inVehicle)then
			
		vehicle = GetVehiclePedIsIn(ped,false)
		driving=(GetPedInVehicleSeat(vehicle, -1) == ped)
		end

		isArmed=IsPedArmed(ped,7)
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(25)
		if(inVehicle)then
			if(GetPedInVehicleSeat(vehicle, -1) == ped)then
				SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
			else
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(6)
		if not (inVehicle) and not isDead and isArmed then
			if IsControlJustPressed(0, 47) then
				local target, distance = ESX.Game.GetClosestPlayer()

				if target ~= -1 and distance ~= -1 and distance <= 2.0 then
					local target_id = GetPlayerServerId(target)
					
					IsAbleToSteal(target_id, function(err)
						if(not err)then
							OpenStealMenu(target, target_id)
						else
							ESX.ShowNotification(err)
						end
					end)
				elseif distance < 20 and distance > 2.0 then
					ESX.ShowNotification(_U('too_far'))
				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end
		else
			Citizen.Wait(1000)
		end
	end
end)
