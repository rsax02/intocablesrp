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

ESX                             = nil
local PlayerData                = {}
local GUI                       = {}
GUI.Time                        = 0
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local onDuty                    = false
local BlipCloakRoom             = nil
local BlipVehicle               = nil
local BlipVehicleDeleter		= nil
local Blips                     = {}
local OnJob                     = false
local Done 						= false
local playerPed,coords
local lastWork=GetGameTimer()

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
        Citizen.Wait(15)
	end

	PlayerData = ESX.GetPlayerData()
	onDuty=false
	CreateBlip()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
	onDuty = false
    CreateBlip()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
	onDuty = false
    CreateBlip()
end)

-- NPC MISSIONS

function SelectPool()
    local index = GetRandomIntInRange(1,  #Config.Pool)

    for k,v in pairs(Config.Zones2) do
      if v.Pos.x == Config.Pool[index].x and v.Pos.y == Config.Pool[index].y and v.Pos.z == Config.Pool[index].z then
        return k
      end
    end
end

function StartNPCJob()
    NPCTargetPool     = SelectPool()
    local zone            = Config.Zones2[NPCTargetPool]

    Blips['NPCTargetPool'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
    SetBlipRoute(Blips['NPCTargetPool'], true)
    ESX.ShowNotification(_U('GPS_info'))
    Done = true
end

function StopNPCJob(cancel)

    if Blips['NPCTargetPool'] ~= nil then
      RemoveBlip(Blips['NPCTargetPool'])
      Blips['NPCTargetPool'] = nil
	end

	OnJob = false

	if not cancel then
		TriggerServerEvent('esx_customjobs:delivery',onDuty,NPCTargetPool)
		StartNPCJob()
		Done = true
	end
end

function CloakRoomMenu()
	local elements = {}
	table.insert(elements, {label = "Ropa de trabajo", value = 'job_wear'})
	table.insert(elements, {label = "Ropa de civil", value = 'citizen_wear'})
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'cloakroom',{
            title = 'Vestuario',
			align    = 'top-left',
            elements = elements
        },
        function(data, menu)
			if data.current.value == 'citizen_wear' then
				StopNPCJob(true)
				RemoveBlip(Blips['NPCTargetPool'])
				Onjob = false
				onDuty = false
				CreateBlip()
				menu.close()
                --ESX.ShowNotification(_U('end_service_notif'))
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
					Citizen.Wait(5)
				  end

				  SetPlayerModel(PlayerId(), model)
				  SetModelAsNoLongerNeeded(model)

				  TriggerEvent('skinchanger:loadSkin', skin)
				  TriggerEvent('esx:restoreLoadout')
				  -- SetPedArmour(playerPed, 0)
				  ClearPedBloodDamage(playerPed)
				  ResetPedVisibleDamage(playerPed)
				  ClearPedLastWeaponDamage(playerPed)
				end)
            end
            if data.current.value == 'job_wear' then
				onDuty = true
				CreateBlip()
                menu.close()
				--ESX.ShowNotification(_U('take_service_notif'))
				--ESX.ShowNotification(_U('start_job'))
				local playerPed = GetPlayerPed(-1)
				setUniform(data.current.value, playerPed)
				-- SetPedArmour(playerPed, 0)
				ClearPedBloodDamage(playerPed)
				ResetPedVisibleDamage(playerPed)
				ClearPedLastWeaponDamage(playerPed)
            end
            CurrentAction     = 'cloakroom_menu'
            CurrentActionMsg  = Config.Zones2.Cloakroom.hint
            CurrentActionData = {}
        end,
        function(data, menu)
            menu.close()
			CurrentAction     = 'cloakroom_menu'
			CurrentActionMsg  = Config.Zones2.Cloakroom.hint
            CurrentActionData = {}
        end
    )
end

function VehicleMenu()
	local inVehicle = IsPedInAnyVehicle(playerPed,false)
	if inVehicle then
		local vehicle = GetVehiclePedIsIn(playerPed,false)
		local plate = GetVehicleNumberPlateText(vehicle)
		if (not tonumber(plate)) or (tonumber(plate) and tonumber(plate) ~= GetPlayerServerId(PlayerId())) then
			ESX.ShowNotification("Debes estar a pie para comenzar una entrega")
			return
		end
	end
	if Onjob then
		StopNPCJob(true)
		RemoveBlip(Blips['NPCTargetPool'])
		Onjob = false
	end
	local coords    = Config.Zones2.VehicleSpawnPoint.Pos
	local Heading    = Config.Zones2.VehicleSpawnPoint.Heading
	if not inVehicle then
		ESX.Game.SpawnVehicle(Config.Vehicles.Truck.Hash, coords, Heading, function(vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			SetVehicleNumberPlateText(vehicle, GetPlayerServerId(PlayerId()))
			TriggerServerEvent("esx_jobs:spawnVehicle", NPCTargetPool)
		end)
	end
	Citizen.Wait(150)
	lastWork=GetGameTimer()+60000
	StartNPCJob()
	Onjob = true
end

Citizen.CreateThread(function()
	playerPed=PlayerPedId()
	coords=GetEntityCoords(playerPed)
	while true do
		if PlayerData.job ~= nil and PlayerData.job.name == Config.nameJob then
		playerPed=PlayerPedId()
		coords=GetEntityCoords(playerPed)
		Citizen.Wait(500)
		else
			Citizen.Wait(3000)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(6)
		if PlayerData.job ~= nil and PlayerData.job.name == Config.nameJob then
			if CurrentAction ~= nil then
				SetTextComponentFormat('STRING')
				AddTextComponentString(CurrentActionMsg)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
				if IsControlJustReleased(1, Keys["E"]) then
					if CurrentAction == 'cloakroom_menu' then
						if IsPedInAnyVehicle(playerPed, 0) then
							ESX.ShowNotification(_U('in_vehicle'))
						else
							CloakRoomMenu()
						end
					elseif CurrentAction == 'vehiclespawn_menu' then
						if GetGameTimer() < lastWork then
							ESX.ShowNotification("Acabas de comenzar una entrega.")
						else
						VehicleMenu()						
						end
					elseif CurrentAction == 'delete_vehicle' then
						local vehicle   = GetVehiclePedIsIn(playerPed,  false)
						local hash      = GetEntityModel(vehicle)
						local plate = GetVehicleNumberPlateText(vehicle)

						if tonumber(plate)==GetPlayerServerId(PlayerId()) then
							local truck = Config.Vehicles.Truck

							if hash == GetHashKey(truck.Hash) then
								DeleteVehicle(vehicle)
								TriggerServerEvent("esx_jobs:returnVehicle",NPCTargetPool)
								if Onjob then
									StopNPCJob(true)
									RemoveBlip(Blips['NPCTargetPool'])
									Onjob = false
								end
							end
						else
							ESX.ShowNotification(_U('bad_vehicle'))
						end
					end
					CurrentAction = nil
				end
			elseif NPCTargetPool ~= nil then
				local zone   = Config.Zones2[NPCTargetPool]
				local dis = #(coords- vector3(zone.Pos.x, zone.Pos.y, zone.Pos.z))
				if dis < 3.0 then
					HelpPromt(_U('pickup'))
					if IsControlJustReleased(1, Keys["E"]) and PlayerData.job ~= nil then
						--[[TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CLIPBOARD", 0, true)
						Wait(10000)
						TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_POLICE_INVESTIGATE", 0, true)
						Wait(12000)]]
						if not IsPedInAnyVehicle(playerPed,  false)then
						TriggerEvent("dpemotes:robbering", true)
						TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
						Wait(17000)
						ClearPedTasksImmediately(playerPed)
						Wait(2200)
						StopNPCJob()
						TriggerEvent("dpemotes:robbering", false)
						Done = false
						else
							ESX.ShowNotification(_U('in_vehicle'))
						end
					end
				elseif dis>10.0 then
					Citizen.Wait(500)
				end
			else
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(5000)
		end
    end
end)

-- Prise de service


-- start job


-- Quand le joueur entre dans la zone
AddEventHandler('esx_cityworks:hasEnteredMarker', function(zone)
    if zone == 'Cloakroom' then
        CurrentAction        = 'cloakroom_menu'
        CurrentActionMsg     = Config.Zones2.Cloakroom.hint
        CurrentActionData    = {}
	elseif zone == 'VehicleSpawner' then
        CurrentAction        = 'vehiclespawn_menu'
        CurrentActionMsg     = Config.Zones2.VehicleSpawner.hint
        CurrentActionData    = {}
    elseif zone == 'VehicleDeleter' then
        local playerPed = GetPlayerPed(-1)
        if IsPedInAnyVehicle(playerPed,  false) then
          CurrentAction        = 'delete_vehicle'
          CurrentActionMsg     = Config.Zones2.VehicleDeleter.hint
          CurrentActionData    = {}
        end
    end
end)

-- Quand le joueur sort de la zone
AddEventHandler('esx_cityworks:hasExitedMarker', function(zone)

    CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

function CreateBlip()
    if PlayerData.job ~= nil and PlayerData.job.name == Config.nameJob then

		if BlipCloakRoom == nil then
			BlipCloakRoom = AddBlipForCoord(Config.Zones2.Cloakroom.Pos.x, Config.Zones2.Cloakroom.Pos.y, Config.Zones2.Cloakroom.Pos.z)
			SetBlipSprite(BlipCloakRoom, Config.Zones2.Cloakroom.BlipSprite)
			SetBlipColour(BlipCloakRoom, Config.Zones2.Cloakroom.BlipColor)
			SetBlipScale(BlipCloakRoom, 1.5)
			SetBlipAsShortRange(BlipCloakRoom, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Zones2.Cloakroom.BlipName)
			EndTextCommandSetBlipName(BlipCloakRoom)
		end
	else

        if BlipCloakRoom ~= nil then
            RemoveBlip(BlipCloakRoom)
            BlipCloakRoom = nil
        end
	end

	if PlayerData.job ~= nil and PlayerData.job.name == Config.nameJob and onDuty then

        BlipVehicle = AddBlipForCoord(Config.Zones2.VehicleSpawner.Pos.x, Config.Zones2.VehicleSpawner.Pos.y, Config.Zones2.VehicleSpawner.Pos.z)
        SetBlipSprite(BlipVehicle, Config.Zones2.VehicleSpawner.BlipSprite)
        SetBlipColour(BlipVehicle, Config.Zones2.VehicleSpawner.BlipColor)
        SetBlipAsShortRange(BlipVehicle, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Zones2.VehicleSpawner.BlipName)
        EndTextCommandSetBlipName(BlipVehicle)

        --[[ BlipVente = AddBlipForCoord(Config.Zones2.Vente.Pos.x, Config.Zones2.Vente.Pos.y, Config.Zones2.Vente.Pos.z)
        SetBlipSprite(BlipVente, Config.Zones2.Vente.BlipSprite)
        SetBlipColour(BlipVente, Config.Zones2.Vente.BlipColor)
        SetBlipAsShortRange(BlipVente, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Zones2.Vente.BlipName)
        EndTextCommandSetBlipName(BlipVente) ]]

        BlipVehicleDeleter = AddBlipForCoord(Config.Zones2.VehicleDeleter.Pos.x, Config.Zones2.VehicleDeleter.Pos.y, Config.Zones2.VehicleDeleter.Pos.z)
        SetBlipSprite(BlipVehicleDeleter, Config.Zones2.VehicleDeleter.BlipSprite)
        SetBlipColour(BlipVehicleDeleter, Config.Zones2.VehicleDeleter.BlipColor)
        SetBlipAsShortRange(BlipVehicleDeleter, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Zones2.VehicleDeleter.BlipName)
        EndTextCommandSetBlipName(BlipVehicleDeleter)
    else

        if BlipVehicle ~= nil then
            RemoveBlip(BlipVehicle)
            BlipVehicle = nil
        end

        --[[ if BlipVente ~= nil then
            RemoveBlip(BlipVente)
            BlipVente = nil
        end ]]

        if BlipVehicleDeleter ~= nil then
            RemoveBlip(BlipVehicleDeleter)
            BlipVehicleDeleter = nil
        end
    end
end

-- Activation du marker au sol
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if PlayerData.job ~= nil and PlayerData.job.name == Config.nameJob then
			if onDuty then
				for k,v in pairs(Config.Zones2) do
					if v ~= Config.Zones2.Cloakroom then
						if(v.Type ~= -1 and #(coords- vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < Config.DrawDistance) then
							DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
						end
					end
				end
			end
			local Cloakroom = Config.Zones2.Cloakroom
			if(Cloakroom.Type ~= -1 and #(coords - vector3(Cloakroom.Pos.x, Cloakroom.Pos.y, Cloakroom.Pos.z)) < Config.DrawDistance) then
				DrawMarker(Cloakroom.Type, Cloakroom.Pos.x, Cloakroom.Pos.y, Cloakroom.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Cloakroom.Size.x, Cloakroom.Size.y, Cloakroom.Size.z, Cloakroom.Color.r, Cloakroom.Color.g, Cloakroom.Color.b, 100, false, true, 2, false, false, false, false)
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

-- Detection de l'entrer/sortie de la zone du joueur
Citizen.CreateThread(function()
	while true do
		Wait(300)
		if PlayerData.job ~= nil and PlayerData.job.name == Config.nameJob then
			local isInMarker  = false
			local currentZone = nil

			if onDuty then
				for k,v in pairs(Config.Zones2) do
					if v ~= Config.Zones2.Cloakroom then
						if(#(coords-vector3(v.Pos.x, v.Pos.y, v.Pos.z)) <= v.Size.x) then
							isInMarker  = true
							currentZone = k
							break
						end
					end
				end
			end

			local Cloakroom = Config.Zones2.Cloakroom
			if(#(coords -vector3(Cloakroom.Pos.x, Cloakroom.Pos.y, Cloakroom.Pos.z)) <= Cloakroom.Size.x) then
				isInMarker  = true
				currentZone = "Cloakroom"
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_cityworks:hasEnteredMarker', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_cityworks:hasExitedMarker', LastZone)
			end
		else 
			Citizen.Wait(5000)
		end
	end
end)

function setUniform(job, playerPed)
  TriggerEvent('skinchanger:getSkin', function(skin)

    if skin.sex == 0 then
      if Config.Uniforms[job].male ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
    else
      if Config.Uniforms[job].female ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
    end

  end)
end

function HelpPromt(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, state, 0, -1)
end
