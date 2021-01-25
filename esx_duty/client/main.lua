local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173
}

--- action functions
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local HasAlreadyEnteredMarker = false
local LastZone = nil

--- esx
local GUI = {}
ESX = nil
GUI.Time = 0
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
        PlayerData = ESX.GetPlayerData()
    end
end)

function open()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default',GetCurrentResourceName(),'sound',{
                title="Sonidos",
                align="top-left",
                elements={
                    {label="BebeLean", value="bebelean"},
                    {label="Pausar",value="pause"}
                }
            },function(data, menu)
                if(data.current.value=="bebelean")then
                TriggerServerEvent('InteractSound_SV:PlayOnOne',GetPlayerServerId(PlayerId()),"bebelean",1.0)
				
                menu.close()
                else
                    TriggerEvent('InteractSound_CL:Pause')
                    menu.close()
                end
            end,function(data,menu)
                menu.close()
            end)
end

Citizen.CreateThread(function()
    while true do
        if IsControlJustReleased(0,168) then 
            open()
        end
        Citizen.Wait(6)
    end
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

AddEventHandler('esx_duty:hasEnteredMarker', function(zone)
    if zone == 'AmbulanceDuty' then
        CurrentAction = 'ambulance_duty'
        CurrentActionMsg = _U('duty')
        CurrentActionData = {}
    end
    if zone == 'PoliceDuty' then
        CurrentAction = 'police_duty'
        CurrentActionMsg = _U('duty')
        CurrentActionData = {}
    end
    if zone == 'MechanicDuty' then
        CurrentAction = 'mechanic_duty'
        CurrentActionMsg = _U('duty')
        CurrentActionData = {}
    end
    if zone == 'ArcadiusDuty' then
        CurrentAction = 'arcadius_duty'
        CurrentActionMsg = _U('duty')
        CurrentActionData = {}
    end
    if zone == 'TaxiDuty' then
        CurrentAction = 'taxi_duty'
        CurrentActionMsg = _U('duty')
        CurrentActionData = {}
    end
    --[[ if zone == 'UnicornDuty' then
    CurrentAction     = 'unicorn_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  end
  if zone == 'BahamasDuty' then
    CurrentAction     = 'bahamas_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  end ]]

end)

AddEventHandler('esx_duty:hasExitedMarker', function(zone)
    CurrentAction = nil
end)

local playerPed,coords
Citizen.CreateThread(function()
    while true do
		playerPed = GetPlayerPed(-1)
		coords = GetEntityCoords(playerPed)
		Citizen.Wait(500)
    end
end)

-- keycontrols
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(6)

        if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)

            if IsControlPressed(0, Keys['E']) then
               --[[  if CurrentAction == 'bahamas_duty' then
                    if PlayerData.job.name == 'bahamas' or PlayerData.job.name == 'offbahamas' then
                        TriggerServerEvent('duty:bahamas')
                        if PlayerData.job.name == 'bahamas' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('notbah'), 'error', 5000)
                        Wait(2000)
                    end
                end

                if CurrentAction == 'unicorn_duty' then
                    if PlayerData.job.name == 'unicorn' or PlayerData.job.name == 'offunicorn' then
                        TriggerServerEvent('duty:unicorn')
                        if PlayerData.job.name == 'unicorn' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('notuni'), 'error', 5000)
                        Wait(2000)
                    end
                end

                if CurrentAction == 'taxi_duty' then
                    if PlayerData.job.name == 'taxi' or PlayerData.job.name == 'offtaxi' then
                        TriggerServerEvent('duty:taxi')
                        if PlayerData.job.name == 'taxi' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('nottax'), 'error', 5000)
                        Wait(2000)
                    end
                end ]]
                if CurrentAction == 'arcadius_duty' then
                    if PlayerData.job.name == 'arcadius' or PlayerData.job.name == 'offarcadius' then
                        TriggerServerEvent('duty:arcadius')
                        if PlayerData.job.name == 'arcadius' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('notarc'), 'error', 5000)
                        Wait(2000)
                    end
                elseif CurrentAction == 'mechanic_duty' then
                    if PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'offmechanic' then
                        TriggerServerEvent('duty:mechanic')
                        exports.ft_libs:EnableArea("esx_eden_garage_area_Bennys_mecanodeletepoint")
                        exports.ft_libs:EnableArea("esx_eden_garage_area_Bennys_mecanospawnpoint")
                        if PlayerData.job.name == 'mechanic' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('notmech'), 'error', 5000)
                        Wait(2000)
                    end
                elseif CurrentAction == 'ambulance_duty' then
                    if PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
                        TriggerServerEvent('duty:ambulance')
                        if PlayerData.job.name == 'ambulance' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('notamb'), 'error', 5000)
                        Wait(2000)
                    end
                elseif CurrentAction == 'police_duty' then
                    if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' then
                        TriggerServerEvent('duty:police')

                        if PlayerData.job.name == 'police' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('notpol'), 'error', 5000)
                        Wait(2000)
                    end
                end
            end
        else
            Citizen.Wait(350)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(5)
        local sleep = true
        for k, v in pairs(Config.Zones) do
            if (v.Type ~= -1 and #(coords -vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < Config.DrawDistance) then
                DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z,
                    v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
                    sleep=false
                    break
            end
        end
        if sleep then
            Citizen.Wait(2000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(100)
        local isInMarker = false
        local currentZone = nil

        for k, v in pairs(Config.Zones) do
            if (#(coords- vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < v.Size.x) then
                isInMarker = true
                currentZone = k
                break
            end
        end

        if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
            HasAlreadyEnteredMarker = true
            LastZone = currentZone
            TriggerEvent('esx_duty:hasEnteredMarker', currentZone)
        end

        if not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            TriggerEvent('esx_duty:hasExitedMarker', LastZone)
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
