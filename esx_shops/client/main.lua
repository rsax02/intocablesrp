ESX                           = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local requestedVehicle        = false
local vehicleEntity = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

--[[ Citizen.CreateThread(function()
	Citizen.Wait(6000)
	for k,v in pairs(Config.Objects) do
		local coords = vector3(v.Pos.x,v.Pos.y,v.Pos.z)
		local x, y, z = table.unpack(coords)
		ESX.Game.SpawnLocalObject(v.Prop, vector4(x,y,z,v.Heading), function(obj)
		SetEntityHeading(obj, v.Heading)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj,true)
		end)
	end
end) ]]

function OpenShopMenu(zone, location)
	if zone.Jobs then
		local data = ESX.GetPlayerData()
		local possible = false
		for k,v in pairs(zone.Jobs) do
			if(data.job.name==k and data.job.grade>=v) then
				possible=true
			end
		end
		if not possible then
			ESX.ShowNotification("No podemos hacer negocios contigo")
			return
		end
	end
	local elements = {}

	table.sort(zone.Items, function(a, b)
		return a.amount < b.amount
	end)

	for k,v in pairs(zone.Items) do
		local newLabel = ESX.Math.GroupDigits(v.amount)
		local myLabel = v.label
		newLabel = (v.type=="money" and '<span style="color:green;">$' or '<span style="color:cornflowerblue;">#') .. newLabel .. '</span>'
		 if v.label == 'weapon' then
			myLabel = ESX.GetWeaponLabel(v.name)
		end

		--[[
		if v.label == 'item' then
			v.label = ESX.GetItemLabel(v.name)
		end ]]
		table.insert(elements, {
			label = myLabel .. ' ' .. newLabel,
			value = v
		})
	end


	ESX.UI.Menu.CloseAll()
	opened=true
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
		title    = zone.Name,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		TriggerServerEvent("esx_shops:buyItem",data.current.value)
	end, function(data, menu)
		menu.close()
		opened=false
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_menu')
		CurrentActionData = {zone = zone}
	end)
end

RegisterNetEvent('esx_shops:spawnCar')
AddEventHandler('esx_shops:spawnCar',function(car, coord, heading)
	ESX.UI.Menu.CloseAll()
	--SetEntityAsMissionEntity(vehicleEntity, true, true)
	--DeleteEntity(vehicleEntity)
	--TriggerServerEvent("esx_shops:return")
	ESX.Game.SpawnVehicle(car, coord,heading, function(vehicle)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		SetVehicleNumberPlateText(vehicle, GetPlayerServerId(PlayerId()))
	end)
	requestedVehicle=true
	Citizen.Wait(20)
	vehicleEntity = GetVehiclePedIsIn(PlayerPedId(), false)
	TriggerServerEvent('esx_shops:registerVehicle',vehicleEntity, PlayerId())
end)

AddEventHandler('esx_shops:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_menu')
	CurrentActionData = {zone = zone}
end)

AddEventHandler('esx_shops:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Create Blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		if(v.Blip)then
			for i = 1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
				SetBlipSprite (blip, v.Sprite)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, v.Size)
				SetBlipColour (blip, v.Color)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(v.Name)
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

local ped,coords,current,currentZone,inVehicle

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	while true do
		ped=PlayerPedId()
		coords=GetEntityCoords(ped)
		inVehicle=(IsPedInAnyVehicle(ped,false) and requestedVehicle)
		local joined
		for k,v in pairs(Config.Zones) do
			for key,value in pairs(v.Pos) do
				local loc = vector3(value.x,value.y,value.z)
				local distance = #(vector3(coords.x,coords.y,coords.z)-loc)
				if(distance<60.0 and value.food and not value.loaded)then
					local prop = Config.Objects[value.name]
					local coords = vector3(prop.Pos.x,prop.Pos.y,prop.Pos.z)
					local x, y, z = table.unpack(coords)
					Citizen.Wait(500)
					ESX.Game.SpawnLocalObject(prop.Prop, vector4(x,y,z,prop.Heading), function(obj)
					SetEntityHeading(obj, prop.Heading)
					PlaceObjectOnGroundProperly(obj)
					FreezeEntityPosition(obj,true)
					end)
					Config.Zones[k].Pos[key].loaded=true
				end
				if(distance<30.0)then
					currentZone = v
					current=value
					joined = true
					break
				end
			end
		end

		if not joined and current ~=nil then
			current=nil
			currentZone=nil
		end
		Citizen.Wait(800)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if(current~=nil and currentZone~=nil)then
			if(inVehicle and currentZone.Car)then
			DrawMarker(Config.Type, current.x, current.y, current.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
			else
				DrawMarker(Config.Type, current.x, current.y, current.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
			end
			local distance = #(vector3(current.x,current.y,current.z)-vector3(coords.x,coords.y,coords.z))
			if(distance<Config.Size.x and not opened)then
				--ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para acceder")
				showHelpText("Presiona ~INPUT_CONTEXT~ para acceder")
				if(IsControlJustReleased(0,38))then
					if(IsPedOnFoot(ped))then
						OpenShopMenu(currentZone,current)
					elseif requestedVehicle and currentZone.Car then
						local vehicle =GetVehiclePedIsIn(ped, false)
						if ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))==tostring(GetPlayerServerId(PlayerId())) then
						DeleteEntity(vehicle)
						requestedVehicle=false
						TriggerServerEvent("esx_shops:returnVehicle")
						TriggerServerEvent("esx_shops:removeVehicle")
						end
					end
				end				
			elseif opened and distance>1.8 then
				ESX.UI.Menu.CloseAll()
				opened=false
			end
		end
	end
end)

function showHelpText(s)
	SetTextComponentFormat("STRING")
	AddTextComponentString(s)
	EndTextCommandDisplayHelp(0,0,0,-1)
end

RegisterNetEvent('esx_shops:deleteVehicle')
AddEventHandler('esx_shops:deleteVehicle', function(vehicles)
	local playerId = PlayerId()
	if(vehicles==nil)then
		return
	end
	for k,v in pairs(vehicles) do
		if(playerId==v.source)then
			vehicle = v.vehicle
			local distance = #(GetEntityCoords(vehicle) - coords)
			if distance > 30 then
				if not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
					TriggerServerEvent('esx_shops:deleteForAll', v)
				end
			end
			break
		end
	end
end)

RegisterNetEvent('esx_shops:deleteVeh')
AddEventHandler('esx_shops:deleteVeh',function(vehicle)
	if(IsPedInAnyVehicle(PlayerPedId(),false))then
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		print(GetVehicleNumberPlateText(veh))
		print(vehicle.id)
		if ESX.Math.Trim(GetVehicleNumberPlateText(veh))==tostring(vehicle.id) then
			SetEntityAsMissionEntity(veh, false, false)
			DeleteVehicle(veh)
			if (not DoesEntityExist(veh)) then
				TriggerServerEvent('esx_shops:removeVehicle')
			end
			return
		end
	end
	SetEntityAsMissionEntity(vehicle.vehicle, false, false)
	DeleteVehicle(vehicle.vehicle)
	if (not DoesEntityExist(vehicle.vehicle)) then
		TriggerServerEvent('esx_shops:removeVehicle')
	end
end)

RegisterNetEvent('esx_armour:armour')
AddEventHandler('esx_armour:armour', function()
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
		SetPedArmour(playerPed, 100)
		end)
end)
