--================================================================================================--
--==                                VARIABLES - DO NOT EDIT                                     ==--
--================================================================================================--
ESX                         = nil
inMenu                      = true
local atbank = false
local bankMenu = true
local opened = false

local keys = {
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

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

--================================================================================================
--==                                THREADING - DO NOT EDIT                                     ==
--================================================================================================

--===============================================
--==           Base ESX Threading              ==
--===============================================
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--===============================================
--==             Core Threading                ==
--===============================================

Citizen.CreateThread(function()
	while true do
		sleep = true
		Wait(6)
		if nearBank() or nearATM() then
			DisplayHelpText(_U('atm_open'))
			sleep=false
			if IsControlJustPressed(1, keys[Config.Keys.Open]) then
				openUI()
				opened=true
				TriggerServerEvent('bank:balance')
				local ped = GetPlayerPed(-1)
			end		
		end
		if opened then
			sleep=false
			if IsControlJustPressed(1, keys[Config.Keys.Close]) then
				closeUI()
			end
		end
		if sleep then
		Citizen.Wait(800)
		end
	end
end)

--===============================================
--==             Map Blips	                   ==
--===============================================

--BANK
Citizen.CreateThread(function()
	  for k,v in ipairs(Config.Bank)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite (blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.9)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U("bank_blip"))
		EndTextCommandSetBlipName(blip)
	  end
end)

--ATM
Citizen.CreateThread(function()
	if Config.ShowBlips and Config.OnlyBank == false then
	  for k,v in ipairs(Config.ATM)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite (blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.9)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U("atm_blip"))
		EndTextCommandSetBlipName(blip)
	  end
	end
end)


--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance)
	local id = PlayerId()
	local playerName = GetPlayerName(id)

	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName
		})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('bank:depothecrowsrp2sit', tonumber(data.amount))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('bank:witthecrowsrp2hdraw', tonumber(data.amountw))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('bank:transthecrowsrp2fer', data.to, data.amountt)
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Result   Event                    ==
--===============================================
RegisterNetEvent('bank:result')
AddEventHandler('bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	closeUI()
	opened=false
end)

AddEventHandler('onResourceStop', function (resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	closeUI()
	opened=false
end)

AddEventHandler('onResourceStart', function (resourceName)
	if(GetCurrentResourceName() ~= resourceName) then
		return
	end
	closeUI()
	opened=false
end)

local playerloc

Citizen.CreateThread(function()
	while true do
		playerloc=GetEntityCoords(PlayerPedId())
		Citizen.Wait(600)
	end
end)

--===============================================
--==            Capture Bank Distance          ==
--===============================================
function nearBank()
	for _, search in pairs(Config.Bank) do
		local distance = #(vector3(search.x, search.y, search.z)- playerloc)

		if distance <= 0.9 then
			return true
		end
	end
	return false
end

function nearATM()
	for _, search in pairs(Config.ATM) do
		local distance = #(vector3(search.x, search.y, search.z)-playerloc)

		if distance <= 0.9 then
			return true
		end
	end
	return false
end

function closeUI()
	inMenu = false
	SetNuiFocus(false, false)
	if Config.Animation.Active then 
		playAnim('mp_common', 'givetake1_a', Config.Animation.Time)
		Citizen.Wait(Config.Animation.Time)
	end
	SendNUIMessage({type = 'closeAll'})
end

function openUI()
	if Config.Animation.Active then 
		playAnim('mp_common', 'givetake1_a', Config.Animation.Time)
		Citizen.Wait(Config.Animation.Time)
	end
	inMenu = true
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openGeneral'})
	TriggerServerEvent('bank:balance')
end


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
