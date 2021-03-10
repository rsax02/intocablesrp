local zones = {
	{x = -34.67, y = -1094.42, z = 25.42, size = 30.00}, -- LOW END
	{x=-327.8,y=-928.2,z=30.08,size=50.00}, -- GARAGE
	{x = -530.65, y = -228.96, z = 36.7, size = 36.00}, -- WORK jobs
    {x=-1719.69,y=-261.04,z=52.3,size=120.00},
	{x=245.61, y= -1373.46, z=32.74, size=20} -- WORK
}

local notifIn = false
local notifOut = false
local closestZone = 0
local enabledZone = true

local mp_pointing = false
local keyPressed = false
ped, inVehicle, dead, coords = nil, false, false
local crouched = false
local tags = {}

Citizen.CreateThread(function()
    while true do
        ped = PlayerPedId()
        inVehicle=IsPedInAnyVehicle(ped,false)
        dead=IsEntityDead(ped)
        coords=GetEntityCoords(ped)
        local x, y, z = table.unpack(coords)
		local minDistance = 100000
        for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i

			end
		end
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.55) 
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNIFE"), 0.55) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.25)
    N_0x4757f00bc6323cfe(-1553120962, 0.0)
	
	Wait(1)
    end
end)

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(ped)
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    ped = PlayerPedId()
    while true do
        Wait(5)
        if once then
            once = false
        end
        if not inVehicle then
            if not keyPressed then
                if IsControlPressed(0, 48) and not mp_pointing and IsPedOnFoot(ped) then
                    Wait(200)
                    if not IsControlPressed(0, 48) then
                        keyPressed = true
                        startPointing()
                        mp_pointing = true
                    else
                        keyPressed = true
                        while IsControlPressed(0, 48) do
                            Wait(50)
                        end
                    end
                elseif (IsControlPressed(0, 48) and mp_pointing) or (not IsPedOnFoot(ped) and mp_pointing) then
                    keyPressed = true
                    mp_pointing = false
                    stopPointing()
                end
            end

            if keyPressed then
                if not IsControlPressed(0, 48) then
                    keyPressed = false
                end
            end
            if Citizen.InvokeNative(0x921CE12C489C4C41, ped) and not mp_pointing then
                stopPointing()
            end
            if Citizen.InvokeNative(0x921CE12C489C4C41, ped) then
                if not IsPedOnFoot(ped) then
                    stopPointing()
                else
                    local ped = GetPlayerPed(-1)
                    local camPitch = GetGameplayCamRelativePitch()
                    if camPitch < -70.0 then
                        camPitch = -70.0
                    elseif camPitch > 42.0 then
                        camPitch = 42.0
                    end
                    camPitch = (camPitch + 70.0) / 112.0

                    local camHeading = GetGameplayCamRelativeHeading()
                    local cosCamHeading = Cos(camHeading)
                    local sinCamHeading = Sin(camHeading)
                    if camHeading < -180.0 then
                        camHeading = -180.0
                    elseif camHeading > 180.0 then
                        camHeading = 180.0
                    end
                    camHeading = (camHeading + 180.0) / 360.0

                    local blocked = 0
                    local nn = 0

                    local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                    local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                    nn,blocked,coords,coords = GetRaycastResult(ray)

                    Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                    Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

                end
            end
        else 
            Citizen.Wait(1000)
        end
    end
end)


function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(6)
        if IsControlPressed(0, 19) and IsControlJustPressed(0, 249) then
            if IsPedOnFoot(ped) then
                if DoesEntityExist(ped) and not IsEntityDead(ped) then
                    loadAnimDict("random@arrests")
                    if IsEntityPlayingAnim(ped, "random@arrests", "generic_radio_chatter", 3) then
                        ClearPedSecondaryTask(ped)
                    else
                        TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 2.0, 2.5, -1, 49, 0, 0, 0, 0)
                        RemoveAnimDict("random@arrests")
                    end
					Citizen.Wait(400)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    local ped = PlayerPedId()
    local player = PlayerId()
	while true do
        Citizen.Wait(5)
        if(not inVehicle and not dead) then
            DisablePlayerVehicleRewards(player)
            DisableControlAction(0, 36, true)
            DisableControlAction(0, 140, true)
            if IsAimCamActive() or IsFirstPersonAimCamActive() or IsControlPressed(0, 22) then
                DisableControlAction(0, 22, true)
            end
            if IsPedInCover(ped, 1) and not IsPedAimingFromCover(ped, 1) then 
                DisableControlAction(2, 24, true) 
                DisableControlAction(2, 142, true)
                DisableControlAction(2, 257, true)
            end
            if IsPedArmed(ped, 6) then
                DisableControlAction(1, 140, true)
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)
            end
        else
            Citizen.Wait(1000)
        end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if (not dead) then
            DisableControlAction(0, 36, true) -- INPUT_DUCK  

            if (not IsPauseMenuActive()) then
                if (IsDisabledControlJustPressed(0, 36)) then
                    RequestAnimSet("move_ped_crouched")

                    while (not HasAnimSetLoaded("move_ped_crouched")) do
                        Citizen.Wait(100)
                    end

                    if (crouched == true) then
                        ResetPedMovementClipset(ped, 0)
                        crouched = false
                    elseif (crouched == false) then
                        SetPedMovementClipset(ped, "move_ped_crouched", 0.25)
                        crouched = true
                    end
                end
            end
        else
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(6)
        if next(tags) then
            local sleep = true
            for k,v in pairs(tags) do
                local vId = GetPlayerFromServerId(v.source)
                local vPed = GetPlayerPed(vId)
                local vCoords = GetEntityCoords(vPed)
                if NetworkIsPlayerActive(vId)then
                    if #(coords - vCoords) < 18.0 then
                        draw3DText({x=vCoords.x,y=vCoords.y,z=vCoords.z+1.15},v.color.."STAFF")
                        sleep=false
                    end
                end
            end
            if(sleep)then
                Citizen.Wait(1500)
            end
        else 
            Citizen.Wait(1500)
        end
    end
end)

Citizen.CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(10)
    end
    while true do
        Citizen.Wait(4)
        if enabledZone then
            local dist = #(vector3(zones[closestZone].x,zones[closestZone].y,zones[closestZone].z)-coords)
            --local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)

            if dist <= zones[closestZone].size then
                if not notifIn then
                    NetworkSetFriendlyFireOption(false)
                    TriggerEvent("pNotify:SendNotification", {
                        text = "<b style='color:#1E90FF'>Entraste a una Zona Segura</b>",
                        type = "success",
                        timeout = 3000,
                        layout = "bottomcenter",
                        queue = "global"
                    })
                    notifIn = true
                    notifOut = false
                end
            else
                if not notifOut then
                    NetworkSetFriendlyFireOption(true)
                    TriggerEvent("pNotify:SendNotification", {
                        text = "<b style='color:#1E90FF'>Saliste de una Zona Segura</b>",
                        type = "error",
                        timeout = 3000,
                        layout = "bottomcenter",
                        queue = "global"
                    })
                    notifOut = true
                    notifIn = false
                end
            end

            if notifIn then
                DisablePlayerFiring(ped, true)
            end
        else
            Citizen.Wait(500)
        end
    end
end)


RegisterNetEvent('esx_tag:refreshTags')
AddEventHandler('esx_tag:refreshTags',function(newTags)
    tags=newTags
end)

function draw3DText(pos, text, options)
    local scaleOption = 1.2

    local camCoords = GetGameplayCamCoords()
    local dist = #(vector3(camCoords.x, camCoords.y, camCoords.z) - vector3(pos.x, pos.y, pos.z))
    local scale = (scaleOption / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scaleMultiplier = scale * fov
    SetDrawOrigin(pos.x, pos.y, pos.z, 0);
    SetTextProportional(0)
    SetTextScale(0.0 * scaleMultiplier, 0.55 * scaleMultiplier)
    --SetTextColour(color.r, color.g, color.b, color.a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
