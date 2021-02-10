Strings = {
    ['Choose_Favorite'] = 'What button do you want to use for %s?',
    ['Select_Favorite'] = 'Add a quick bind animation',
    ['Manage_Favorites'] = 'Manage quick bind animations',
    ['Close'] = 'Cancel',
    ['Updated_Favorites'] = 'Updated quick bind animations.',
    ['Remove?'] = 'Remove "%s" as a quick bind animation?',
    ['Yes'] = 'Yes',
    ['No'] = 'No',
    ['Animations'] = 'Animaciones',
    ['Synced'] = 'Animaciones sincronizadas',
    ['Sync_Request'] = 'Quieres %s %s?',
    ['Pole_Dance'] = '[~r~E~w~] Bailar en el caño',
    ['Noone_Close'] = 'No hay jugadores cerca.',
    ['Not_In_Car'] = 'No estas en un vehiculo!'
}

Citizen.CreateThread(function()
    while true do
        Wait(5)
        local ped = PlayerPedId()
        if not IsPedDeadOrDying(ped) then
            if IsControlJustReleased(0, 105) then
                ClearPedTasks(ped)
            end

            if ESX.PlayerData.job and ESX.PlayerData.job.name == "nightclub" then
                for k, v in pairs(Config['PoleDance']['Locations']) do
                    if #(GetEntityCoords(ped) - v['Position']) <= 1.0 then
                        DrawText3D(v['Position'], Strings['Pole_Dance'], 0.35)
                        if IsControlJustReleased(0, 51) then
                            LoadDict('mini@strip_club@pole_dance@pole_dance' .. v['Number'])
                            local scene = NetworkCreateSynchronisedScene(v['Position'], vector3(0.0, 0.0, 0.0), 2, false, false, 1065353216, 0, 1.3)
                            NetworkAddPedToSynchronisedScene(ped, scene, 'mini@strip_club@pole_dance@pole_dance' .. v['Number'], 'pd_dance_0' .. v['Number'], 1.5, -4.0, 1, 1, 1148846080, 0)
                            NetworkStartSynchronisedScene(scene)
                        end
                    end
                end
            end
        else 
            Citizen.Wait(500)
        end
    end
end)

RegisterNetEvent('loffe_animations:syncRequest')
AddEventHandler('loffe_animations:syncRequest', function(requester, id, name)
    local accepted = false
    local timer = GetGameTimer() + 5000
    while timer >= GetGameTimer() do 
        Wait(0)

        --HelpText((Strings['Sync_Request']):format(Config['Synced'][id]['RequesterLabel'], name) .. ('\n~INPUT_FRONTEND_ACCEPT~ %s \n~INPUT_FRONTEND_RRIGHT~ %s'):format(Strings['Yes'], Strings['No']))
        ESX.ShowNotification("El jugador ~y~".. requester.." ~w~quiere ~y~"..Config['Synced'][id]['RequesterLabel'].."~w~, pulsa ~y~Block Mayus ~w~para aceptar ")

        if IsControlJustReleased(0, 194) then
            break
        elseif IsControlJustReleased(0, 137) then
            accepted = true
            break
        end

    end

    if accepted then
        TriggerServerEvent('loffe_animations:syncAccepted', requester, id)
    end
end)

RegisterNetEvent('loffe_animations:playSynced')
AddEventHandler('loffe_animations:playSynced', function(serverid, id, type)
    local anim = Config['Synced'][id][type]

    local target = GetPlayerPed(GetPlayerFromServerId(serverid))
    local ped = PlayerPedId()
    if anim['Attach'] then
        local attach = anim['Attach']
        AttachEntityToEntity(ped, target, attach['Bone'], attach['xP'], attach['yP'], attach['zP'], attach['xR'], attach['yR'], attach['zR'], 0, 0, 0, 0, 2, 1)
    end

    Wait(750)

    if anim['Type'] == 'animation' then
        PlayAnim(anim['Dict'], anim['Anim'], anim['Flags'])
    end

    if type == 'Requester' then
        anim = Config['Synced'][id]['Accepter']
    else
        anim = Config['Synced'][id]['Requester']
    end
    while not IsEntityPlayingAnim(target, anim['Dict'], anim['Anim'], 3) do
        Wait(0)
        SetEntityNoCollisionEntity(ped, target, true)
    end
    DetachEntity(ped)
    while IsEntityPlayingAnim(target, anim['Dict'], anim['Anim'], 3) do
        Wait(0)
        SetEntityNoCollisionEntity(ped, target, true)
    end

    ClearPedTasks(ped)
end)

SetWalkingStyle = function(Style)
    LoadDict(Style)
    SetPedMovementClipset(PlayerPedId(), Style, true)
end

PlayAnim = function(Dict, Anim, Flag)
    LoadDict(Dict)
    TaskPlayAnim(PlayerPedId(), Dict, Anim, 8.0, -8.0, -1, Flag or 0, 0, false, false, false)
end

LoadDict = function(Dict)
    while not HasAnimDictLoaded(Dict) do 
        Wait(0)
        RequestAnimDict(Dict)
    end
end

HelpText = function(msg)
    AddTextEntry(GetCurrentResourceName(), msg)
    DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
end

DrawText3D = function(coords, text, scale)
	local onScreen,_x,_y=World3dToScreen2d(coords.x, coords.y, coords.z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 41, 41, 125)
end

Citizen.CreateThread(function()
    RequestModel(GetHashKey("s_m_y_doorman_01"))
	
    while not HasModelLoaded(GetHashKey("s_m_y_doorman_01")) do
        Wait(1)
    end

    for _, item in pairs(Config.SecurityPeds) do
        local npc = CreatePed(4, GetHashKey("s_m_y_doorman_01"), item.x, item.y, item.z,0.0, false, false)
        
        FreezeEntityPosition(npc, true)	
        SetEntityHeading(npc, item.heading)
        SetEntityInvincible(npc, true) --NPC can die (set "true" to change)
        SetBlockingOfNonTemporaryEvents(npc, true)
        RequestAnimDict("anim@amb@nightclub@peds@")
        while not HasAnimDictLoaded("anim@amb@nightclub@peds@") do
        Citizen.Wait(1000)
        end
            
        Citizen.Wait(200)	
        TaskPlayAnim(npc,"anim@amb@nightclub@peds@","amb_world_human_stand_guard_male_base",1.0, 1.0, -1, 1, 1.0, 0, 0, 0)
    end
end)

