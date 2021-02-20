local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

ESX = nil
local menuIsShowed = false
local hasAlreadyEnteredMarker = false
local isInMarker = false
local PlayerData

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end
    PlayerData = ESX.GetPlayerData()
end)

        

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    local jobs = {'police', 'ambulance', 'arcadius', 'mechanic'}

    Citizen.CreateThread(function()
        Citizen.Wait(500)
        for k, v in pairs(jobs) do
            if PlayerData.job.name == v then
                TriggerServerEvent('duty:onoff')
            end
        end
    end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

function ShowJobListingMenu()
	ESX.TriggerServerCallback('esx_joblisting:getJobsList', function(jobs)
		local elements = {}

		for i=1, #jobs, 1 do
			table.insert(elements, {
				label = jobs[i].label,
				job   = jobs[i].job
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'joblisting', {
			title    = _U('job_center'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			TriggerServerEvent('esx_joblisting:setJob', data.current.job)
			ESX.ShowNotification(_U('new_job'))
			menu.close()
		end, function(data, menu)
			menu.close()
		end)

	end)
end

AddEventHandler('esx_joblisting:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

local coords
Citizen.CreateThread(function()
	while true do
	coords=GetEntityCoords(PlayerPedId())
	Citizen.Wait(200)
	end
end)

-- Activate menu when player is inside marker, and draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		isInMarker = false

		local distance = #(coords- Config.Zone)
		local sleep = true

		if distance < Config.DrawDistance then
			DrawMarker(Config.MarkerType, Config.Zone, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			if distance < (Config.ZoneSize.x / 2) then
				isInMarker = true
				SetTextComponentFormat('STRING')
				AddTextComponentString(_U('access_job_center'))
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
				if IsControlJustReleased(0, 38) then
					ESX.UI.Menu.CloseAll()
					ShowJobListingMenu()
					menuIsShowed=true
				end
			else 
				if menuIsShowed then
				ESX.UI.Menu.CloseAll()
				menuIsShowed=true
				end
			end
			sleep=false
		end

		if sleep then 
			Citizen.Wait(2000)
		end
	end
end)

-- Create blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zone)

	SetBlipSprite (blip, 407)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.2)
	SetBlipColour (blip, 27)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName(_U('job_center'))
	EndTextCommandSetBlipName(blip)
end)

local jobs = {
    "arcadius",
    "police",
    "mechanic",
    "ambulance",
}

-- keycontrols
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if PlayerData and PlayerData.job~=nil then
            local sleep = true
            for k, v in pairs(Config.Zones) do
                local distance = #(coords -vector3(v.Pos.x, v.Pos.y, v.Pos.z))
                if (v.Type ~= -1 and distance < Config.DrawDistance) then
                    DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z,v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
                    sleep=false
                    if distance < v.Size.x/2 then
                        SetTextComponentFormat('STRING')
                        AddTextComponentString("Presiona ~INPUT_CONTEXT~ para ~g~entrar~w~/~r~salir ~w~de servicio")
                        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                        if IsControlJustReleased(0,38) then
                            local job = PlayerData.job.name
                            for key,value in pairs(jobs) do
                                if job=="off"..value then
                                    if string.sub(job,4,#job) == k then
                                        TriggerServerEvent('esx_duty:service',job,true)
                                        sendNotification(_U('onduty'), 'success', 2500)
                                        Citizen.Wait(1500)
                                        break
                                    end
                                elseif job==value then
                                    if job == k then
                                        TriggerServerEvent('esx_duty:service',job,false)
                                        sendNotification(_U('offduty'), 'success', 2500)
                                        Citizen.Wait(1500)
                                        break
                                    end
                                end
                            end
                        end
                    end
                    break
                end
            end
            if sleep then
                Citizen.Wait(2500)
            end
        else 
            Citizen.Wait(1000)
        end
    end
end)

-- notification
function sendNotification(message, messageType, messageTimeout)
    TriggerEvent("pNotify:SendNotification", {
        text = message,
        type = messageType,
        queue = "duty",
        timeout = messageTimeout,
        layout = "bottomCenter"
    })
end
