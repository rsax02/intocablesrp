ESX = nil
job = nil
local ped,coords
local menuOpened = false
local lastZone = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	job = ESX.GetPlayerData().job
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(new)
	job = new
end)

RegisterNetEvent('esx_factions:closeMenu')
AddEventHandler('esx_factions:closeMenu',function()
	ESX.UI.Menu.CloseAll()
end)

--add blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Factions) do
		if(v.Blip)then
			local blip = AddBlipForCoord(v.Blip.Coords)

			SetBlipSprite (blip, v.Blip.Sprite)
			SetBlipDisplay(blip, v.Blip.Display)
			SetBlipScale  (blip, v.Blip.Scale)
			SetBlipColour (blip, v.Blip.Colour)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(v.Label)
			EndTextCommandSetBlipName(blip)

			if v.Blip.Radius then
				local radius = AddBlipForRadius(v.Blip.Coords,v.Blip.Radius)
				SetBlipColour(radius,v.Blip.Colour)
				SetBlipAlpha(radius,180)
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        ped=PlayerPedId()
        coords=GetEntityCoords(ped)
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)

		if GetPedArmour(ped) > 0 then
			if job and job.name=="police" then
				SetPedComponentVariation(ped, 9, 7, 3, 0)
			else 
				SetPedComponentVariation(ped, 9, 12, 1, 0)
			end
		else
			SetPedComponentVariation(ped, 9, 0, 0, 0)
		end
	end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local sleep,sleep2 = true,true
        for key,value in pairs(Config.Factions) do
            if(job and job.name==key) then
				sleep = false
                for k,v in pairs(value.Zones) do
                    local dist = #(coords-vector3(v.x,v.y,v.z))
                    if(dist<45 and job.grade>=v.grade)then
						if k=="vehicles" and IsPedInAnyVehicle(ped,false) then
							DrawMarker(Config.Type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, 255, 0, 0, 100, false, true, 2, false, false, false, false)
						else 
                        	DrawMarker(Config.Type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, v.color.r, v.color.g, v.color.b, 100, false, true, 2, false, false, false, false)
						end
                        if(dist<=1.8)then
                            showHelpText(v.hint)
                            if(IsControlJustPressed(0,38))then
                                openZone(k)
								lastZone=k
                            end
                        elseif(menuOpened and lastZone and lastZone==k)then
							ESX.UI.Menu.CloseAll()
							menuOpened=false
						end
                        sleep2=false
                    end
                end
                break
            end
        end
        if(sleep) then
            Citizen.Wait(5000)
        end
        if(sleep2)then
            Citizen.Wait(1500)
        end
    end
end)

function showHelpText(s)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(s)
	EndTextCommandDisplayHelp(0, false, true, -1)
end

function openZone(type)
    if(type=="armory")then
        OpenArmoryMenu()
		menuOpened=true
	elseif(type=="stock") then
		OpenStockMenu()
		menuOpened=true
    elseif(type=="boss")then
		OpenBossMenu()
		menuOpened=true
    elseif(type=="vehicles") then
		if IsPedInAnyVehicle(ped,false)then
			DeleteVehicle()
		else 
		OpenVehicleSpawner()
		menuOpened=true
		end
    elseif(type=="uniform") then
		OpenUniformMenu()
		menuOpened=true
	end
end

function DeleteVehicle()
	if(IsPedInAnyVehicle(ped,false))then
		ESX.Game.DeleteEntity(GetVehiclePedIsIn(ped,false))
	end
end

function OpenBossMenu()
    ESX.UI.Menu.CloseAll()
    TriggerEvent('esx_society:openBossthecrowsrp2Menu', job.name, function(data, menu)
        menu.close()
    end, { wash = false })
end

function OpenUniformMenu()
	local uniform

	local elements= {}

	table.insert(elements,{label="Tu vestimenta",value="default"})

	for k,v in pairs(Config.Factions[job.name].Uniforms)do
		table.insert(elements,{label=v.label,value=k,uniform=v})
	end


	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open("default",GetCurrentResourceName(),'uniform',{
		title="Vestuario",
		align="top-left",
		elements=elements
	},function(data,menu)
		if data.current.value=="default" then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		else 
			TriggerEvent('skinchanger:getSkin', function(skin)
				local uniformObject

				if skin.sex == 0 then
					uniformObject = data.current.uniform.male
				else
					uniformObject = data.current.uniform.female
				end

				if uniformObject then
					TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
				else
					ESX.ShowNotification("No se ha encontrado esa vestimenta")
				end
				menu.close()
			end)
		end
	end,function(data,menu)
		menu.close()
	end)
	
end

function OpenVehicleSpawner()
    local elements = {}
    local vehicles = Config.Factions[job.name].Vehicles
    for i = 1, #vehicles, 1 do
        table.insert(elements,{label=vehicles[i].label,value=vehicles[i].spawn})
    end
    
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open("default",GetCurrentResourceName(),"vehicle_spawn",{
        title="Vehículos",
        align="top-left",
        elements=elements
    },function(data,menu)
        menu.close()    
        ESX.Game.SpawnVehicle(data.current.value, Config.Factions[job.name].VehicleSpawner, Config.Factions[job.name].VehicleSpawner.heading, function(vehicle)
            TaskWarpPedIntoVehicle(ped, vehicle, -1)
        end)
    end,function(data,menu)
        menu.close()
    end)
end

function OpenStockMenu()
	local elements = {
		{label = "Sacar objeto",  value = 'get_stock'},
		{label = "Depositar objeto", value = 'put_stock'},
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = "Armeria",
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

function OpenArmoryMenu()
	local elements = {
		{label = "Coger arma",     value = 'get_weapon'},
		{label = "Depositar arma",     value = 'put_weapon'},
		
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = "Armeria",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'get_weapon' then
			OpenGetWeaponMenu()
		elseif data.current.value == 'put_weapon' then
			OpenPutWeaponMenu()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetWeaponMenu()
	ESX.TriggerServerCallback('esx_factions:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon', {
			title    = "Armeria - Retirar armas",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			ESX.TriggerServerCallback('esx_factions:removeArmoryWeapon', function()
				OpenGetWeaponMenu()
			end, data.current.value,job.name)
		end, function(data, menu)
			menu.close()
		end)
	end,job.name)
end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label,
				value = weaponList[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon', {
		title    = "Armeria - Depositar armas",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		ESX.TriggerServerCallback('esx_factions:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, true,job.name)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_factions:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			if items[i].count>0 then
				table.insert(elements, {
					label = 'x' .. items[i].count .. ' ' .. items[i].label,
					value = items[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = "Inventario",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = "Cantidad"
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification("Cantidad invalida")
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_factions:getStockItem', itemName, count,job.name)

					Citizen.Wait(300)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end,job.name)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_factions:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
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
			title    = "Inventario",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = "Cantidad"
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification("Cantidad invalida")
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_factions:putStockItems', itemName, count,job.name)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end,job.name)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if seal==true then
			local playerPed = PlayerPedId()
			
			DisableControlAction(0, 288,  true) -- F1
			DisableControlAction(0, 289, true) -- F2
			DisableControlAction(0, 170, true) -- F3
			DisableControlAction(0, 166, true) -- F5
			DisableControlAction(0, 167, true) -- F6
			DisableControlAction(0, 37, true) -- tab
			DisablePlayerFiring(playerPed,true)
			SetCurrentPedWeapon(playerPed,GetHashKey("WEAPON_UNARMED"),true)

			if IsPedInAnyVehicle(playerPed) then
				local veh = GetVehiclePedIsIn(playerPed,false)
				if(GetPedInVehicleSeat(veh, -1) == playerPed)then
					SetVehicleEngineOn(veh,false,false,true)
				end
			end

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else 
			Citizen.Wait(1000)
		end
	end
end)