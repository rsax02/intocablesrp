ESX = nil
local currentVehicle = nil
local chatOpened = false
local opened,opening = false,false
local comaOpened = false
local inVehicle = false

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
    end
)

function getVehicleInDirection(range)
    local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, range, 0.0)

    local rayHandle = CastRayPointToPoint(coordA.x, coordA.y, coordA.z, coordB.x, coordB.y, coordB.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

function openmenuvehicle()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = nil

    if IsPedInAnyVehicle(playerPed, false) then
        vehicle = GetVehiclePedIsIn(playerPed, false)
    else
        vehicle = getVehicleInDirection(3.0)

        if not DoesEntityExist(vehicle) then
            vehicle = GetClosestVehicle(coords, 3.0, 0, 70)
        end
    end

    if DoesEntityExist(vehicle) then
        local lockStatus = GetVehicleDoorLockStatus(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        if plate and plate~="" and plate ~=" " then
            if (lockStatus == 0 or lockStatus == 1) then
                local trunkpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
                local distanceToTrunk = GetDistanceBetweenCoords(coords, trunkpos, 1)

                if distanceToTrunk <= 6.5 or (trunkpos.x + trunkpos.y + trunkpos.z) == 0.0 then
                    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                    local limit = 15000
                        if Config.VehicleLimit[model] then
                            limit=Config.VehicleLimit[model]
                        end
                    opened=true
                    TriggerEvent("inventoryOpened")
                    currentVehicle = vehicle
                    SetVehicleDoorOpen(vehicle, 5, false, false)
                    OpenCoffreInventoryMenu(plate, limit)      
                else
                    exports.pNotify:SendNotification({text = _U("trunk_nonear"), type = "error", layout = "centerLeft", timeout = 1200})
                    opening=false
                    Citizen.Wait(1000)
                end
            else
                exports.pNotify:SendNotification({text = _U("trunk_locked"), type = "error", layout = "centerLeft", timeout = 1200})
                opening=false
                Citizen.Wait(1000)
            end
        else
            opening=false
        end
    else
        opening=false
    end
end

RegisterNetEvent('chatOpened')
AddEventHandler('chatOpened', function()
chatOpened=true
end)

RegisterNetEvent('chatClosed')
AddEventHandler('chatClosed', function()
chatOpened=false
end)

RegisterNetEvent('comaOpened')
AddEventHandler('comaOpened',function()
comaOpened=true
end)

RegisterNetEvent('comaClosed')
AddEventHandler('comaClosed',function()
comaOpened=false
end)

local count = 0


Citizen.CreateThread(
    function()
        while true do
            Wait(5)
            if IsControlJustReleased(0, Config.OpenKey) and currentVehicle == nil and not inVehicle and not chatOpened and IsInputDisabled(0) then
                opening = true
                openmenuvehicle()
            end
            if(opening)then
                DisableControlAction(0, 245)
                DisableControlAction(0, 82)
            end
            if opened then
                DisableControlAction(0, 245)
                DisableControlAction(0, 82)
            end
        end
    end
)

function OpenCoffreInventoryMenu(plate, max)
    ESX.TriggerServerCallback(
        "esx_inventoryhud_trunk:getInventoryV",
        function(inventory)
            if(inventory==nil) then
            opening=false
            opened=false
            currentVehicle=nil
            TriggerEvent("inventoryClosed")
            return
            end
            text = _U("trunk_info", plate, (inventory.weight / 1000), (max / 1000))
            data = {plate = plate, max = max, text = text}
            TriggerEvent("esx_inventoryhud:openTrunkInventory", data, inventory.blackMoney, inventory.items, inventory.weapons)
            opening=false
            TriggerServerEvent('esx_inventoryhud:openInventory',plate)
        end,
        plate
    )
end

RegisterNetEvent("esx_inventoryhud:onClosedInventory")
AddEventHandler(
    "esx_inventoryhud:onClosedInventory",
    function(type)
        if type == "trunk" then
            closeTrunk()
            opened=false
            opening=false
            TriggerEvent("inventoryClosed")
        end
    end
)

function closeTrunk()
    if currentVehicle ~= nil then
        SetVehicleDoorShut(currentVehicle, 5, false)
    end

    currentVehicle = nil
end

Citizen.CreateThread(
    function()
        while true do
            Wait(500)
            local playerPed = PlayerPedId()
            inVehicle = IsPedInAnyVehicle(playerPed)
            if currentVehicle ~= nil and DoesEntityExist(currentVehicle) then
                local coords = GetEntityCoords(playerPed)
                local vehicleCoords = GetEntityCoords(currentVehicle)
                local distance = GetDistanceBetweenCoords(coords, vehicleCoords, 1)

                if distance > 10.0 then
                    TriggerEvent("esx_inventoryhud:closeInventory")
                    closeTrunk()
                end
            end
        end
    end
)
