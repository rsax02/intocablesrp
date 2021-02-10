
ESX = nil

local blip = nil
local completepaytable = nil
local tableupdate = false
local temppaytable =  nil
local totalbagpay = 0
local lastpickup = nil
local platenumb = nil
local paused = false
local iscurrentboss = false
local work_truck = nil
local truckdeposit = false
local trashcollection = false
local trashcollectionpos = nil
local bagsoftrash = nil
local currentbag = nil
local bagsCount = 0
local namezone = "Delivery"
local namezonenum = 0
local namezoneregion = 0
local MissionRegion = 0
local viemaxvehicule = 1000
local argentretire = 0
local livraisonTotalPaye = 0
local livraisonnombre = 0
local MissionRetourCamion = false
local MissionNum = 0
local MissionLivraison = false
local isInService = false
local PlayerData              = nil
local GUI                     = {}
GUI.Time                      = 0
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local Blips                   = {}
local plaquevehicule = ""
local plaquevehiculeactuel = ""
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local totalBags = 0

local ped = PlayerPedId()
local coords = GetEntityCoords(ped)
--------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
	refreshBlip()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
	refreshBlip()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	refreshBlip()
end)

RegisterNetEvent('esx_garbage:setbin')
AddEventHandler('esx_garbage:setbin', function(binpos, platenumber,  bags)
	if isInService then
		if GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, false)) == platenumber then
			work_truck = GetVehiclePedIsIn(ped, false)
			platenumb = platenumber
			trashcollectionpos = binpos
			bagsoftrash = bags
			currentbag = bagsoftrash
			MissionLivraison = false
			trashcollection = true
			paused = true
			CurrentActionMsg = ''
			CollectionAction = 'collection'
		end
	end
end)

RegisterNetEvent('esx_garbage:addbags')
AddEventHandler('esx_garbage:addbags', function(platenumber, bags, crewmember)
	if isInService then
		if platenumb == platenumber then
			if iscurrentboss then
				totalbagpay = totalbagpay + bags
				addcremember = true
				if temppaytable == nil then
					temppaytable = {}
				 end

				for i, v in pairs(temppaytable) do

					if temppaytable[i] == crewmember then
						addcremember = false
					end
				end
				if addcremember then
					table.insert(temppaytable, crewmember)
				end
			end
		end
	end
end)

RegisterNetEvent('esx_garbage:startpayrequest')
AddEventHandler('esx_garbage:startpayrequest', function(platenumber, amount)
	if isInService then
		if platenumb == platenumber then
			if bagsCount==0 then return end
			bagsCount=0
			TriggerServerEvent('esx_garbage:pay', amount)
			platenumb = nil
		end
	end
end)

RegisterNetEvent('esx_garbage:removedbag')
AddEventHandler('esx_garbage:removedbag', function(platenumber)
	if isInService then
		if platenumb == platenumber then
			currentbag = currentbag - 1
		end
	end
end)

RegisterNetEvent('esx_garbage:countbagtotal')
AddEventHandler('esx_garbage:countbagtotal', function(platenumber)
	if isInService then
		if platenumb == platenumber then
			if not iscurrentboss then
			TriggerServerEvent('esx_garbage:bagsdone', platenumb, totalbagpay)
			totalbagpay = 0
			end
		end
	end
end)

RegisterNetEvent('esx_garbage:clearjob')
AddEventHandler('esx_garbage:clearjob', function(platenumber)
	if platenumb == platenumber then
		trashcollectionpos = nil
		totalBags=bagsoftrash
		bagsoftrash = nil
		work_truck = nil
		trashcollection = false
		truckdeposit = false
		CurrentAction = nil
		CollectionAction = nil
		paused = false
	end

end)

-- MENUS
function MenuCloakRoom()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			elements = {
				{label = _U('job_wear'), value = 'job_wear'},
				{label = _U('citizen_wear'), value = 'citizen_wear'}
			},
			align='top-left'
		},
		function(data, menu)
			if data.current.value == 'citizen_wear' then
				isInService = false
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					  local model = nil

					  if skin.sex == 0 then
						model = GetHashKey("mp_m_freemode_01")
					  else
						model = GetHashKey("mp_f_freemode_01")
					  end

					  RequestModel(model)
					  while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(1)
					  end

					  SetPlayerModel(PlayerId(), model)
					  SetModelAsNoLongerNeeded(model)

					  TriggerEvent('skinchanger:loadSkin', skin)
					  TriggerEvent('esx:restoreLoadout')
        		end)
      		end
			if data.current.value == 'job_wear' then
				isInService = true
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
	    			if skin.sex == 0 then
	    				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					else
	    				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)

					RequestModel(model)
					while not HasModelLoaded(model) do
					RequestModel(model)
					Citizen.Wait(0)
					end

				SetPlayerModel(PlayerId(), model)
				SetModelAsNoLongerNeeded(model)
					end

				end)

			end
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function MenuVehicleSpawner()
	local elements = {}

	for i=1, #GarbageConfig.Trucks, 1 do
		table.insert(elements, {label = GetLabelText(GetDisplayNameFromVehicleModel(GarbageConfig.Trucks[i])).." "..i, value = GarbageConfig.Trucks[i]})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vehiclespawner',
		{
			title    = _U('vehiclespawner'),
			elements = elements,
			align='top-left'
		},
		function(data, menu)
			ESX.Game.SpawnVehicle(data.current.value, GarbageConfig.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
				platenum = math.random(10000, 99999)
				SetVehicleNumberPlateText(vehicle, "WAL"..platenum)
                MissionLivraisonSelect()
				plaquevehicule = "WAL"..platenum
				if data.current.value == 'phantom3' then
					ESX.Game.SpawnVehicle("trailers2", GarbageConfig.Zones.VehicleSpawnPoint.Pos, 270.0, function(trailer)
					    AttachVehicleToTrailer(vehicle, trailer, 1.1)
					end)
				end
				TaskWarpPedIntoVehicle(ped, vehicle, -1)
			end)

			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function IsATruck()
	local isATruck = false
	local playerPed = ped
	for i=1, #GarbageConfig.Trucks, 1 do
		if IsVehicleModel(GetVehiclePedIsUsing(playerPed), GarbageConfig.Trucks[i]) then
			isATruck = true
			break
		end
	end
	return isATruck
end

function IsJobgarbage()
    if(PlayerData~=nil and PlayerData.job.name=='garbage') then return true end
    return false
end

AddEventHandler('esx_garbage:hasEnteredMarker', function(zone)

	local playerPed = ped

	if zone == 'CloakRoom' then
		CurrentAction = 'cloakroom'
		CurrentActionMsg = "Presiona ~INPUT_CONTEXT~ para acceder al vestuario"
	end

	if zone == 'VehicleSpawner' then
		if isInService then
			CurrentAction='vehiclespawner'
			CurrentActionMsg = "Presiona ~INPUT_CONTEXT~ para acceder al garage"
		end
		--[[if isInService and IsJobgarbage() then
			if MissionRetourCamion or MissionLivraison then
				CurrentAction = 'hint'
                CurrentActionMsg  = _U('already_have_truck')
			else
				MenuVehicleSpawner()
			end
		end]]
	end

	if zone == namezone then
		if isInService and MissionLivraison and MissionNum == namezonenum and MissionRegion == namezoneregion and IsJobgarbage() then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				VerifPlaqueVehiculeActuel()

				if plaquevehicule == plaquevehiculeactuel then
					if Blips['delivery'] ~= nil then
						RemoveBlip(Blips['delivery'])
						Blips['delivery'] = nil
					end

					CurrentAction     = 'delivery'
                    CurrentActionMsg  = _U('delivery')
				else
					CurrentAction = 'hint'
                    CurrentActionMsg  = _U('not_your_truck')
				end
			else
				CurrentAction = 'hint'
                CurrentActionMsg  = _U('not_your_truck2')
			end
		end
	end

	if zone == 'AnnulerMission' then
		if isInService and MissionLivraison and IsJobgarbage() then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				VerifPlaqueVehiculeActuel()

				if plaquevehicule == plaquevehiculeactuel then
                    CurrentAction     = 'retourcamionannulermission'
                    CurrentActionMsg  = _U('cancel_mision')
				else
					CurrentAction = 'hint'
                    CurrentActionMsg  = _U('not_your_truck')
				end
			else
                CurrentAction     = 'retourcamionperduannulermission'
			end
		end
	end

	if zone == 'RetourCamion' then
		if isInService and MissionRetourCamion and IsJobgarbage() then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				VerifPlaqueVehiculeActuel()

				if plaquevehicule == plaquevehiculeactuel then
                    CurrentAction     = 'retourcamion'
				else
                    CurrentAction     = 'retourcamionannulermission'
                    CurrentActionMsg  = _U('not_your_truck')
				end
			else
                CurrentAction     = 'retourcamionperdu'
			end
		end
	end

end)

AddEventHandler('esx_garbage:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
    CurrentAction = nil
	CurrentActionMsg = ''
end)

function nouvelledestination()
	livraisonnombre = livraisonnombre+1
	local count = 0
	local multibagpay = 0
		for i, v in pairs(temppaytable) do
		count = count + 1
	end

	if GarbageConfig.MulitplyBags then
	multibagpay = totalbagpay * (count + 1)
	else
	multibagpay = totalbagpay
	end

	local testprint = (destination.Paye + multibagpay)
	local temppayamount =  (destination.Paye + multibagpay) / (count + 1)
	TriggerServerEvent('esx_garbage:requestpay', platenumb,  temppayamount)
	livraisonTotalPaye = 0
	totalbagpay = 0
	temppayamount = 0
	temppaytable = nil
	multibagpay = 0

	if livraisonnombre >= GarbageConfig.MaxDelivery then
		MissionLivraisonStopRetourDepot()
	else

		livraisonsuite = math.random(0, 100)

		if livraisonsuite <= 10 then
			MissionLivraisonStopRetourDepot()
		elseif livraisonsuite <= 99 then
			MissionLivraisonSelect()
		elseif livraisonsuite <= 100 then
			if MissionRegion == 1 then
				MissionRegion = 2
			elseif MissionRegion == 2 then
				MissionRegion = 1
			end
			MissionLivraisonSelect()
		end
	end
end

function retourcamion_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end

	MissionRetourCamion = false
	livraisonnombre = 0
	MissionRegion = 0

	donnerlapaye()
end

function retourcamion_non()

	if livraisonnombre >= GarbageConfig.MaxDelivery then
		ESX.ShowNotification(_U('need_it'))
	else
		ESX.ShowNotification(_U('ok_work'))
		nouvelledestination()
	end
end

function retourcamionperdu_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end
	MissionRetourCamion = false
	livraisonnombre = 0
	MissionRegion = 0

	donnerlapayesanscamion()
end

function retourcamionperdu_non()
	ESX.ShowNotification(_U('scared_me'))
end

function retourcamionannulermission_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end

	MissionLivraison = false
	livraisonnombre = 0
	MissionRegion = 0

	donnerlapaye()
end

function retourcamionannulermission_non()
	ESX.ShowNotification(_U('resume_delivery'))
end

function retourcamionperduannulermission_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end

	MissionLivraison = false
	livraisonnombre = 0
	MissionRegion = 0

	donnerlapayesanscamion()
end

function retourcamionperduannulermission_non()
	ESX.ShowNotification(_U('resume_delivery'))
end

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function donnerlapaye()
	vehicle = GetVehiclePedIsIn(ped, false)
	vievehicule = GetVehicleEngineHealth(vehicle)
	calculargentretire = round(viemaxvehicule-vievehicule)

	if calculargentretire <= 0 then
		argentretire = 0
	else
		argentretire = calculargentretire
	end

    ESX.Game.DeleteVehicle(vehicle)

	local amount = livraisonTotalPaye-argentretire

	if vievehicule >= 1 then
		if livraisonTotalPaye == 0 then
			livraisonTotalPaye = 0
		else
			if argentretire <= 0 then

				livraisonTotalPaye = 0
			else

				livraisonTotalPaye = 0
			end
		end
	else
		if livraisonTotalPaye ~= 0 and amount <= 0 then

			livraisonTotalPaye = 0
		else
			if argentretire <= 0 then

				livraisonTotalPaye = 0
			else

				livraisonTotalPaye = 0
			end
		end
	end
end

function donnerlapayesanscamion()
	argentretire = GarbageConfig.TruckPrice

	-- donne paye
	local amount = livraisonTotalPaye-argentretire

	if livraisonTotalPaye == 0 then

		livraisonTotalPaye = 0
	else
		if amount >= 1 then

			livraisonTotalPaye = 0
		else

			livraisonTotalPaye = 0
		end
	end
end

function SelectBinandCrew()
	work_truck = GetVehiclePedIsIn(ped, true)
	bagsoftrash = math.random(2, 7)
	local NewBin, NewBinDistance = ESX.Game.GetClosestObject(GarbageConfig.DumpstersAvaialbe)
	trashcollectionpos = GetEntityCoords(NewBin)
	platenumb = GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, true))
	TriggerServerEvent("esx_garbage:binselect", trashcollectionpos, platenumb, bagsoftrash)
end

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		if not paused then
			if IsJobgarbage() then
				ped = PlayerPedId()
				coords = GetEntityCoords(ped)
				local isInMarker  = false
				local currentZone = nil

				for k,v in pairs(GarbageConfig.Zones) do
					if(#(coords-vector3(v.Pos.x,v.Pos.y,v.Pos.z)) < v.Size.x) then
						isInMarker  = true
						currentZone = k
					end
				end

				for k,v in pairs(GarbageConfig.Cloakroom) do
					if(#(coords- vector3(v.Pos.x,v.Pos.y,v.Pos.z)) < v.Size.x) then
						isInMarker  = true
						currentZone = k
					end
				end

				for k,v in pairs(GarbageConfig.Livraison) do
					if(#(coords-vector3(v.Pos.x,v.Pos.y,v.Pos.z)) < v.Size.x) then
						isInMarker  = true
						currentZone = k
					end
				end

				if isInMarker and not hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = true
					lastZone                = currentZone
					TriggerEvent('esx_garbage:hasEnteredMarker', currentZone)
				end

				if not isInMarker and hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = false
					TriggerEvent('esx_garbage:hasExitedMarker', lastZone)
				end
			else 
				Citizen.Wait(3000)
			end
		end
		Wait(100)
	end
end)

-- Key Controls
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(5)
		if IsJobgarbage() then
			if CurrentAction ~= nil or CollectionAction ~= nil then
				plyCoords = GetEntityCoords(ped,false)
				SetTextComponentFormat('STRING')
				AddTextComponentString(CurrentActionMsg)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, 38) then
					if CollectionAction then
						if CollectionAction == 'collection' then
							if not HasAnimDictLoaded("anim@heists@narcotics@trash") then
							RequestAnimDict("anim@heists@narcotics@trash")
							end
							while not HasAnimDictLoaded("anim@heists@narcotics@trash") do
							Citizen.Wait(0)
							end
							dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trashcollectionpos.x, trashcollectionpos.y, trashcollectionpos.z)
							if dist <= 3.5 then
								if currentbag > 0 then
									TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
									TriggerServerEvent('esx_garbage:bagremoval', platenumb)
									bagsCount = bagsCount+1
									trashcollection = false
									Citizen.Wait(4000)
									ClearPedTasks(ped)
									local randombag = math.random(0,2)
									if randombag == 0 then
										garbagebag = CreateObject(GetHashKey("prop_cs_street_binbag_01"), 0, 0, 0, true, true, true) -- creates object
										AttachEntityToEntity(garbagebag, ped, GetPedBoneIndex(ped, 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
									elseif randombag == 1 then
										garbagebag = CreateObject(GetHashKey("bkr_prop_fakeid_binbag_01"), 0, 0, 0, true, true, true) -- creates object
										AttachEntityToEntity(garbagebag, ped, GetPedBoneIndex(ped, 57005), .65, 0, -.1, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
									elseif randombag == 2 then
										garbagebag = CreateObject(GetHashKey("hei_prop_heist_binbag"), 0, 0, 0, true, true, true) -- creates object
										AttachEntityToEntity(garbagebag, ped, GetPedBoneIndex(ped, 57005), 0.12, 0.0, 0.00, 25.0, 270.0, 180.0, true, true, false, true, 1, true) -- object is attached to right hand
									end
									TaskPlayAnim(ped, 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1,49,0,0, 0,0)
									truckdeposit = true
									CollectionAction = 'deposit'
								else
									if iscurrentboss then
										TaskStartScenarioInPlace(ped, "WORLD_HUMAN_BUM_WASH", 0, true)
										if temppaytable == nil then
											temppaytable = {}
										end
										TriggerServerEvent('esx_garbage:reportbags', platenumb)
										Citizen.Wait(4000)
										ClearPedTasks(ped)
										setring = false
										bagsoftrash = math.random(2,10)
										currentbag = bagsoftrash
										CurrentAction = nil
										trashcollection = false
										truckdeposit = false
										ESX.ShowNotification("Trabajo finalizado, regresa al camion para recibir la paga!")
										while not IsPedInVehicle(GetPlayerPed(-1), work_truck, false) do
											Citizen.Wait(0)
										end
										TriggerServerEvent('esx_garbage:endcollection', platenumb)
										SetVehicleDoorShut(work_truck,5,false)
										Citizen.Wait(2000)
										nouvelledestination()
									end
								end
							end
						elseif CollectionAction == 'deposit'  then
							local trunk = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "platelight"))
							dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trunk.x, trunk.y, trunk.z)
							if dist <= 2.0 then
								Citizen.Wait(5)
								ClearPedTasksImmediately(ped)
								TaskPlayAnim(ped, 'anim@heists@narcotics@trash', 'throw_b', 1.0, -1.0,-1,2,0,0, 0,0)
								Citizen.Wait(800)
								local garbagebagdelete = DeleteEntity(garbagebag)
								totalbagpay = totalbagpay+GarbageConfig.BagPay
								Citizen.Wait(100)
								ClearPedTasksImmediately(ped)
								CollectionAction = 'collection'
								truckdeposit = false
								trashcollection = true
							end
						end
					end
					
					if CurrentAction then
						if CurrentAction == 'cloakroom' then
							MenuCloakRoom()
						elseif CurrentAction == 'vehiclespawner' then
							MenuVehicleSpawner()
						elseif CurrentAction == 'vehicledelete' then

						elseif CurrentAction == 'delivery' then
							SelectBinandCrew()
							while work_truck == nil do
								Citizen.Wait(0)
							end
							iscurrentboss = true
							SetVehicleDoorOpen(work_truck,5,false, false)
						elseif CurrentAction == 'retourcamion' then
							retourcamion_oui()
						elseif CurrentAction == 'retourcamionperdu' then
							retourcamionperdu_oui()
						elseif CurrentAction == 'retourcamionannulermission' then
							retourcamionannulermission_oui()
						elseif CurrentAction == 'retourcamionperduannulermission' then
							retourcamionperduannulermission_oui()
						end
					end

					CurrentAction = nil
				end

			else 
				Citizen.Wait(500)
			end
		else 
			Citizen.Wait(3000)
		end
    end
end)

DrawText3D = function(coords, text, size)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)

    if onScreen then
        local camCoords = GetGameplayCamCoords()
        local dist = #(camCoords- vector3(coords.x, coords.y, coords.z))

        local scale = (size / dist) * 2
        local fov = (1 / GetGameplayCamFov()) * 100
        local scale = scale * fov

        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(1)

        AddTextComponentString(text)
        DrawText(x, y)
    end
end

-- DISPLAY MISSION MARKERS AND MARKERS
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if(IsJobgarbage) then
			sleep = true
			plyCoords=GetEntityCoords(ped,false)
			if truckdeposit then
				local trunk = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "platelight"))
				dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trunk.x , trunk.y, trunk.z)
				DrawMarker(27, trunk.x , trunk.y, trunk.z, 0, 0, 0, 0, 0, 0, 1.25, 1.25, 1.0001, 0, 128, 0, 200, 0, 0, 0, 0)
				if dist <= 2.0 then
				DrawText3D(vector3(trunk.x , trunk.y ,trunk.z + 0.50), "[~g~E~s~] Tirar la bolsa en el camion.", 1.0)
				end
				sleep=false
			elseif trashcollection then
				dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trashcollectionpos.x, trashcollectionpos.y, trashcollectionpos.z)
				if dist<=50 then
					DrawMarker(27, trashcollectionpos.x, trashcollectionpos.y, trashcollectionpos.z+0.4, 0, 0, 0, 0, 0, 0, 3.001, 3.0001, 1.0001, 255, 0, 0, 200, 0, 0, 0, 0)
					if dist <= 5.0 then
						if currentbag <= 0 then
							if iscurrentboss then
							DrawText3D(trashcollectionpos + vector3(0.0, 0.0, 1.0), "[~g~E~s~] Limpiar restos", 1.0)
							else
							DrawText3D(trashcollectionpos + vector3(0.0, 0.0, 1.0), "Basura recogida, espere en el camion..", 1.0)
							end
						else
							DrawText3D(trashcollectionpos + vector3(0.0, 0.0, 1.0), "[~g~E~s~] Recoger bolsa de basura ["..currentbag.."/"..bagsoftrash.."]", 1.0)
						end
					end
					sleep=false
				end
			end
			if MissionLivraison then
				DrawMarker(destination.Type, destination.Pos.x, destination.Pos.y, destination.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, destination.Size.x, destination.Size.y, destination.Size.z, destination.Color.r, destination.Color.g, destination.Color.b, 100, false, true, 2, false, false, false, false)
				DrawMarker(GarbageConfig.Livraison.AnnulerMission.Type, GarbageConfig.Livraison.AnnulerMission.Pos.x, GarbageConfig.Livraison.AnnulerMission.Pos.y, GarbageConfig.Livraison.AnnulerMission.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, GarbageConfig.Livraison.AnnulerMission.Size.x, GarbageConfig.Livraison.AnnulerMission.Size.y, GarbageConfig.Livraison.AnnulerMission.Size.z, GarbageConfig.Livraison.AnnulerMission.Color.r, GarbageConfig.Livraison.AnnulerMission.Color.g, GarbageConfig.Livraison.AnnulerMission.Color.b, 100, false, true, 2, false, false, false, false)
				sleep=false
			elseif MissionRetourCamion then
				DrawMarker(destination.Type, destination.Pos.x, destination.Pos.y, destination.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, destination.Size.x, destination.Size.y, destination.Size.z, destination.Color.r, destination.Color.g, destination.Color.b, 100, false, true, 2, false, false, false, false)
				sleep=false
			end

			for k,v in pairs(GarbageConfig.Zones) do
				if isInService and (IsJobgarbage() and v.Type ~= -1 and #(coords- vector3(v.Pos.x,v.Pos.y,v.Pos.z)) < GarbageConfig.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
					sleep=false
				end
			end

			for k,v in pairs(GarbageConfig.Cloakroom) do
				if(IsJobgarbage() and v.Type ~= -1 and #(coords- vector3(v.Pos.x,v.Pos.y,v.Pos.z)) < GarbageConfig.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
					sleep=false
					break
				end
			end

			if sleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(3500)
		end
	end
end)

-- CREATE BLIPS
function refreshBlip()
	Citizen.CreateThread(function()
        if blip then
            RemoveBlip(blip)
        end
        if Blips['delivery'] ~= nil then
            RemoveBlip(Blips['delivery'])
            Blips['delivery'] = nil
        end
		if(PlayerData.job ~= nil and PlayerData.job.name=="garbage") then
			blip = AddBlipForCoord(GarbageConfig.Cloakroom.CloakRoom.Pos.x, GarbageConfig.Cloakroom.CloakRoom.Pos.y, GarbageConfig.Cloakroom.CloakRoom.Pos.z)
			SetBlipSprite (blip, 318)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.2)
			SetBlipColour (blip, 5)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_job'))
			EndTextCommandSetBlipName(blip)
		end
	end)
end

-------------------------------------------------
-- Fonctions
-------------------------------------------------
-- Fonction selection nouvelle mission livraison
function MissionLivraisonSelect()
	if MissionRegion == 0 then
		MissionRegion = math.random(1,2)
	end

	if MissionRegion == 1 then -- Los santos
		MissionNum = math.random(1, 10)
		while lastpickup == MissionNum do
			Citizen.Wait(50)
			MissionNum = math.random(1, 10)
		end
		if MissionNum == 1 then destination = GarbageConfig.Livraison.Delivery1LS namezone = "Delivery1LS" namezonenum = 1 namezoneregion = 1
		elseif MissionNum == 2 then destination = GarbageConfig.Livraison.Delivery2LS namezone = "Delivery2LS" namezonenum = 2 namezoneregion = 1
		elseif MissionNum == 3 then destination = GarbageConfig.Livraison.Delivery3LS namezone = "Delivery3LS" namezonenum = 3 namezoneregion = 1
		elseif MissionNum == 4 then destination = GarbageConfig.Livraison.Delivery4LS namezone = "Delivery4LS" namezonenum = 4 namezoneregion = 1
		elseif MissionNum == 5 then destination = GarbageConfig.Livraison.Delivery5LS namezone = "Delivery5LS" namezonenum = 5 namezoneregion = 1
		elseif MissionNum == 6 then destination = GarbageConfig.Livraison.Delivery6LS namezone = "Delivery6LS" namezonenum = 6 namezoneregion = 1
		elseif MissionNum == 7 then destination = GarbageConfig.Livraison.Delivery7LS namezone = "Delivery7LS" namezonenum = 7 namezoneregion = 1
		elseif MissionNum == 8 then destination = GarbageConfig.Livraison.Delivery8LS namezone = "Delivery8LS" namezonenum = 8 namezoneregion = 1
		elseif MissionNum == 9 then destination = GarbageConfig.Livraison.Delivery9LS namezone = "Delivery9LS" namezonenum = 9 namezoneregion = 1
		elseif MissionNum == 10 then destination = GarbageConfig.Livraison.Delivery10LS namezone = "Delivery10LS" namezonenum = 10 namezoneregion = 1
		end

	elseif MissionRegion == 2 then -- Blaine County
		MissionNum = math.random(1, 10)
		while lastpickup == MissionNum do
			Citizen.Wait(50)
			MissionNum = math.random(1, 10)
		end
		if MissionNum == 1 then destination = GarbageConfig.Livraison.Delivery1BC namezone = "Delivery1BC" namezonenum = 1 namezoneregion = 2
		elseif MissionNum == 2 then destination = GarbageConfig.Livraison.Delivery2BC namezone = "Delivery2BC" namezonenum = 2 namezoneregion = 2
		elseif MissionNum == 3 then destination = GarbageConfig.Livraison.Delivery3BC namezone = "Delivery3BC" namezonenum = 3 namezoneregion = 2
		elseif MissionNum == 4 then destination = GarbageConfig.Livraison.Delivery4BC namezone = "Delivery4BC" namezonenum = 4 namezoneregion = 2
		elseif MissionNum == 5 then destination = GarbageConfig.Livraison.Delivery5BC namezone = "Delivery5BC" namezonenum = 5 namezoneregion = 2
		elseif MissionNum == 6 then destination = GarbageConfig.Livraison.Delivery6BC namezone = "Delivery6BC" namezonenum = 6 namezoneregion = 2
		elseif MissionNum == 7 then destination = GarbageConfig.Livraison.Delivery7BC namezone = "Delivery7BC" namezonenum = 7 namezoneregion = 2
		elseif MissionNum == 8 then destination = GarbageConfig.Livraison.Delivery8BC namezone = "Delivery8BC" namezonenum = 8 namezoneregion = 2
		elseif MissionNum == 9 then destination = GarbageConfig.Livraison.Delivery9BC namezone = "Delivery9BC" namezonenum = 9 namezoneregion = 2
		elseif MissionNum == 10 then destination = GarbageConfig.Livraison.Delivery10BC namezone = "Delivery10BC" namezonenum = 10 namezoneregion = 2
		end

	end
	lastpickup = MissionNum
	MissionLivraisonLetsGo()
end

-- Fonction active mission livraison
function MissionLivraisonLetsGo()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end

	Blips['delivery'] = AddBlipForCoord(destination.Pos.x,  destination.Pos.y,  destination.Pos.z)
	SetBlipRoute(Blips['delivery'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_delivery'))
	EndTextCommandSetBlipName(Blips['delivery'])

	Blips['annulermission'] = AddBlipForCoord(GarbageConfig.Livraison.AnnulerMission.Pos.x,  GarbageConfig.Livraison.AnnulerMission.Pos.y,  GarbageConfig.Livraison.AnnulerMission.Pos.z)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_goal'))
	EndTextCommandSetBlipName(Blips['annulermission'])

	if MissionRegion == 1 then -- Los santos
		ESX.ShowNotification(_U('meet_ls'))
	elseif MissionRegion == 2 then -- Blaine County
		ESX.ShowNotification(_U('meet_bc'))
	elseif MissionRegion == 0 then -- au cas ou
		ESX.ShowNotification(_U('meet_del'))
	end

	MissionLivraison = true
end

--Fonction retour au depot
function MissionLivraisonStopRetourDepot()
	destination = GarbageConfig.Livraison.RetourCamion

	Blips['delivery'] = AddBlipForCoord(destination.Pos.x,  destination.Pos.y,  destination.Pos.z)
	SetBlipRoute(Blips['delivery'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_depot'))
	EndTextCommandSetBlipName(Blips['delivery'])

	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end

	ESX.ShowNotification(_U('return_depot'))

	MissionRegion = 0
	MissionLivraison = false
	MissionNum = 0
	MissionRetourCamion = true
end

function SavePlaqueVehicule()
	plaquevehicule = GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, false))
end

function VerifPlaqueVehiculeActuel()
	plaquevehiculeactuel = GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, false))
end

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		while debugit do
			Citizen.Wait(0)
			plyCoords = GetEntityCoords(ped, false)
			DrawText3D(plyCoords + vector3(0.0, 0.0, 0.1), "ID do caminhão de trabalho: "..tostring(work_truck), 0.8)
			DrawText3D(plyCoords + vector3(0.0, 0.0, 0.0), "Ação para verificar o pressionamento de botão: "..tostring(CollectionAction), 0.8)
			DrawText3D(plyCoords + vector3(0.0, 0.0, -0.1), "Depósito do caminhão: "..tostring(truckdeposit), 0.8)
			DrawText3D(plyCoords + vector3(0.0, 0.0, -0.2), "Coleção Bin: "..tostring(trashcollection), 0.8)
		end
	end
end)]]
