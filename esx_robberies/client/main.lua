ESX = nil
local holdingUp = false
local ped,location,isdead,closest,armed,closestdoor,closesthouse,closeststore,closeststorename,currentStore,vangelico,closesthousekey
local soundid, vetrineRotte = GetSoundId(),0 
animazione = false

local vetrine = {
	{x = 147.085, y = -1048.612, z = 29.346, heading = 70.326, isOpen = false},--
	{x = -626.735, y = -238.545, z = 38.057, heading = 214.907, isOpen = false},--
	{x = -625.697, y = -237.877, z = 38.057, heading = 217.311, isOpen = false},--
	{x = -626.825, y = -235.347, z = 38.057, heading = 33.745, isOpen = false},--
	{x = -625.77, y = -234.563, z = 38.057, heading = 33.572, isOpen = false},--
	{x = -627.957, y = -233.918, z = 38.057, heading = 215.214, isOpen = false},--
	{x = -626.971, y = -233.134, z = 38.057, heading = 215.532, isOpen = false},--
	{x = -624.433, y = -231.161, z = 38.057, heading = 305.159, isOpen = false},--
	{x = -623.045, y = -232.969, z = 38.057, heading = 303.496, isOpen = false},--
	{x = -620.265, y = -234.502, z = 38.057, heading = 217.504, isOpen = false},--
	{x = -619.225, y = -233.677, z = 38.057, heading = 213.35, isOpen = false},--
	{x = -620.025, y = -233.354, z = 38.057, heading = 34.18, isOpen = false},--
	{x = -617.487, y = -230.605, z = 38.057, heading = 309.177, isOpen = false},--
	{x = -618.304, y = -229.481, z = 38.057, heading = 304.243, isOpen = false},--
	{x = -619.741, y = -230.32, z = 38.057, heading = 124.283, isOpen = false},--
	{x = -619.686, y = -227.753, z = 38.057, heading = 305.245, isOpen = false},--
	{x = -620.481, y = -226.59, z = 38.057, heading = 304.677, isOpen = false},--
	{x = -621.098, y = -228.495, z = 38.057, heading = 127.046, isOpen = false},--
	{x = -623.855, y = -227.051, z = 38.057, heading = 38.605, isOpen = false},--
	{x = -624.977, y = -227.884, z = 38.057, heading = 48.847, isOpen = false},--
	{x = -624.056, y = -228.228, z = 38.057, heading = 216.443, isOpen = false},--
}


Citizen.CreateThread(function()
	while ESX == nil do
	TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
	Citizen.Wait(5)
	end
end)

Citizen.CreateThread(function()
	for k, v in pairs(Config.Places) do
		local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)

		SetBlipSprite(blip, 255)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Robar")
		EndTextCommandSetBlipName(blip)
	end
	for k,v in pairs(Config.Stores) do
		local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)

		SetBlipSprite(blip, 255)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Robar")
		EndTextCommandSetBlipName(blip)
	end
	if true then
		local blip = AddBlipForCoord(Config.Vangelico.position.x, Config.Vangelico.position.y, Config.Vangelico.position.z)

		SetBlipSprite(blip, 255)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Robar")
		EndTextCommandSetBlipName(blip)
	end

	local blip = AddBlipForCoord(60.32, 3703.99, 47.1)
	SetBlipSprite(blip, 84)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip,75)
	SetBlipCategory(blip, 3)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Tierra de nadie")
	EndTextCommandSetBlipName(blip)

	local radius = AddBlipForRadius(60.32, 3703.99, 47.1,150.0)

	SetBlipHighDetail(radius, true)
	SetBlipAlpha(radius, 150)
	SetBlipColour(radius, 75)
	SetBlipAsShortRange(radius, true)
	SetBlipAsShortRange(radius, true)
end)

Citizen.CreateThread(function()
while true do
	ped = PlayerPedId()
	location = GetEntityCoords(ped, true)
	isdead=IsPedDeadOrDying(ped)
	armed=IsPedArmed(ped,4)
	local joined,joined2,joined3,joined4=false,false,false,false
	for k,v in pairs(Config.Places)do
		local place = v.position
		local distance = GetDistanceBetweenCoords(location.x, location.y, location.z, place.x, place.y, place.z, true)
		if(distance<18.0)then
			closest=v
			joined=true
			break
		end
	end
	for k,v in pairs(Config.Stores)do
		local place = v.position
		local distance = GetDistanceBetweenCoords(location.x,location.y,location.z,place.x,place.y,place.z,true)
		if(distance<15.0)then
			closeststore=v
			closeststorename=k
			joined4=true
			break
		end
	end
	for k,v in pairs(Config.Houses)do
		local place = v.position
		local distance = GetDistanceBetweenCoords(location.x, location.y, location.z, place.x, place.y, place.z, true)
		if(distance<15.0)then
			closesthouse=v
			closesthousekey=k
			joined3=true
			break
		end
	end
	for k,v in pairs(Config.Doors)do
		local place = v.position
		local distance= GetDistanceBetweenCoords(location.x, location.y, location.z, place.x, place.y, place.z, true)
		if(distance<7.0)then
			closestdoor=v
			joined2=true
			break
		end
	end

	if(not joined and closest~=nil)then
		closest=nil
	end
	if (not joined2 and closestdoor~=nil)then
		closestdoor=nil
	end
	if (not joined3 and closesthouse~=nil)then
		closesthouse=nil
		closesthousekey=nil
	end
	if (not joined4 and closeststore~=nil)then
		closeststore=nil
		closeststorename=nil
	end
	Citizen.Wait(800)
end
end)

Citizen.CreateThread(function()
	ped = PlayerPedId()
	while true do
		Citizen.Wait(5)
		if not holdingUp then
			if(closestdoor~=nil)then
				local playerLoc = GetEntityCoords(ped,true)
				local coords = closestdoor.position
				local distance = GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, coords.x, coords.y, coords.z, true)
				if(distance<2.0)then
					showHelpText("Presione ~INPUT_CONTEXT~ para hackear la puerta")
					--ESX.ShowHelpNotification("Presione ~INPUT_CONTEXT~ para hackear la puerta")
					if(IsControlJustPressed(0,38))then
						ESX.TriggerServerCallback("esx_robberies:isValid",function(isValid)
							if(isValid)then
								holdingUp=true
								TriggerServerEvent("esx_robberies:alertPolice","Un intento de robo en ~y~"..closest.name,coords)
								idcard()
								Citizen.Wait(2500)
								ESX.ShowNotification("Una alerta de robo fue enviada a la policia")
								PlaySoundFromCoord(soundid, "RESIDENT_VEHICLES_SIREN_QUICK_02", coords.x, coords.y, coords.z)
								sound()
								TriggerEvent("mhacking:show")
								TriggerEvent('mhacking:start',6,35,mycb)
							end
						end,"bankdoor",nil)
					end
				else
					Citizen.Wait(100)
				end
			elseif(closest~=nil)then
				local playerLoc = GetEntityCoords(ped,true)
				local coords = closest.position
				local distance = GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, coords.x, coords.y, coords.z, true)
				DrawMarker(1, coords.x, coords.y, coords.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0, 1.5, 255, 0, 0, 255, false, true, 2, false, false, false, false)
				if(distance<1.0)then
					showHelpText("Presione ~INPUT_CONTEXT~ para asaltar "..closest.help)
						--ESX.ShowHelpNotification("Presione ~INPUT_CONTEXT~ para robar ~b~" .. closest.name)
					if(IsControlJustPressed(0,38))then
						local type = "bank"
						if(closest.name=="Banco Principal")then
							type="bankc"
						end
						ESX.TriggerServerCallback("esx_robberies:isValid",function(isValid)
							if(isValid)then
								holdingUp=true
								if(closest.name~="Banco Principal")then
								ESX.ShowNotification("Una alerta de robo en fue enviada a la policia")
								TriggerServerEvent("esx_robberies:alertPolice","Un intento de robo en ~y~"..closest.name,coords)
								end
								TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)
								Citizen.Wait(2750)
								local try1 = OpenScaleform(3, 1, "VERIFYING HACKING", 12000, 2000)
								if try1 then
								local try3 = OpenScaleform(3, 3, "VERIFYING HACKING", 20000, 2000)
									if try3 then
									--ESX.ShowNotification("Has recibido tu dinero")
									TriggerServerEvent("esx_robberies:cashOut",closest)
									else
										ESX.ShowNotification("Hackeo fallido, ten cuidado, la alerta fue enviada igualmente a la policia")
									end
								else
									ESX.ShowNotification("Hackeo fallido, ten cuidado, la alerta fue enviada igualmente a la policia")
								end
								ClearPedTasks(ped)
								holdingUp = false
							end
						end,type,nil)
					end
				end
			elseif(closesthouse~=nil)then
				local playerLoc = GetEntityCoords(ped,true)
				local coords = closesthouse.position
				local distance = GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, coords.x, coords.y, coords.z, true)
				DrawMarker(1, coords.x, coords.y, coords.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0, 1.5, 255, 0, 0, 255, false, true, 2, false, false, false, false)
				if(distance<1.0)then
					showHelpText("Presione ~INPUT_CONTEXT~ para asaltar la casa")
					--ESX.ShowHelpNotification("Presione ~INPUT_CONTEXT~ para robar la casa")
					if(IsControlJustPressed(0,38))then
						local ty = "house"
						if(closesthouse.alert==true)then
							ty="housea"
						end
						ESX.TriggerServerCallback("esx_robberies:isValid",function(isValid)
							if(isValid)then
								holdingUp=true
								if(IsPedArmed(ped,4))then
								SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
								Citizen.Wait(2000)
								else
									Citizen.Wait(800)
								end
								if(closesthouse.alert==true)then
									local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
								TriggerServerEvent("esx_robberies:alertPolice","Un intento de robo en una casa de ~y~"..streetName,coords)
									ESX.ShowNotification("Alerta enviada a la policia.")
								end
								--TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)
								TriggerEvent("dpemotes:robbering", true)
								SetEntityHeading(PlayerPedId(),coords.heading)
								TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING",0,true)
								Citizen.Wait(15000)
								ClearPedTasks(ped)
								Citizen.Wait(300)
								local random = math.random(1,100)
								if(random<=8)then
								ESX.ShowNotification("Al parecer se te quebro la palanca, robo fallido")	
								TriggerServerEvent("esx_robberies:failedRobbery")
								else
								ESX.ShowNotification("Puerta forzada exitosamente, recogiendo objetos..")
								Citizen.Wait(1500)
								SetEntityHeading(PlayerPedId(),coords.heading)
								TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN",0,true)
								TriggerServerEvent("esx_robberies:houseItems")
								Citizen.Wait(4000)
								ClearPedTasks(ped)
								end
								TriggerEvent("dpemotes:robbering", false)
								holdingUp = false
							end
						end,ty,closesthousekey)
					end
				end
			elseif(closeststore~=nil)then
				local coords = closeststore.position
				local vec1 = vector3(location.x,location.y,location.z)
				local vec2 = vector3(coords.x,coords.y,coords.z)
				local distance = #(vec1-vec2)				
				DrawMarker(1, coords.x, coords.y, coords.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0, 1.5, 255, 0, 0, 255, false, true, 2, false, false, false, false)				 
				if(distance<1.5)then
					if(closeststore.armery~=nil and closeststore.armery==nil)then
						showHelpText("Presione ~INPUT_CONTEXT~ para asaltar la armeria")
					else
						showHelpText("Presione ~INPUT_CONTEXT~ para asaltar la tienda")
					end
					if(IsControlJustReleased(0,38))then
						if(armed)then
							TriggerServerEvent("esx_robberies:storeRobbery",closeststorename)
						else
							ESX.ShowNotification("Debes tener una pistola en la mano para comenzar el robo")
						end
					end
				end
			else
				Citizen.Wait(1500)
			end
		else
			Citizen.Wait(80)
		end
		if (holdingUp or IsScaleform()) and isdead and currentStore==nil then
			CloseScaleform()
			TriggerEvent('mhacking:hide')
			holdingUp = false
		end
		if(holdingUp and currentStore~=nil)then
			local coords = Config.Stores[currentStore].position
			local vec1 = vector3(coords.x,coords.y,coords.z)
			local vec2 = vector3(location.x,location.y,location.z)
			if((#(vec1-vec2))>Config.MaxDistance)then
				TriggerServerEvent('esx_robberies:tooFar',currentStore)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(5)
		local v = Config.Vangelico
		local pos2 = v.position
		if(not holdingUp) then
			local distance = Vdist(location.x,location.y,location.z,pos2.x,pos2.y,pos2.z)
			if(distance<12.0)then
				DrawMarker(1, pos2.x, pos2.y, pos2.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0, 1.5, 255, 0, 0, 255, false, true, 2, false, false, false, false)
				if(distance<1.0)then
					showHelpText("Presiona ~INPUT_CONTEXT~ para asaltar la joyeria")
					if(IsControlJustPressed(0,38))then
						if(armed)then
							TriggerServerEvent('esx_robberies:vangelico')
						else
							ESX.ShowNotification("Debes tener una pistola en la mano para comenzar el robo")
						end
					end
				end	
			elseif distance>=25 then
				Citizen.Wait(1000)
			end
		end

		if holdingUp and vangelico then
			drawTxt(0.66, 1.44, 1.0, 1.0, 0.4, "Vitrinas robadas: ~r~"..vetrineRotte.."/5", 255, 255, 255, 255)
			--drawTxt2(0.3, 1.4, 0.45, "Vitrinas robadas" .. ' :~r~ ' .. vetrineRotte .. '/' .. 8, 185, 185, 185, 255)

			for i,v in pairs(vetrine) do
				local distance = GetDistanceBetweenCoords(location,v.x,v.y,v.z,true)
				if(distance < 10.0) and not v.isOpen then 
					DrawMarker(20, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.6, 0, 255, 0, 200, 1, 1, 0, 0)
				end
				if(distance < 0.75) and not v.isOpen then 
					DrawText3D(v.x, v.y, v.z, '~w~[~g~E~w~] ' .. "para robar joyas", 0.6)
					if IsControlJustPressed(0, 38) then
						animazione = true
					    SetEntityCoords(ped, v.x, v.y, v.z-0.95)
					    SetEntityHeading(ped, v.heading)
						v.isOpen = true 
						PlaySoundFromCoord(-1, "Glass_Smash", v.x, v.y, v.z, "", 0, 0, 0)
					    if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
					    RequestNamedPtfxAsset("scr_jewelheist")
					    end
					    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
					    Citizen.Wait(0)
					    end
					    SetPtfxAssetNextCall("scr_jewelheist")
					    StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", v.x, v.y, v.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
					    loadAnimDict( "missheist_jewel" ) 
						TaskPlayAnim(ped, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
						TriggerEvent("mt:missiontext", "Recoleccion en progreso", 3000)
					    
					    DrawSubtitleTimed(5000, 1)
					    Citizen.Wait(5000)
					    ClearPedTasksImmediately(ped)
					    TriggerServerEvent('esx_vangelico_robbery:gioielli')
					    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					    vetrineRotte = vetrineRotte+1
					    animazione = false

						if vetrineRotte == 5 then 
						    for i,v in pairs(vetrine) do 
								v.isOpen = false
								vetrineRotte = 0
							end
							TriggerServerEvent('esx_vangelico_robbery:endrob')
						    --ESX.ShowNotification(_U('lester'))
							holdingUp = false
							vangelico=false
						    --StopSound(soundid)
						end
					end
				end	
			end

			if (GetDistanceBetweenCoords(location, -622.566, -230.183, 38.057, true) > 13.5 ) then
				TriggerServerEvent('esx_vangelico_robbery:toofar', store)
				holdingUp = false
				vangelico=false
				for i,v in pairs(vetrine) do 
					v.isOpen = false
					vetrineRotte = 0
				end
				StopSound(soundid)
			end
		end
	end
end)

RegisterNetEvent('esx_vangelico_robbery:currentlyrobbing')
AddEventHandler('esx_vangelico_robbery:currentlyrobbing', function(robb)
	holdingUp = true
	vangelico=true
	PlaySoundFromCoord(soundid, "RESIDENT_VEHICLES_SIREN_QUICK_02", robb.position.x, robb.position.y, robb.position.z)
	sound()
end)

RegisterNetEvent('esx_vangelico_robbery:robberycomplete')
AddEventHandler('esx_vangelico_robbery:robberycomplete', function()
	holdingUp = false
	vangelico=false
end)

RegisterNetEvent('esx_robberies:storeRobberyStart')
AddEventHandler('esx_robberies:storeRobberyStart',function(store)
	holdingUp=true
	currentStore=store
	ESX.ShowNotification("Una alerta de robo fue enviada a la policia")
	PlaySoundFromCoord(soundid, "RESIDENT_VEHICLES_SIREN_QUICK_02", Config.Stores[store].position.x, Config.Stores[store].position.y, Config.Stores[store].position.z)
	sound()
	local timer = Config.Stores[store].secondsRemaining
	Citizen.CreateThread(function()
		while timer > 0 and currentStore~=nil do
			Citizen.Wait(1000)
			if(timer>0)then
				timer=timer-1
			end
		end
	end)

	Citizen.CreateThread(function()
		while holdingUp and currentStore~=nil do
			Citizen.Wait(5)
			local msg
			if(Config.Stores[currentStore].armery)then
				msg = "Robo a armeria ~r~%s ~s~segundos restantes"
			else
			 msg = "Robo a tienda ~r~%s ~s~segundos restantes"
			end
			drawTxt(0.66, 1.44, 1.0, 1.0, 0.4, string.format(msg,timer), 255, 255, 255, 255)
		end
	end)
end)

local blipRobbery = {}

RegisterNetEvent('esx_robberies:setBlip')
AddEventHandler('esx_robberies:setBlip', function(position,id)
	blipRobbery[id] = AddBlipForCoord(position.x, position.y, position.z)

	SetBlipSprite(blipRobbery[id], 161)
	SetBlipScale(blipRobbery[id], 2.0)
	SetBlipColour(blipRobbery[id], 3)

	PulseBlip(blipRobbery[id])
end)


RegisterNetEvent('esx_robberies:killBlip')
AddEventHandler('esx_robberies:killBlip', function(id)
	if(blipRobbery[id])then
	RemoveBlip(blipRobbery[id])
	end
end)

RegisterNetEvent('esx_robberies:storeRobberyCompleted')
AddEventHandler('esx_robberies:storeRobberyCompleted',function()
	holdingUp=false
	currentStore=nil
	ESX.ShowNotification("El robo ha sido exitoso! Espera a la policia")
	PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
end)

RegisterNetEvent('esx_robberies:tooFar')
AddEventHandler('esx_robberies:tooFar',function()
	holdingUp=false
	currentStore=nil
	ESX.ShowNotification("El robo fue cancelado porque te alejaste demasiado.")
end)

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end)

function sound()
	Citizen.CreateThread(function()
	Citizen.Wait(2200)
	StopSound(soundid)
	end)
end

function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)
end

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function showHelpText(s)
	SetTextComponentFormat("STRING")
	AddTextComponentString(s)
	EndTextCommandDisplayHelp(0,0,0,-1)
end

function idcard()
	RequestModel("p_ld_id_card_01")
    while not HasModelLoaded("p_ld_id_card_01") do
        Citizen.Wait(1)
    end
    local ped = PlayerPedId()
    SetEntityCoords(ped, 261.89, 223.5, 105.30, 1, 0, 0, 1)
    SetEntityHeading(ped, 255.92)
    Citizen.Wait(100)
    local pedco = GetEntityCoords(ped)
    local IdProp = CreateObject(GetHashKey("p_ld_id_card_01"), pedco, true, true, false)
    local boneIndex = GetPedBoneIndex(ped, 28422)
    --local panel = ESX.Game.GetClosestObject(("hei_prop_hei_securitypanel"), pedco)
    local panel = GetClosestObjectOfType(pedco, 4.0, GetHashKey("hei_prop_hei_securitypanel"), false, false, false)

    AttachEntityToEntity(IdProp, ped, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
	TaskStartScenarioInPlace(ped, "PROP_HUMAN_ATM", 0, true)
	Citizen.Wait(1500)
    AttachEntityToEntity(IdProp, panel, boneIndex, -0.09, -0.02, -0.08, 270.0, 0.0, 270.0, true, true, false, true, 1, true)
    FreezeEntityPosition(IdProp)
    Citizen.Wait(500)
    ClearPedTasksImmediately(ped)
    Citizen.Wait(900)
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)
end

function drawTxt2(x, y, scale, text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.64, 0.64)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(0.155, 0.935)
end

function drawTxt(x,y, width, height, scale, text, r,g,b,a, outline)
	SetTextFont(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0,255)
	SetTextDropShadow()
	if outline then SetTextOutline() end

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

function mycb(success, timeremaining)
	ClearPedTasks(ped)
	if success then
		Citizen.Wait(1000)
		ESX.ShowNotification("Se ha desbloqueado la puerta")
		TriggerServerEvent("esx_robberies:unlockDoor")
	else
		ESX.ShowNotification("Hackeo fallido, ten cuidado, una alerta de robo fue enviada a la policia")
	end
	TriggerEvent('mhacking:hide')
	holdingUp = false
end
