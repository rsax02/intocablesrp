RegisterNetEvent("esx_inventoryhud:openPropertyInventory")
AddEventHandler(
    "esx_inventoryhud:openPropertyInventory",
    function(data)
        setPropertyInventoryData(data,true)
        openPropertyInventory()
    end
)
local pas = false

function refreshPropertyInventory(renew)
    ESX.TriggerServerCallback(
        "esx_property:getPropertyInventory",
        function(inventory)
            setPropertyInventoryData(inventory,renew)
        end,
        ESX.GetPlayerData().identifier
    )
end

function setPropertyInventoryData(data,renew)
    items = {}

    local blackMoney = data.blackMoney
    local propertyItems = data.items
    local propertyWeapons = data.weapons

    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end

    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            item.type = "item_standard"
            item.usable = false
            item.rare = false
            item.limit = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    for i = 1, #propertyWeapons, 1 do
        local weapon = propertyWeapons[i]

        if propertyWeapons[i].name ~= "WEAPON_UNARMED" then
            table.insert(
                items,
                {
                    label = ESX.GetWeaponLabel(weapon.name),
                    count = weapon.ammo,
                    limit = -1,
                    type = "item_weapon",
                    name = weapon.name,
                    usable = false,
                    rare = false,
                    canRemove = false
                }
            )
        end
    end

	if renew then
    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
	end
end

function openPropertyInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "property"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoProperty",
    function(data, cb)
		if pas then
		ESX.ShowNotification("que fue dupero ctm")
			cb("fail")
			return
		end
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("esx_property:putItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count)
        end
		
		pas=true
        Wait(500)
		--closeInventory()
		refreshPropertyInventory(true)
		loadPlayerInventory()
        --loadPlayerInventory()
		cb("ok")
		Wait(500)
		
		--openPropertyInventory()
		pas=false
    end
)

RegisterNUICallback(
    "TakeFromProperty",
    function(data, cb)

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("esx_property:getItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number))
        end

        Wait(350)
        refreshPropertyInventory(true)
        loadPlayerInventory()

        cb("ok")
    end
)
