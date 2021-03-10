
seal = false

RegisterNetEvent('esx_factions:seal')
AddEventHandler('esx_factions:seal',function(item)
	local player, distance = ESX.Game.GetClosestPlayer()
		
	if distance == -1 or distance > 1.00 or not IsPedOnFoot(GetPlayerPed(player)) then
		ESX.ShowNotification('No hay jugadores cerca')
		return
	end

	local ped = PlayerPedId()
	ESX.Streaming.RequestAnimDict('amb@prop_human_bum_bin@idle_b', function()
		TriggerServerEvent('esx_factions:setSealed', GetPlayerServerId(player), item,GetEntityCoords(ped),GetEntityHeading(ped),GetEntityForwardVector(ped))
		Citizen.Wait(500)
		TaskPlayAnim(ped, 'amb@prop_human_bum_bin@idle_b', 'idle_d',100.0, 200.0, 0.3, 120, 0.2, false, false, false)
		Citizen.Wait(1250)
		StopAnimTask(ped, 'amb@prop_human_bum_bin@idle_b', 'idle_d', 1.0)		
	end)
end)

RegisterNetEvent('esx_factions:getSealed')
AddEventHandler('esx_factions:getSealed',function(state,coords,heading,location)
	seal=state
	local x, y, z = table.unpack(coords + location * 1.0)
	if seal then
		local ped = PlayerPedId()
		SetEntityCoords(ped,x,y,z-1.0)
		SetEntityHeading(ped,heading)
		Citizen.Wait(1200)
		TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
	else
		local ped = PlayerPedId()
		SetEntityCoords(ped,x,y,z-1.0)
		SetEntityHeading(ped,heading)
		Citizen.Wait(1200)
		ClearPedSecondaryTask(ped)
	end
end)

RegisterNetEvent('esx_factions:useClip')
AddEventHandler('esx_factions:useClip', function()
    local ped = PlayerPedId()
    if IsPedArmed(ped, 4) then
        hash = GetSelectedPedWeapon(ped)
        if hash ~= nil then
            TriggerServerEvent('esx_factions:removeClip')
            AddAmmoToPed(ped, hash, 30)
            ESX.ShowNotification("Has utilizado un cargador")
        else
            ESX.ShowNotification("No tienes un arma en la mano!")
        end
    else
        ESX.ShowNotification("No tienes un arma en mano!")
    end
end)

RegisterNetEvent('esx_factions:armour')
AddEventHandler('esx_factions:armour', function()
    local ped = PlayerPedId()
	ESX.Streaming.RequestAnimDict('anim@heists@ornate_bank@grab_cash', function()
		TaskPlayAnim(ped, 'anim@heists@ornate_bank@grab_cash', 'intro', 3.0, 3.0, 1600, 51, 0, false, false, false)
		Citizen.Wait(750)
		SetPedArmour(ped, 100)
	end)
end)

local inEffect = false

RegisterNetEvent('esx_factions:drug')
AddEventHandler('esx_factions:drug', function(drug)
    local ped = PlayerPedId()
    if drug == "meth" then
        RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
        while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
            Citizen.Wait(0)
        end
        TaskStartScenarioInPlace(ped, "mp_player_intdrink", 0, true)
    else 
        RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
        while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
            Citizen.Wait(0)
        end
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING_POT", 0, true)
    end
	if not inEffect then
		inEffect=true
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
	inEffect=false
	end
end)
