local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData = {}
local menuIsShowed = false
local hintIsShowed = false
local hasAlreadyEnteredMarker = false
local Blips = {}
local JobBlips = {}
local isInMarker = false
local isInPublicMarker = false

local hintToDisplay = "no hint to display"
local onDuty = false
local spawner = 0

local vehicleObjInCaseofDrop = nil
local vehicleInCaseofDrop = nil

local vehicleMaxHealth = nil
local lastWork = GetGameTimer()

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	refreshBlips()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	refreshBlips()
end)

local ped,coords,isdead,isworking
Citizen.CreateThread(function()
	while true do
		ped=PlayerPedId()
		coords=GetEntityCoords(ped)
		isdead=IsEntityDead(ped)
		if isworking and isdead then
		TriggerServerEvent('esx_jobs:stopWork')
		isworking=false
		end
		Citizen.Wait(100)
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(Config.Jobs.drugs.Zones) do
		if v.Blip then
			local blip = AddBlipForCoord(v.Pos.x,v.Pos.y,v.Pos.z)
			SetBlipSprite  (blip, Config.Jobs.drugs.BlipInfos.Sprite)
			SetBlipDisplay (blip, 4)
			SetBlipScale   (blip, 1.0)
			SetBlipCategory(blip, 3)
			SetBlipColour  (blip, Config.Jobs.drugs.BlipInfos.Color)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.Name)
			EndTextCommandSetBlipName(blip)

			local radius = AddBlipForRadius(v.Pos.x, v.Pos.y, v.Pos.z, Config.Jobs.drugs.BlipInfos.Radius)
			
			SetBlipHighDetail(radius, true)
			SetBlipAlpha(radius, 150)
			SetBlipColour(radius, Config.Jobs.drugs.BlipInfos.Color)
			SetBlipAsShortRange(radius, true)
		end
	end
end)

function showHelpText(s)
    SetTextComponentFormat("STRING")
    AddTextComponentString(s)
    EndTextCommandDisplayHelp(0, 0, 0, -1)
end

function OpenMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = _U('cloakroom'),
		align="top-left",
		elements = {
			{label = _U('job_wear'),     value = 'job_wear'},
			{label = _U('citizen_wear'), value = 'citizen_wear'}
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			onDuty = false
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'job_wear' then
			onDuty = true
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

RegisterNetEvent('esx_jobs:pbc')
AddEventHandler('esx_jobs:pbc', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	local ped = PlayerPedId()
	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(10000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(ped)
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(ped, true)
	SetPedMovementClipset(ped, "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(ped, true)
	DoScreenFadeIn(1000)
	Citizen.Wait(60000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(ped, 0)
	SetPedIsDrunk(ped, false)
	SetPedMotionBlur(ped, false)
end)

AddEventHandler('esx_jobs:action', function(job, zone,key,drugs)
	menuIsShowed = true
	if zone.Type == "cloakroom" then
		OpenMenu()
	elseif zone.Type == "work" then
		hintToDisplay = "no hint to display"
		hintIsShowed = false
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			ESX.ShowNotification(_U('foot_work'))
		else
			if not IsPedInAnyVehicle(PlayerPedId(),false) then
				TriggerServerEvent('esx_jobs:startWork', key,drugs)
				isworking=true
			end
		end
	elseif zone.Type == "vehspawner" then
		local spawnPoint = nil
		local vehicle = nil

		for k,v in pairs(Config.Jobs) do
			if PlayerData.job.name == k then
				for l,w in pairs(v.Zones) do
					if w.Type == "vehspawnpt" and w.Spawner == zone.Spawner then
						spawnPoint = w
						spawner = w.Spawner
					end
				end

				for m,x in pairs(v.Vehicles) do
					if x.Spawner == zone.Spawner then
						vehicle = x
					end
				end
			end
		end

		if ESX.Game.IsSpawnPointClear(spawnPoint.Pos, 5.0) then
			spawnVehicle(spawnPoint, vehicle, zone.Caution)
		else
			ESX.ShowNotification(_U('spawn_blocked'))
		end

	elseif zone.Type == "vehdelete" then
		local looping = true
		
		for k,v in pairs(Config.Jobs) do
			if PlayerData.job.name == k then
				for l,w in pairs(v.Zones) do
					if w.Type == "vehdelete" and w.Spawner == zone.Spawner then
						local playerPed = PlayerPedId()

						if IsPedInAnyVehicle(playerPed, false) then

							local vehicle = GetVehiclePedIsIn(playerPed, false)
							local plate = GetVehicleNumberPlateText(vehicle)
							local driverPed = GetPedInVehicleSeat(vehicle, -1)
							
							if playerPed == driverPed then
							
								ESX.TriggerServerCallback('esx_vehicleshop:getJobPlate', function(plate)
									if (ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))==plate) then
										local vehicleHealth = GetVehicleEngineHealth(vehicleInCaseofDrop)
										local giveBack = ESX.Math.Round(vehicleHealth / vehicleMaxHealth, 2)
										
										TriggerServerEvent('esx_jobs:cauthecrowsrp2tion', "give_bathecrowsrp2ck", giveBack, 0, 0)
										DeleteVehicle(GetVehiclePedIsIn(playerPed, false))

										if w.Teleport ~= 0 then
											ESX.Game.Teleport(playerPed, w.Teleport)
										end

										if vehicleObjInCaseofDrop.HasCaution then
											vehicleInCaseofDrop = nil
											vehicleObjInCaseofDrop = nil
											vehicleMaxHealth = 100
										end

									end
								end)
							else
								
								ESX.ShowNotification(_U('not_your_vehicle'))
							end

						end

						looping = false
						break
					end

					if looping == false then
						break
					end
				end
			end
			if looping == false then
				break
			end
		end
	elseif zone.Type == "delivery" then
		if not IsPedInAnyVehicle(PlayerPedId(),false) then
			if Blips['delivery'] ~= nil then
				RemoveBlip(Blips['delivery'])
				Blips['delivery'] = nil
			end

			hintToDisplay = "no hint to display"
			hintIsShowed = false
			TriggerServerEvent('esx_jobs:startWork', key,drugs)
			isworking=true
		end
	end
	--nextStep(zone.GPS)
end)

function nextStep(gps)
	if gps ~= 0 then
		if Blips['delivery'] ~= nil then
			RemoveBlip(Blips['delivery'])
			Blips['delivery'] = nil
		end

		Blips['delivery'] = AddBlipForCoord(gps.x, gps.y, gps.z)
		SetBlipRoute(Blips['delivery'], true)
		ESX.ShowNotification(_U('next_point'))
	end
end

AddEventHandler('esx_jobs:hasExitedMarker', function(zone)
	TriggerServerEvent('esx_jobs:stopWork')
	isworking=false
	hintToDisplay = "no hint to display"
	menuIsShowed = false
	hintIsShowed = false
	isInMarker = false
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	onDuty = false
	spawner = 0
	deleteBlips()
	refreshBlips()
end)

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end

function refreshBlips()
	local zones = {}
	local blipInfo = {}

	if PlayerData.job ~= nil then
		for jobKey,jobValues in pairs(Config.Jobs) do

			if jobKey == PlayerData.job.name then
				for zoneKey,zoneValues in pairs(jobValues.Zones) do

					if zoneValues.Blip then
						local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
						SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
						SetBlipDisplay (blip, 4)
						SetBlipScale   (blip, 1.2)
						SetBlipCategory(blip, 3)
						SetBlipColour  (blip, jobValues.BlipInfos.Color)
						SetBlipAsShortRange(blip, true)

						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(zoneValues.Name)
						EndTextCommandSetBlipName(blip)
						table.insert(JobBlips, blip)
					end
				end
			end
		end

	end
end

function spawnVehicle(spawnPoint, vehicle, vehicleCaution)
	hintToDisplay = 'no hint to display'
	hintIsShowed = false
	TriggerServerEvent('esx_jobs:cauthecrowsrp2tion', 'take', vehicleCaution, spawnPoint, vehicle)
end

RegisterNetEvent('esx_jobs:spawnJobVehicle')
AddEventHandler('esx_jobs:spawnJobVehicle', function(spawnPoint, vehicle)
	local playerPed = PlayerPedId()

	ESX.Game.SpawnVehicle(vehicle.Hash, spawnPoint.Pos, spawnPoint.Heading, function(spawnedVehicle)

		if vehicle.Trailer ~= "none" then
			ESX.Game.SpawnVehicle(vehicle.Trailer, spawnPoint.Pos, spawnPoint.Heading, function(trailer)
				AttachVehicleToTrailer(spawnedVehicle, trailer, 1.1)
			end)
		end

		-- save & set plate
		--SetVehicleNumberPlateText(spawnedVehicle, GetPlayerServerId(PlayerId()))
		ESX.TriggerServerCallback('esx_vehicleshop:getJobPlate', function(plate)
			SetVehicleNumberPlateText(spawnedVehicle, plate)
		end)

		TaskWarpPedIntoVehicle(playerPed, spawnedVehicle, -1)

		if vehicle.HasCaution then
			vehicleInCaseofDrop = spawnedVehicle
			vehicleObjInCaseofDrop = vehicle
			vehicleMaxHealth = GetVehicleEngineHealth(spawnedVehicle)
		end
		SetVehicleFuelLevel(spawnedVehicle,80.0)
	end)
end)

-- Show top left hint

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(6)

		if hintIsShowed then
			showHelpText(hintToDisplay)
        else
            Citizen.Wait(500)
        end
    end
end)


-- Display markers (only if on duty and the player's job ones)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local zones = {}

		if PlayerData.job ~= nil then
			local sleep = true
			for k,v in pairs(Config.Jobs) do
				if PlayerData.job.name == k then
					zones = v.Zones
				end
			end


			for k,v in pairs(zones) do
				if onDuty or v.Type == "cloakroom" or v.Duty then
					if(v.Marker ~= -1 and #(coords- vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < Config.DrawDistance) then
						DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
						sleep=false
					end
				end
			end

			for k,v in pairs(Config.Jobs.drugs.Zones) do
				if(#(coords- vector3(v.Pos.x, v.Pos.y, v.Pos.z))<Config.DrawDistance) then
					DrawMarker(v.Marker,v.Pos.x,v.Pos.y,v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
					sleep=false
				end
			end
			if sleep then Citizen.Wait(500) end
		else 
			Citizen.Wait(1500)
		end
	end
end)

-- Display public markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local sleep = true
		for k,v in pairs(Config.PublicZones) do
			if(v.Marker ~= -1 and #(coords- vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < Config.DrawDistance) then
				DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				sleep=false
				break
			end
		end

		if sleep then Citizen.Wait(5000) end
	end
end)

-- Activate public marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(8)
		local position = nil
		local zone     = nil

		for k,v in pairs(Config.PublicZones) do
			if #(vector2(coords.x,coords.y)- vector2(v.Pos.x, v.Pos.y)) < v.Size.x/2 then
				isInPublicMarker = true
				position = v.Teleport
				zone = v
				break
			else
				isInPublicMarker = false
			end
		end
		if position then
			if IsControlJustReleased(0, Keys['E']) and isInPublicMarker then
				ESX.Game.Teleport(PlayerPedId(), position)
				isInPublicMarker = false
			end
		end

		-- hide or show top left zone hints
		if isInPublicMarker then
			hintToDisplay = zone.Hint
			hintIsShowed = true
		else
			if not isInMarker then
				hintToDisplay = "no hint to display"
				hintIsShowed = false
			end
		end
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)

		local zones = nil
		local job = nil

		local sleep = true
		local drugs = false

		local currentZone = nil
		local zone        = nil
		local lastZone    = nil

		if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' then
			for k,v in pairs(Config.Jobs) do
				if PlayerData.job.name == k then
					job = v
					zones = v.Zones
				end
			end		

			if zones ~= nil then
				for k,v in pairs(zones) do
					if #(vector2(coords.x,coords.y)-vector2(v.Pos.x, v.Pos.y)) < v.Size.x/1.5 then
						isInMarker  = true
						currentZone = k
						zone        = v
						sleep       = false
						break
					else
						isInMarker  = false
					end
				end
			end
		end
		if not currentZone then
			for k,v in pairs(Config.Jobs.drugs.Zones) do
				if #(vector3(coords.x,coords.y,coords.z)-vector3(v.Pos.x, v.Pos.y,v.Pos.z)) < v.Size.x/1.5 then
					isInMarker  = true
					currentZone = k
					zone        = v
					sleep       = false
					drugs       = true
					break
				else 
					isInMarker=false
				end
			end
		end
	
		if IsControlJustReleased(0, Keys['E']) and not menuIsShowed and isInMarker then
			if zone.Duty or onDuty or zone.Type == "cloakroom" then
				TriggerEvent('esx_jobs:action', job, zone, currentZone,drugs)
			end
		end

		-- hide or show top left zone hints
		if isInMarker and not menuIsShowed then
			hintIsShowed = true
			if zone.Duty or (onDuty or zone.Type == "cloakroom") and zone.Type ~= "vehdelete" then
				hintToDisplay = zone.Hint
				hintIsShowed = true
			elseif zone.Type == "vehdelete" and onDuty then
				local playerPed = PlayerPedId()
				if IsPedInAnyVehicle(playerPed, false) then
					hintToDisplay = zone.Hint
					hintIsShowed = true
					--local vehicle = GetVehiclePedIsIn(playerPed, false)
					--local driverPed = GetPedInVehicleSeat(vehicle, -1)
					--if playerPed == driverPed then
						--if (ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))==tostring(GetPlayerServerId(PlayerId()))) then
						--end
					--else
						--hintToDisplay = _U('not_your_vehicle')
					--end
				else
					hintIsShowed=false
				end
			elseif onDuty and zone.Spawner ~= spawner then
				hintToDisplay = _U('wrong_point')
				hintIsShowed = true
			else
				hintToDisplay = nil
				hintIsShowed = false
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_jobs:hasExitedMarker', zone)
		end

		if not isInMarker then Citizen.Wait(500) end

	end
end)

Citizen.CreateThread(function()
	-- Slaughterer
	RemoveIpl("CS1_02_cf_offmission")
	RequestIpl("CS1_02_cf_onmission1")
	RequestIpl("CS1_02_cf_onmission2")
	RequestIpl("CS1_02_cf_onmission3")
	RequestIpl("CS1_02_cf_onmission4")

	-- Tailor
	RequestIpl("id2_14_during_door")
	RequestIpl("id2_14_during1")
end)
