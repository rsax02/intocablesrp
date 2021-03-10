local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local IsBusy = false
local spawnedVehicles, isInShopMenu = {}, false
local Melee = {-1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466}
local Knife = {-1716189206, 1223143800, -1955384325, -1833087301, 910830060}
local Bullet = {453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093}
local Animal = {-100946242, 148160082}
local FallDamage = {-842959696}
local Explosion = {-1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087}
local Gas = {-1600701090}
local Burn = {615608432, 883325847, -544306709}
local Drown = {-10959621, 1936677264}
local Car = {133987706, -1553120962}
local checking = false

function Start(ped)
    if checking == true then
        return
    end
    checking = true

    loadAnimDict("amb@medic@standing@kneel@base")
    loadAnimDict("anim@gangops@facility@servers@bodysearch@")

    local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped))
    local d = GetPedCauseOfDeath(ped)
    local ped = PlayerPedId()

    TaskPlayAnim(ped, "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
    TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, -8.0, -1, 48, 0, false, false,
        false)
    Citizen.Wait(5000)
    ClearPedTasksImmediately(ped)
    if checkArray(Melee, d) then
        ESX.ShowNotification("Se le verían múltiples moretones por todo el cuerpo")
    elseif checkArray(Bullet, d) then
        ESX.ShowNotification("Se le verían agujeros de bala y sangrado excesivo")
    elseif checkArray(Knife, d) then
        ESX.ShowNotification("Se le verían heridas de un objeto afilado")
    elseif checkArray(Animal, d) then
        ESX.ShowNotification("Se le verían marcas de garras y dientes afilados")
    elseif checkArray(FallDamage, d) then
        ESX.ShowNotification("Se le verían varios huesos rotos")
    elseif checkArray(Explosion, d) then
        ESX.ShowNotification("Se le verían quemaduras de tercer grado por todo el cuerpo")
    elseif checkArray(Gas, d) then
        ESX.ShowNotification("Se le verían los labios morados y desprendería un olor a químico")
    elseif checkArray(Burn, d) then
        ESX.ShowNotification("Se le verían quemaduras de primer y segundo grado por algunas partes del cuerpo")
    elseif checkArray(Drown, d) then
        ESX.ShowNotification("Se le vería el cuerpo muy mojado y agua saliendo de su boca")
    elseif checkArray(Car, d) then
        ESX.ShowNotification("Se le verían marcas de neumáticos en el cuerpo y tendría huesos rotos")
    else
        ESX.ShowNotification("No es posible determinar el estado del sujeto")
    end
    checking = false
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function checkArray(array, val)
    for name, value in ipairs(array) do
        if value == val then
            return true
        end
    end
    return false
end


function OpenAmbulanceActionsMenu()
	--local elements = {}
	TriggerEvent('esx_society:openBossthecrowsrp2Menu', 'ambulance', function(data, menu)
				menu.close()
		end, {wash = false})

	--[[if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossthecrowsrp2Menu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)]]
end

function OpenMobileAmbulanceActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = {
			{label = _U('ems_menu'), value = 'citizen_interaction'}
		}
	}, function(data, menu)
		if data.current.value == 'citizen_interaction' then
			local elements = {
					{label = _U('ems_menu_revive'), value = 'revive'},
					{label = _U('ems_menu_small'), value = 'small'},
					{label = _U('ems_menu_big'), value = 'big'},
					{label = _U('ems_menu_putincar'), value = 'put_in_vehicle'},
					{label = 'Facturación',       value = 'billing'},
				}
				
			if ESX.PlayerData.job.grade>=2 then
				table.insert(elements,{label="Realizar cirugia", value="cirugy"})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('ems_menu_title'),
				align    = 'top-left',
				elements = elements
			}, function(data, menu)
				if IsBusy then return end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer == -1 or closestDistance > 1.0 then
					ESX.ShowNotification(_U('no_players'))
				else
					if data.current.value=="cirugy" then
						local closestId = GetPlayerServerId(closestPlayer)
						ESX.UI.Menu.Open('default',GetCurrentResourceName(),'player_list',{
							title="Jugador:",
							align="top-left",
							elements={{label=GetPlayerName(closestPlayer).." Id "..closestId}}
						},function(data2,menu2)
							TriggerServerEvent('esx_ambulancejob:cirugy',closestId)
							menu2.close()
						end,function(data2,menu2)
							menu2.close()
						end)
					elseif data.current.value == 'revive' then

						IsBusy = true

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)

								if IsPedDeadOrDying(closestPlayerPed, 1) then
									local playerPed = PlayerPedId()

									ESX.ShowNotification(_U('revive_inprogress'))

									local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

									for i=1, 15, 1 do
										Citizen.Wait(900)
								
										ESX.Streaming.RequestAnimDict(lib, function()
											TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
										end)
									end

									--TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:rethecrowsrp2vive', GetPlayerServerId(closestPlayer))

									-- Show revive award?
									if Config.ReviveReward > 0 then
										ESX.ShowNotification(_U('revive_complete_award', GetPlayerServerId(closestPlayer), Config.ReviveReward))
									else
										ESX.ShowNotification(_U('revive_complete', GetPlayerServerId(closestPlayer)))
									end
								else
									ESX.ShowNotification(_U('player_not_unconscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end

							IsBusy = false

						end, 'medikit')

					elseif data.current.value == 'small' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									--TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_bandage'))
							end
						end, 'bandage')

					elseif data.current.value == 'billing' then
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
							title = ('Facturación')
						}, function(data, menu)
							local amount = tonumber(data.value)
			
							if amount == nil or amount < 0 then
								ESX.ShowNotification('Cantidad inválida')
							else
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer == -1 or closestDistance > 3.0 then
									ESX.ShowNotification(_U('no_players_nearby'))
								else
									menu.close()
									TriggerServerEvent('esx_billing:sendthecrowsrp2Bill', GetPlayerServerId(closestPlayer), 'society_ambulance', ('Hospital'), amount)
								end
							end
						end, function(data, menu)
							menu.close()
						end)

					elseif data.current.value == 'big' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									--TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end
						end, 'medikit')

					elseif data.current.value == 'put_in_vehicle' then
						TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()
    ESX.TriggerServerCallback('esx_ambulancejob:getStockItems', function(items)
        local elements = {}

        for i = 1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            title = _U('ambulance_stock'),
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                title = _U('quantity')
            }, function(data2, menu2)
                local count = tonumber(data2.value)

                if count == nil then
                    ESX.ShowNotification(_U('invalid_quantity'))
                else
                    menu2.close()
                    menu.close()
                    TriggerServerEvent('esx_ambulancejob:getStockItem', itemName, count)

                    Citizen.Wait(1000)
                    OpenGetStocksMenu()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end

function OpenPutStocksMenu()
    ESX.TriggerServerCallback('esx_ambulancejob:getPlayerInventory', function(inventory)
        local elements = {}

        for i = 1, #inventory.items, 1 do
            local item = inventory.items[i]

            if item.count > 0 then
                table.insert(elements, {
                    label = item.label .. ' x' .. item.count,
                    type = 'item_standard',
                    value = item.name
                })
            end
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            title = _U('inventory'),
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                title = _U('quantity')
            }, function(data2, menu2)
                local count = tonumber(data2.value)

                if count == nil then
                    ESX.ShowNotification(_U('invalid_quantity'))
                else
                    menu2.close()
                    menu.close()
                    TriggerServerEvent('esx_ambulancejob:putStockItems', itemName, count)

                    Citizen.Wait(1000)
                    OpenPutStocksMenu()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end


function OpenStockMenu()
	local elements = {
		{label = _U('deposit_stock'),  value = 'put_stock'},
	}

	if Config.EnablePlayerManagement and (ESX.PlayerData.job.grade>=2)then
		table.insert(elements, {label = _U('withdraw_stock'), value = 'get_stock'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance_stock'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		end
	end, function(data, menu)
		menu.close()
	end)
end


-- Draw markers & Marker logic
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local letSleep, isInMarker, hasExited = true, false, false
		local currentHospital, currentPart, currentPartNum

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			for hospitalNum,hospital in pairs(Config.Hospitals) do
			-- Ambulance Actions
				if ESX.PlayerData.job.grade_name=="boss" then
					local distance = #(playerCoords-hospital.AmbulanceActions[1])
					
					--local distance = GetDistanceBetweenCoords(playerCoords, v, true)

					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, hospital.AmbulanceActions[1], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep = false
						if distance < Config.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', 1
						end
					end

				end
				local distance2 = #(playerCoords-hospital.AmbulanceStock[1])
				
				if distance2 < Config.DrawDistance then
					DrawMarker(Config.Marker.type, hospital.AmbulanceStock[1], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
					letSleep=false
					if distance2 < Config.Marker.x then
						isInMarker,currentHospital,currentPart,currentPartNum=true,hospitalNum,'AmbulanceStock',1
					end
				end
				
				
				
				if 1>0 then
					local distance = #(playerCoords-hospital.CloakRoom[1])

					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, hospital.CloakRoom[1], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep=false
					end

					if distance < Config.Marker.x then
						isInMarker,currentHospital,currentPart,currentPartNum = true, hospitalNum, "CloakRoom", 1
					end
				end
				
				-- Pharmacies
				if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and ESX.PlayerData.job.grade_name == 'boss' then
					for k,v in ipairs(hospital.Pharmacies) do
						local distance = #(playerCoords-v)
						--local distance = GetDistanceBetweenCoords(playerCoords, v, true)

						if distance < Config.DrawDistance then
							DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
							letSleep = false
						end

						if distance < Config.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Pharmacy', k
						end
					end
				end
				-- Vehicle Spawners
				for k,v in ipairs(hospital.Vehicles) do
					local distance = #(playerCoords-v.Spawner)
					--local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end

					if distance < v.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
					end
				end
			end
		else
			Citizen.Wait(3000)
		end

		-- Logic for exiting & entering markers
		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
			if
				(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
				(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
			then
				TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
				hasExited = true
			end

			HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

			TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)

		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		if part== 'CloakRoom' then
			CurrentAction=part
			CurrentActionMsg="Presiona ~INPUT_CONTEXT~ para acceder al ~y~vestuario~w~"
			CurrentActionData={}
		elseif part == "AmbulanceStock" then
			CurrentAction = part
			CurrentActionMsg = "Presiona ~INPUT_CONTEXT~ para acceder al ~y~armario~w~"
			CurrentActionData = {}
		elseif part == 'AmbulanceActions' then
			CurrentAction = part
			CurrentActionMsg = _U('actions_prompt')
			CurrentActionData = {}
		elseif part == 'Pharmacy' then
			CurrentAction = part
			CurrentActionMsg = _U('open_pharmacy')
			CurrentActionData = {}
		elseif part == 'Vehicles' then
			CurrentAction = part
			CurrentActionMsg = _U('garage_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(hospital, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)
			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'CloakRoom' then
					OpenCloakroomMenu()
				elseif CurrentAction == 'AmbulanceActions' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction=="AmbulanceStock" then
					OpenStockMenu()
				elseif CurrentAction == 'Pharmacy' then
					OpenPharmacyMenu()
				elseif CurrentAction == 'Vehicles' then
					OpenVehicleSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				end
				CurrentAction = nil
			end
		elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' and not IsDead then
			if IsControlJustReleased(0, Keys['F6']) then
				OpenMobileAmbulanceActionsMenu()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not inVehicle and not IsDead then
			local player, distance = ESX.Game.GetClosestPlayer()
			
			if distance ~= -1 and distance <= 2.0 and IsPlayerDead(player) then
				if checking == false then
					local coords = GetEntityCoords(GetPlayerPed(player))
					ESX.Game.Utils.DrawText3D({x = coords.x, y = coords.y, z = coords.z}, "Presiona [~g~E~s~] para investigar la causa de muerte", 0.4)
					if IsControlJustReleased(0,38) then
						Start(GetPlayerPed(player))
					end
				end
			else
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

function OpenCloakroomMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = _U('ems_clothes_ems'), value = 'ambulance_wear'},
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'ambulance_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function OpenVehicleSpawnerMenu(h, p)
    local ped = PlayerPedId()
	if (IsPedInAnyVehicle(ped, false)) then
		local vehicle = GetVehiclePedIsIn(ped,false)
		if(ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))==tostring(GetPlayerServerId(PlayerId())))then
			DeleteEntity(vehicle)
		end
        return
    end
    local elements = {}
    local grade = ESX.PlayerData.job.grade_name
    authorizedVehicles = Config.AuthorizedVehicles[grade]
    for k, v in pairs(authorizedVehicles) do
        if IsModelInCdimage(v.model) then
            table.insert(elements, {
                value = v.model,
                label = v.label
            })
        end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
        title = "Vehiculos disponibles",
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        ESX.Game.SpawnVehicle(data.current.value, Config.Hospitals.CentralLosSantos.Vehicles[1].SpawnPoints[1].coords,
            Config.Hospitals.CentralLosSantos.Vehicles[1].SpawnPoints[1].heading, function(vehicle)
                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                SetVehicleNumberPlateText(vehicle, GetPlayerServerId(PlayerId()))
            end)
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
		title    = _U('pharmacy_menu_title'),
		align    = 'top-left',
		elements = {
			{label = _U('pharmacy_take', _U('medikit')), value = 'medikit'},
			{label = _U('pharmacy_take', _U('bandage')), value = 'bandage'}
		}
	}, function(data, menu)
		TriggerServerEvent('esx_ambulancejob:giveItem', data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function WarpPedInClosestVehicle(ped)
	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

	if distance ~= -1 and distance <= 5.0 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end
	else
		ESX.ShowNotification(_U('no_vehicles'))
	end
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)
