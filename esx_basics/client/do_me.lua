local pedDisplaying = {}

local function DrawText3D(coords, text, color)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)

    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    -- Format the text
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextScale(0.0, 0.5 * scale)
    SetTextFont(0)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextCentre(true)

    -- Diplay the text
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()

end

local function Display(ped, text, command)

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)

    if dist <= 230 then

        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1

        -- Timer
        local display = true

        Citizen.CreateThread(function()
            Wait(8000)
            display = false
        end)
        local color = {
            r = 11,
            g = 0,
            b = 234,
            a = 200
        }
        if command == "me" then
            color = {
                r = 216,
                g = 5,
                b = 5,
                a = 200
            }
        end

        local offset = 0.95 + pedDisplaying[ped] * 0.1
        while display do
            if HasEntityClearLosToEntity(playerPed, ped, 17) then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                z = z + offset
                DrawText3D(vector3(x, y, z), text, color)
            end
            Wait(5)
        end

        pedDisplaying[ped] = pedDisplaying[ped] - 1

    end
end

RegisterNetEvent('esx_basics:displayText')
AddEventHandler('esx_basics:displayText', function(text, serverId, command)
    local player = GetPlayerFromServerId(serverId)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
        Display(ped, text, command)
    end
end)

TriggerEvent('chat:addSuggestion', '/do', "Expresar acciones", {})
TriggerEvent('chat:addSuggestion', '/me', "Expresar pensamientos", {})