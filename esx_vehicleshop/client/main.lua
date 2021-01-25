local HasAlreadyEnteredMarker = false
local LastZone
local CurrentAction
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local CoinsCategories 		  = {}
local CoinsVehicles			  = {}
local LastVehicles            = {}
local CurrentVehicleData

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(15)
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	end

	Citizen.Wait(10000)

	ESX.TriggerServerCallback('esx_vehicleshop:getCategories', function(categories, coinsCategories)
		Categories = categories
		CoinsCategories = coinsCategories
	end)

	ESX.TriggerServerCallback('esx_vehicleshop:getVehicles', function(vehicles, coinsVehicles)
		Vehicles = vehicles
		CoinsVehicles = coinsVehicles
	end)
end)

RegisterNetEvent('esx_vehicleshop:sendCategories')
AddEventHandler('esx_vehicleshop:sendCategories', function(categories, coinCategory)
	Categories = categories
	CoinsCategories=coinCategory
end)

RegisterNetEvent('esx_vehicleshop:sendVehicles')
AddEventHandler('esx_vehicleshop:sendVehicles', function(vehicles, coinVehicle)
	Vehicles = vehicles
	CoinsVehicles=coinVehicle
end)

function DeleteShopInsideVehicles()
	while #LastVehicles > 0 do
		local vehicle = LastVehicles[1]

		ESX.Game.DeleteVehicle(vehicle)
		table.remove(LastVehicles, 1)
	end
end

function StartShopRestriction()
	Citizen.CreateThread(function()
		while IsInShopMenu do
			Citizen.Wait(5)
			DisableControlAction(0, 75,  true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)
end

function OpenCoinsMenu()
	IsInShopMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Coins.ShopInside.Pos)

	local vehiclesByCategory = {}
	local elements           = {}
	local firstVehicleData   = nil
	
	for i=1, #CoinsCategories, 1 do
		vehiclesByCategory[CoinsCategories[i].name] = {}
	end

	for i=1, #CoinsVehicles, 1 do
		if IsModelInCdimage(GetHashKey(CoinsVehicles[i].model)) then
			table.insert(vehiclesByCategory[CoinsVehicles[i].category], CoinsVehicles[i])
		else
			print(('esx_vehicleshop: vehicle "%s" does not exist'):format(CoinsVehicles[i].model))
		end
	end

	for i=1, #CoinsCategories, 1 do
		local category         = CoinsCategories[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options          = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:lightblue;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.insert(elements, {
			name    = category.name,
			label   = category.label,
			value   = 0,
			type    = 'slider',
			max     = #CoinsCategories[i],
			options = options
		})
	end

	local currentVehicleProps

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title    = "Concesionaria Premium",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default',GetCurrentResourceName(),'shop_option',{
			title="Elegir",
			align='top-left',
			elements={
				{label="Test Drive",value="testdrive"},
				{label="Comprar",value="buy"}
			}},function(data3,menu3)
				if data3.current.value=="buy" then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
						title = _U('buy_vehicle_shop_coin', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
						align = 'top-left',
						elements = {
							{label = _U('no'),  value = 'no'},
							{label = _U('yes'), value = 'yes'}
					}}, function(data2, menu2)
						if data2.current.value == 'yes' then
							local playerData = ESX.GetPlayerData()

							ESX.TriggerServerCallback('esx_vehicleshop:buyVehicle', function(hasEnoughMoney)
								if hasEnoughMoney then
									IsInShopMenu = false
									menu2.close()
									menu.close()
									DeleteShopInsideVehicles()

									ESX.Game.SpawnVehicle(vehicleData.model, Config.Coins.ShopOutside.Pos, Config.Coins.ShopOutside.Heading, function(vehicle)
										if currentVehicleProps then
											ESX.Game.SetVehicleProperties(vehicle, currentVehicleProps)
										end
										TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

										local newPlate     = GeneratePlate()
										local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
										local model = GetEntityModel(vehicle)
										vehicleProps.plate = newPlate
										vehicleProps.modelo = vehicleData.model
										SetVehicleNumberPlateText(vehicle, newPlate)

										if Config.EnableOwnedVehicles then
											TriggerServerEvent('esx_vehicleshop:setthecrowsrp2VehicleOwned', vehicleProps)
										end

										ESX.ShowNotification(_U('vehicle_purchased'))
									end)

									FreezeEntityPosition(playerPed, false)
									SetEntityVisible(playerPed, true)
								else
									ESX.ShowNotification("No tienes suficientes tokens")
								end
							end, vehicleData.model, true)
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				else
					menu.close()
					menu3.close()
					DeleteShopInsideVehicles()
					SetEntityCoords(playerPed,Config.TestDrive.Pos)
					Citizen.Wait(250)
					ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.TestDrive.Pos, Config.TestDrive.Heading,function(vehicle)
						if currentVehicleProps then
							ESX.Game.SetVehicleProperties(vehicle, currentVehicleProps)
						end
						TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						SetModelAsNoLongerNeeded(vehicleData.model)
						while true do
							Citizen.Wait(0)
							local shopDistance = #(GetEntityCoords(playerPed)-Config.TestDrive.Pos)
							SetEntityLocallyVisible(playerPed)
							ESX.ShowHelpNotification('Presiona ~INPUT_PICKUP~ para finalizar el test drive', true)
							ESX.Game.Utils.DrawText('~b~Distancia: ~w~' .. math.ceil(shopDistance) .. '/500', 0.25, 0.965)
							if IsControlJustReleased(0,38) or shopDistance > 500.0 then
								SetEntityVisible(playerPed,true)
								ESX.Game.DeleteEntity(vehicle)
								ESX.Game.Teleport(playerPed, Config.Coins.ShopEnteringCoin.Pos)
								IsInShopMenu=false
								break
							end
						end	
					end)
					FreezeEntityPosition(playerPed, false)
				end
			end,function(data3,menu3)
				menu3.close()
			end)
	end, function(data, menu)
		menu.close()
		DeleteShopInsideVehicles()
		local playerPed = PlayerPedId()

		CurrentAction     = 'coin_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Coins.ShopEnteringCoin.Pos)

		IsInShopMenu = false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed   = PlayerPedId()

		DeleteShopInsideVehicles()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Coins.ShopInside.Pos, Config.Coins.ShopInside.Heading, function(vehicle)
			table.insert(LastVehicles, vehicle)
			currentVehicleProps=ESX.Game.GetVehicleProperties(vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteShopInsideVehicles()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Coins.ShopInside.Pos, Config.Coins.ShopInside.Heading, function(vehicle)
		table.insert(LastVehicles, vehicle)
		currentVehicleProps=ESX.Game.GetVehicleProperties(vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

function OpenShopMenu()
	IsInShopMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInside.Pos)

	local vehiclesByCategory = {}
	local elements           = {}
	local firstVehicleData   = nil

	for i=1, #Categories, 1 do
		vehiclesByCategory[Categories[i].name] = {}
	end

	for i=1, #Vehicles, 1 do
		if IsModelInCdimage(GetHashKey(Vehicles[i].model)) then
			table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
		else
			print(('esx_vehicleshop: vehicle "%s" does not exist'):format(Vehicles[i].model))
		end
	end

	for i=1, #Categories, 1 do
		local category         = Categories[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options          = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.insert(elements, {
			name    = category.name,
			label   = category.label,
			value   = 0,
			type    = 'slider',
			max     = #Categories[i],
			options = options
		})
	end

	local currentVehicleProps

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title    = _U('car_dealer'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		ESX.UI.Menu.Open('default',GetCurrentResourceName(),'shop_option',{
			title="Elegir",
			align='top-left',
			elements={
				{label="Test Drive",value="testdrive"},
				{label="Comprar",value="buy"}
			}},function(data3,menu3)
				if data3.current.value=="buy" then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
						title = _U('buy_vehicle_shop', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
						align = 'top-left',
						elements = {
							{label = _U('no'),  value = 'no'},
							{label = _U('yes'), value = 'yes'}
					}}, function(data2, menu2)
						if data2.current.value == 'yes' then
							local playerData = ESX.GetPlayerData()

							ESX.TriggerServerCallback('esx_vehicleshop:buyVehicle', function(hasEnoughMoney)
								if hasEnoughMoney then
									IsInShopMenu = false
									menu2.close()
									menu3.close()
									menu.close()
									DeleteShopInsideVehicles()

									ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function(vehicle)
										if currentVehicleProps then
											ESX.Game.SetVehicleProperties(vehicle, currentVehicleProps)
										end
										TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

										local newPlate     = GeneratePlate()
										local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
										local model = GetEntityModel(vehicle)
										vehicleProps.plate = newPlate
										vehicleProps.modelo = vehicleData.model
										SetVehicleNumberPlateText(vehicle, newPlate)

										if Config.EnableOwnedVehicles then
											TriggerServerEvent('esx_vehicleshop:setthecrowsrp2VehicleOwned', vehicleProps)
										end

										ESX.ShowNotification(_U('vehicle_purchased'))
									end)

									FreezeEntityPosition(playerPed, false)
									SetEntityVisible(playerPed, true)
								else
									ESX.ShowNotification(_U('not_enough_money'))
								end
							end, vehicleData.model,false)
						else
							menu2.close()
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				else
					menu.close()
					menu3.close()
					DeleteShopInsideVehicles()
					SetEntityCoords(playerPed,Config.TestDrive.Pos)
					Citizen.Wait(250)
					ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.TestDrive.Pos, Config.TestDrive.Heading,function(vehicle)
						if currentVehicleProps then
							ESX.Game.SetVehicleProperties(vehicle, currentVehicleProps)
						end
						TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						SetModelAsNoLongerNeeded(vehicleData.model)
						while true do
							Citizen.Wait(0)
							local shopDistance = #(GetEntityCoords(playerPed)-Config.TestDrive.Pos)
							SetEntityLocallyVisible(playerPed)
							ESX.ShowHelpNotification('Presiona ~INPUT_PICKUP~ para finalizar el test drive', true)
							ESX.Game.Utils.DrawText('~b~Distancia: ~w~' .. math.ceil(shopDistance) .. '/500', 0.25, 0.965)
							if IsControlJustReleased(0,38) or shopDistance > 500.0 then
								SetEntityVisible(playerPed, true)
								ESX.Game.DeleteEntity(vehicle)
								ESX.Game.Teleport(playerPed, Config.Zones.ShopEntering.Pos)
								IsInShopMenu=false
								break
							end
						end	
					end)
					--SetEntityVisible(playerPed, true)
					FreezeEntityPosition(playerPed, false)
				end
			end,function(data3,menu3)
				menu3.close()
			end)
	end, function(data, menu)
		menu.close()
		DeleteShopInsideVehicles()
		local playerPed = PlayerPedId()

		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos)

		IsInShopMenu = false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed   = PlayerPedId()

		DeleteShopInsideVehicles()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function(vehicle)
			table.insert(LastVehicles, vehicle)
			currentVehicleProps=ESX.Game.GetVehicleProperties(vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteShopInsideVehicles()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function(vehicle)
		table.insert(LastVehicles, vehicle)
		currentVehicleProps=ESX.Game.GetVehicleProperties(vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyString('STRING')
		AddTextComponentSubstringPlayerName(_U('shop_awaiting_model'))
		EndTextCommandBusyString(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		RemoveLoadingPrompt()
	end
end

local playerCoords, playerPed 
Citizen.CreateThread(function()
	while true do
		playerPed = PlayerPedId()
        playerCoords = GetEntityCoords(playerPed)
        Citizen.Wait(500)
    end
end)

AddEventHandler('esx_vehicleshop:hasEnteredMarker', function(zone)
	if zone=='ShopEnteringCoin' then
		CurrentAction="coins_menu"
		CurrentActionMsg= _U('shop_menu')
		CurrentActionData = {}
	elseif zone == 'ShopEntering' then
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}
	elseif zone == 'ResellVehicle' then
		if IsPedSittingInAnyVehicle(playerPed) then

			local vehicle     = GetVehiclePedIsIn(playerPed, false)
			local vehicleData, model, resellPrice, plate

			if GetPedInVehicleSeat(vehicle, -1) == playerPed then
				for i=1, #Vehicles, 1 do
					if GetHashKey(Vehicles[i].model) == GetEntityModel(vehicle) then
						vehicleData = Vehicles[i]
						break
					end
				end

				resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.ResellPercentage)
				model = GetEntityModel(vehicle)
				plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

				CurrentAction     = 'resell_vehicle'
				CurrentActionMsg  = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))

				CurrentActionData = {
					vehicle = vehicle,
					label = vehicleData.name,
					price = resellPrice,
					model = model,
					plate = plate
				}
			end

		end
	end
end)

AddEventHandler('esx_vehicleshop:hasExitedMarker', function(zone)
	if not IsInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInShopMenu then
			ESX.UI.Menu.CloseAll()

			DeleteShopInsideVehicles()
			local playerPed = PlayerPedId()

			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
			SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos)
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.ShopEntering.Pos)

	SetBlipSprite (blip, 326)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('car_dealer'))
	EndTextCommandSetBlipName(blip)

	local blip2 = AddBlipForCoord(Config.Coins.ShopEnteringCoin.Pos)

	SetBlipSprite (blip2, 523)
	SetBlipDisplay(blip2, 4)
	--SetBlipColour(blip2, 46)
	SetBlipScale  (blip2, 1.05)
	SetBlipAsShortRange(blip2, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Concesionaria Premium")
	EndTextCommandSetBlipName(blip2)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local isInMarker, letSleep, currentZone = false, true
		if not IsInShopMenu then
			for k,v in pairs(Config.Zones) do
				local distance = #(playerCoords - v.Pos)

				if distance < Config.DrawDistance then
					letSleep = false

					if v.Type ~= -1 then
						DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < v.Size.x then
						isInMarker, currentZone = true, k
					end
				end
			end

			if letSleep then
				for k,v in pairs(Config.Coins) do
				local distance = #(playerCoords - v.Pos)

					if distance < Config.DrawDistance then
						letSleep = false

						if v.Type ~= -1 then
							DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < v.Size.x then
							isInMarker, currentZone = true, k
						end
					end
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker, LastZone = true, currentZone
				LastZone = currentZone
				TriggerEvent('esx_vehicleshop:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_vehicleshop:hasExitedMarker', LastZone)
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(50)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(6)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'shop_menu' then
					OpenShopMenu()
				elseif CurrentAction == 'coins_menu' then
					OpenCoinsMenu()
				elseif CurrentAction == 'resell_vehicle' then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_confirm', {
					title = "Vender por $"..ESX.Math.GroupDigits(CurrentActionData.price).."?",
					align = 'top-left',
					elements = {
						{label = _U('no'),  value = 'no'},
						{label = _U('yes'), value = 'yes'}
					}}, function(data, menu)
						if(data.current.value=="yes")then
							ESX.TriggerServerCallback('esx_vehicleshop:resellVehicle', function(vehicleSold)
								if vehicleSold then
									ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
									ESX.ShowNotification(_U('vehicle_sold_for', CurrentActionData.label,ESX.Math.GroupDigits(CurrentActionData.price)))
								else
									ESX.ShowNotification(_U('not_yours'))
								end
							end, CurrentActionData.plate, CurrentActionData.model)
						end
						menu.close()
					end, function(data, menu)
						menu.close()
					end)
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	RequestIpl('shr_int') -- Load walls and floor

	local interiorID = 7170
	LoadInterior(interiorID)
	EnableInteriorProp(interiorID, 'csr_beforeMission') -- Load large window
	RefreshInterior(interiorID)
end)