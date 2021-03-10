local ESX	 = nil
local toggleui = false
local player, position, vehicle, invehicle, playerID, vehicleClass

-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)


local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local vehiclesCars = {0,1,2,3,4,5,6,7,8,9,10,11,12,17,18,19,20};


-- Hides TREW UI when it's on Pause Menu
Citizen.CreateThread(function()
    local isPauseMenu = false

	while true do
		Citizen.Wait(3)

		if IsPauseMenuActive() then -- ESC Key
			if not isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'toggleUi', value = false })
			end
		else
			if isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'toggleUi', value = true })
			end

			HideHudComponentThisFrame(1)  -- Wanted Stars
			HideHudComponentThisFrame(2)  -- Weapon Icon
			HideHudComponentThisFrame(3)  -- Cash
			HideHudComponentThisFrame(4)  -- MP Cash
			HideHudComponentThisFrame(6)  -- Vehicle Name
			HideHudComponentThisFrame(7)  -- Area Name
			HideHudComponentThisFrame(8)  -- Vehicle Class
			HideHudComponentThisFrame(9)  -- Street Name
			HideHudComponentThisFrame(13) -- Cash Change
			HideHudComponentThisFrame(17) -- Save Game
			HideHudComponentThisFrame(20) -- Weapon Stats
		end
	end
end)

-- Date and time update
Citizen.CreateThread(function()
	local id = GetPlayerServerId(PlayerId())
	while true do
		Citizen.Wait(1000)
			SendNUIMessage({ action = 'setText', id = 'date', value = trewDate() })
			SendNUIMessage({ action='setText', id='userID', value= 'ID: '..id})
	end
end)

-- Location update
Citizen.CreateThread(function()
	while true do
		player=PlayerPedId()
		position=GetEntityCoords(player)
		invehicle=IsPedInAnyVehicle(player,false)
		vehicle=GetVehiclePedIsIn(player,false)
		vehicleClass = GetVehicleClass(vehicle)
		playerID = PlayerId()
		if not invehicle then RemovePedHelmet(player,true) end
		Citizen.Wait(1000)

		if Config.ui.showLocation == true then
			local zoneNameFull = zones[GetNameOfZone(position.x, position.y, position.z)]
			local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))

			local locationMessage = nil

			if zoneNameFull then 
				locationMessage = streetName .. ', ' .. zoneNameFull
			else
				locationMessage = streetName
			end

			locationMessage = string.format(
				Locales[Config.Locale]['you_are_on_location'],
				locationMessage
			)

			SendNUIMessage({ action = 'setText', id = 'location', value = locationMessage })
		end
	end
end)


-- Vehicle Info
local vehicleCruiser
local vehicleSignalIndicator = 'off'
local seatbeltEjectSpeed = 45.0 
local seatbeltEjectAccel = 100.0
local seatbeltIsOn = false
local currSpeed = 0.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}

Citizen.CreateThread(function()
	
	while true do
		Citizen.Wait(50)
	
		local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)
		local vehicleInfo

		if IsPedInAnyVehicle(PlayerPedId(), false) and vehicleIsOn then

			local vehicleClass = GetVehicleClass(vehicle)

			if Config.ui.showMinimap == false then
				DisplayRadar(true)
			end

			-- Vehicle Speed
			local vehicleSpeedSource = GetEntitySpeed(vehicle)
			local vehicleSpeed
			vehicleSpeed = math.ceil(vehicleSpeedSource * 3.6)

			-- Vehicle Gradient Speed
			local vehicleNailSpeed

			if vehicleSpeed > Config.vehicle.maxSpeed then
				vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(Config.vehicle.maxSpeed * 205) / Config.vehicle.maxSpeed) )
			else
				vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(vehicleSpeed * 205) / Config.vehicle.maxSpeed) )
			end
			
			-- Vehicle Fuel and Gear
			local vehicleFuel
			vehicleFuel = GetVehicleFuelLevel(vehicle)

			local vehicleGear = GetVehicleCurrentGear(vehicle)

			if (vehicleSpeed == 0 and vehicleGear == 0) or (vehicleSpeed == 0 and vehicleGear == 1) then
				vehicleGear = 'N'
			elseif vehicleSpeed > 0 and vehicleGear == 0 then
				vehicleGear = 'R'
			end

			-- Vehicle Lights
			local vehicleVal,vehicleLights,vehicleHighlights  = GetVehicleLightsState(vehicle)
			local vehicleIsLightsOn
			if vehicleLights == 1 and vehicleHighlights == 0 then
				vehicleIsLightsOn = 'normal'
			elseif (vehicleLights == 1 and vehicleHighlights == 1) or (vehicleLights == 0 and vehicleHighlights == 1) then
				vehicleIsLightsOn = 'high'
			else
				vehicleIsLightsOn = 'off'
			end

			-- Vehicle Siren
			local vehicleSiren

			if IsVehicleSirenOn(vehicle) then
				vehicleSiren = true
			else
				vehicleSiren = false
			end
			
			vehicleInfo = {
				action = 'updateVehicle',

				status = true,
				speed = vehicleSpeed,
				nail = vehicleNailSpeed,
				gear = vehicleGear,
				fuel = vehicleFuel,
				lights = vehicleIsLightsOn,
				signals = vehicleSignalIndicator,
				cruiser = vehicleCruiser,
				type = vehicleClass,
				siren = vehicleSiren,
				seatbelt = {},

				config = {
					speedUnit = Config.vehicle.speedUnit,
					maxSpeed = Config.vehicle.maxSpeed
				}
			}

			vehicleInfo['seatbelt']['status'] = seatbeltIsOn
		else
			vehicleCruiser = false
			vehicleNailSpeed = 0
			vehicleSignalIndicator = 'off'

            seatbeltIsOn = false

			vehicleInfo = {
				action = 'updateVehicle',

				status = false,
				nail = vehicleNailSpeed,
				seatbelt = { status = seatbeltIsOn },
				cruiser = vehicleCruiser,
				signals = vehicleSignalIndicator,
				type = 0,
			}

			if Config.ui.showMinimap == false then
				DisplayRadar(false)
			end
		end

		SendNUIMessage(vehicleInfo)
	end
end)

-- Player status
Citizen.CreateThread(function()

	while true do
		Citizen.Wait(1200)

		local playerStatus 
		local showPlayerStatus = 0
		playerStatus = { action = 'setStatus', status = {} }

		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj
			ESX.PlayerData = ESX.GetPlayerData()
			player= GetPlayerServerId(playerID)
		end)
		local data = ESX.PlayerData
		local job,showJob = data.job
		if job.label == job.grade_label then
			showJob = job.grade_label
		else
			showJob = job.label .. ': ' .. job.grade_label
		end
		local info = {
			job =showJob,
			jobObject = job,
			money=data.money,
			bankMoney=data.accounts[1].money,
			blackMoney=data.accounts[2].money
		}

		setInfo(info)

		if showPlayerStatus > 0 then
			SendNUIMessage(playerStatus)
		end

	end
end)

-- Overall Info
function setInfo(info)
	SendNUIMessage({ action = 'setText', id = 'job', value = info['job'] })
	SendNUIMessage({ action = 'setMoney', id = 'wallet', value = info['money'] })
	SendNUIMessage({ action = 'setMoney', id = 'bank', value = info['bankMoney'] })
	SendNUIMessage({ action = 'setMoney', id = 'blackMoney', value = info['blackMoney'] })

	if info.jobObject ~= nil then
		local job = info.jobObject.name
		if job ~= "offambulance" and job~="offpolice" and job~="offmechanic" and job~="offarcadius" and info.jobObject.grade_name ~= nil and info.jobObject.grade_name == 'boss' then
				if(toggleui==false)then
					SendNUIMessage({ action = 'element', task = 'enable', value = 'society' })
				else
					SendNUIMessage({ action = 'element', task = 'disable', value = 'society' })
				end
				
			ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
				SendNUIMessage({ action = 'setMoney', id = 'society', value = money })
			end, info.jobObject.name)
		else
			SendNUIMessage({ action = 'element', task = 'disable', value = 'society' })
		end
		if info.blackMoney and info.blackMoney>0 then
			if(toggleui==false)then
				SendNUIMessage({ action = 'element', task = 'enable', value = 'blackMoney' })
			else
				SendNUIMessage({ action = 'element', task = 'disable', value = 'blackMoney' })
			end
		else
			SendNUIMessage({ action = 'element', task = 'disable', value = 'blackMoney' })
		end
	end

	local playerStatus 
	local showPlayerStatus = 0
	playerStatus = { action = 'setStatus', status = {} }

	showPlayerStatus = (showPlayerStatus+1)

	TriggerEvent('esx_status:getStatus', 'hunger', function(status)
		playerStatus['status'][showPlayerStatus] = {
			name = 'hunger',
			value = math.floor(100-status.getPercent())
		}
	end)

	showPlayerStatus = (showPlayerStatus+1)

	TriggerEvent('esx_status:getStatus', 'thirst', function(status)
		playerStatus['status'][showPlayerStatus] = {
			name = 'thirst',
			value = math.floor(100-status.getPercent())
		}
	end)

	showPlayerStatus = (showPlayerStatus+1)

	TriggerEvent('esx_status:getStatus', 'drunk', function(status)
		playerStatus['status'][showPlayerStatus] = {
			name = 'drunk',
			value = math.floor(status.getPercent())
		}
	end)

	showPlayerStatus = (showPlayerStatus+1)

	TriggerEvent('esx_status:getStatus', 'stress', function(status)
		playerStatus['status'][showPlayerStatus] = {
			name = 'stress',
			value = math.floor(status.getPercent())
		}
	end)

	if showPlayerStatus > 0 then
		SendNUIMessage(playerStatus)
	end
end


-- Voice detection and distance
Citizen.CreateThread(function()

	if Config.ui.showVoice == true then

	    RequestAnimDict('facials@gen_male@variations@normal')
	    RequestAnimDict('mp_facial')

	    while true do
	        Citizen.Wait(500)

	        for _,player in ipairs(GetActivePlayers()) do
	            local boolTalking = NetworkIsPlayerTalking(player)

	            --if player ~= playerID then
	                if boolTalking then
	                    --PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
	                elseif not boolTalking then
	                   -- PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
	                end
	            --end
	        end
	    end

	end
end)

Citizen.CreateThread(function()
	if Config.ui.showVoice == true then
		local isTalking = false
		local voiceDistance = nil
		while true do
			Citizen.Wait(5)

			if NetworkIsPlayerTalking(playerID) and not isTalking then 
				isTalking = not isTalking
				SendNUIMessage({ action = 'isTalking', value = isTalking })
			elseif not NetworkIsPlayerTalking(playerID) and isTalking then 
				isTalking = not isTalking
				SendNUIMessage({ action = 'isTalking', value = isTalking })
			end

			if IsControlJustPressed(1, Keys[Config.voice.keys.distance]) then

				Config.voice.levels.current = (Config.voice.levels.current + 1) % 3

				if Config.voice.levels.current == 0 then
					NetworkSetTalkerProximity(Config.voice.levels.default)
					voiceDistance = 'normal'
				elseif Config.voice.levels.current == 1 then
					NetworkSetTalkerProximity(Config.voice.levels.shout)
					voiceDistance = 'shout'
				elseif Config.voice.levels.current == 2 then
					NetworkSetTalkerProximity(Config.voice.levels.whisper)
					voiceDistance = 'whisper'
				end

				SendNUIMessage({ action = 'setVoiceDistance', value = voiceDistance })
			end

			if Config.voice.levels.current == 0 then
				voiceDistance = 'normal'
			elseif Config.voice.levels.current == 1 then
				voiceDistance = 'shout'
			elseif Config.voice.levels.current == 2 then
				voiceDistance = 'whisper'
			end
		end
	end
end)

RegisterNetEvent('updateAlert')
AddEventHandler('updateAlert',function(alert)
	SendNUIMessage({action='setAlert',value=alert})
end)

AddEventHandler('esx:onPlayerSpawn', function()

	SendNUIMessage({ action = 'ui', config = Config.ui })
	SendNUIMessage({ action = 'setFont', url = Config.font.url, name = Config.font.name })
	SendNUIMessage({ action = 'setLogo', value = Config.serverLogo })
	
	if Config.ui.showVoice == true then
		if Config.voice.levels.current == 0 then
			NetworkSetTalkerProximity(Config.voice.levels.default)
		elseif Config.voice.levels.current == 1 then
			NetworkSetTalkerProximity(Config.voice.levels.shout)
		elseif Config.voice.levels.current == 2 then
			NetworkSetTalkerProximity(Config.voice.levels.whisper)
		end
	end
end)

AddEventHandler('playerSpawned', function()
	if Config.ui.showVoice == true then
	    NetworkSetTalkerProximity(5.0)
	end

	HideHudComponentThisFrame(7) -- Area
	HideHudComponentThisFrame(9) -- Street
	HideHudComponentThisFrame(6) -- Vehicle
	HideHudComponentThisFrame(3) -- SP Cash
	HideHudComponentThisFrame(4) -- MP Cash
	HideHudComponentThisFrame(13) -- Cash changes!
end)


function trewDate()
	local timeString = nil
	local year,m,day = GetLocalTime() 
	local weekDay = _U('weekDay_' .. GetClockDayOfWeek())
	local month = _U('month_' .. m)


	local hour = GetClockHours()
	local minutes = GetClockMinutes()
	local time = nil
	local AmPm = ''

	if Config.date.AmPm == true then

		if hour >= 13 and hour <= 24 then
			hour = hour - 12
			AmPm = 'PM'
		else
			if hour == 0 or hour == 24 then
				hour = 12
			end
			AmPm = 'AM'
		end

	end

	if hour <= 9 then
		hour = '0' .. hour
	end
	if minutes <= 9 then
		minutes = '0' .. minutes
	end

	time = hour .. ':' .. minutes .. ' ' .. AmPm

	local date_format = Locales[Config.Locale]['date_format'][Config.date.format]

	if Config.date.format == 'default' then
		timeString = string.format(
			date_format,
			day, month, year
		)
	elseif Config.date.format == 'simple' then
		timeString = string.format(
			date_format,
			day, month
		)

	elseif Config.date.format == 'simpleWithHours' then
		timeString = string.format(
			date_format,
			time, day, month
		)	
	elseif Config.date.format == 'withWeekday' then
		timeString = string.format(
			date_format,
			weekDay, day, month, year
		)
	elseif Config.date.format == 'withHours' then
		timeString = string.format(
			date_format,
			time, day, month, year
		)
	elseif Config.date.format == 'withWeekdayAndHours' then
		timeString = string.format(
			date_format,
			time, weekDay, day, month, year
		)
	end
	return timeString
end

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

--acaestaba
RegisterCommand('toggleui', function()
	TriggerEvent('es_extended:hideIds')
	if not toggleui then
		SendNUIMessage({ action = 'element', task = 'disable', value = 'job' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'society' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'bank' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'blackMoney' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'wallet' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'status' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'date' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'location' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'voice' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'server' })
		SendNUIMessage({action = 'element', task = 'disable', value = 'userID' })
		DisplayRadar(false)
		TriggerEvent('onlineJobs:ToggleUI')
	else
		if (Config.ui.showJob == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'job' })
		end
		if (Config.ui.showSocietyMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'society' })
		end
		if (Config.ui.showBankMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'bank' })
		end
		if (Config.ui.showBlackMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'blackMoney' })
		end
		if (Config.ui.showWalletMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'wallet' })
		end
		if(Config.ui.showStatus == true)then
			SendNUIMessage({action = 'element', task = 'enable', value = 'status' })
		end
		if(Config.ui.showInfoTime == true)then
			SendNUIMessage({action = 'element', task = 'enable', value = 'date' })
			SendNUIMessage({action = 'element', task = 'enable', value = 'location' })
			SendNUIMessage({action = 'element', task = 'enable', value = 'userID' })
		end
		if(Config.ui.showVoice == true)then
			SendNUIMessage({action = 'element', task = 'enable', value = 'voice' })
		end
		if(Config.ui.showServerLogo == true)then
			SendNUIMessage({action = 'element', task = 'enable', value = 'server' })
		end
		DisplayRadar(true)
		TriggerEvent('onlineJobs:ToggleUI')
	end
	toggleui = not toggleui
	TriggerEvent('showID:toggleUI')
end)

exports('createStatus', function(args)
	local statusCreation = { action = 'createStatus', status = args['status'], color = args['color'], icon = args['icon'] }
	SendNUIMessage(statusCreation)
end)

exports('setStatus', function(args)
	local playerStatus = { action = 'setStatus', status = {
		{ name = args['name'], value = args['value'] }
	}}
	SendNUIMessage(playerStatus)
end)
