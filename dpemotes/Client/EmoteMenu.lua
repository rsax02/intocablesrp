-- TriggerServerEvent("dp:CheckVersion")
ESX = nil
TriggerEvent('esx:getSharedObject',function(obj)ESX=obj end)

rightPosition = {
    x = 1450,
    y = 50
}
leftPosition = {
    x = 12,
    y = -84
}
menuPosition = {
    x = 0,
    y = 0
}

if Config.MenuPosition then
    if Config.MenuPosition == "left" then
        menuPosition = leftPosition
    elseif Config.MenuPosition == "right" then
        menuPosition = rightPosition
    end
end

if Config.CustomMenuEnabled then
    local RuntimeTXD = CreateRuntimeTxd('Custom_Menu_Head')
    local Object = CreateDui(Config.MenuImage, 512, 128)
    _G.Object = Object
    local TextureThing = GetDuiHandle(Object)
    local Texture = CreateRuntimeTextureFromDuiHandle(RuntimeTXD, 'Custom_Menu_Head', TextureThing)
    Menuthing = "Custom_Menu_Head"
else
    Menuthing = "shopui_title_sm_hangar"
end

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("", "Gestos", menuPosition["x"], menuPosition["y"], Menuthing, Menuthing) -- el primer "" ahí adentro se pone el título del F3, antes decía dp emote
_menuPool:Add(mainMenu)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

local EmoteTable = {}
local HotTable = {}
local FavEmoteTable = {}
local KeyEmoteTable = {}
local DanceTable = {}
local PropETable = {}
local WalkTable = {}
local FaceTable = {}
local ShareTable = {}
local FavoriteEmote = ""

Citizen.CreateThread(function()
    while true do
        if Config.FavKeybindEnabled then
            if IsControlPressed(0, Config.FavKeybind) then
                if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                    if FavoriteEmote ~= "" then
                        EmoteCommandStart(nil, {FavoriteEmote, 0})
                        Wait(3000)
                    end
                end
            end
        end
        Citizen.Wait(5)
    end
end)

lang = Config.MenuLanguage

function AddDanceMenu(menu)
    local dancemenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]['danceemotes'], "", "", Menuthing, Menuthing)
    for a, b in pairsByKeys(DP.Dances) do
        x, y, z = table.unpack(b)
        danceitem = NativeUI.CreateItem(z, "/e (" .. a .. ")")
        -- sharedanceitem = NativeUI.CreateItem(z, "")
        dancemenu:AddItem(danceitem)
        if Config.SharedEmotesEnabled then
            -- shareddancemenu:AddItem(sharedanceitem)
        end
        table.insert(DanceTable, a)
    end

    dancemenu.OnItemSelect = function(sender, item, index)
        EmoteMenuStart(DanceTable[index], "dances")
    end
end

function AddPropMenu(menu)
    local propmenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]['propemotes'], "", "", Menuthing, Menuthing)

    for a, b in pairsByKeys(DP.PropEmotes) do
        x, y, z = table.unpack(b)
        propitem = NativeUI.CreateItem(z, "/e (" .. a .. ")")
        propmenu:AddItem(propitem)
        table.insert(PropETable, a)
        if not Config.SqlKeybinding then
            propfavitem = NativeUI.CreateItem(z, Config.Languages[lang]['set'] .. z ..
                              Config.Languages[lang]['setboundemote'])
            favmenu:AddItem(propfavitem)
            table.insert(FavEmoteTable, a)
        end
    end
    propmenu.OnItemSelect = function(sender, item, index)
        EmoteMenuStart(PropETable[index], "props")
    end
end

function AddHotEmotes(menu)
    local hotmenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]['hotemotes'], "", "", Menuthing, Menuthing)

    for k, v in pairsByKeys(DP.Hot) do
        propitem = NativeUI.CreateItem(v.Label, "")
        hotmenu:AddItem(propitem)
        table.insert(HotTable, k)
    end

    hotmenu.OnItemSelect = function(sender, item, index)
        HotMenuStart(HotTable[index])
    end

end

function AddEmoteMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]['emotes'], "", "", Menuthing, Menuthing)
    -- table.insert(EmoteTable, Config.Languages[lang]['danceemotes'])
    -- table.insert(EmoteTable, Config.Languages[lang]['danceemotes'])

    if not Config.SqlKeybinding then
        unbind2item = NativeUI.CreateItem(Config.Languages[lang]['rfavorite'], Config.Languages[lang]['rfavorite'])
        unbinditem = NativeUI.CreateItem(Config.Languages[lang]['prop2info'], "")
        favmenu = _menuPool:AddSubMenu(submenu, Config.Languages[lang]['favoriteemotes'],
                      Config.Languages[lang]['favoriteinfo'], "", Menuthing, Menuthing)
        favmenu:AddItem(unbinditem)
        favmenu:AddItem(unbind2item)
        table.insert(FavEmoteTable, Config.Languages[lang]['rfavorite'])
        table.insert(FavEmoteTable, Config.Languages[lang]['rfavorite'])
        table.insert(EmoteTable, Config.Languages[lang]['favoriteemotes'])
    else
        table.insert(EmoteTable, "keybinds")
        keyinfo = NativeUI.CreateItem(Config.Languages[lang]['keybinds'], Config.Languages[lang]['keybindsinfo'] ..
                      " /emotebind [~y~num4-9~w~] [~g~animacion~w~]")
        submenu:AddItem(keyinfo)
    end

    for a, b in pairsByKeys(DP.Emotes) do
        x, y, z = table.unpack(b)
        emoteitem = NativeUI.CreateItem(z, "/e (" .. a .. ")")
        submenu:AddItem(emoteitem)
        table.insert(EmoteTable, a)
        if not Config.SqlKeybinding then
            favemoteitem = NativeUI.CreateItem(z, Config.Languages[lang]['set'] .. z ..
                               Config.Languages[lang]['setboundemote'])
            favmenu:AddItem(favemoteitem)
            table.insert(FavEmoteTable, a)
        end
    end

    if not Config.SqlKeybinding then
        favmenu.OnItemSelect = function(sender, item, index)
            if FavEmoteTable[index] == Config.Languages[lang]['rfavorite'] then
                FavoriteEmote = ""
                ShowNotification(Config.Languages[lang]['rfavorite'], 2000)
                return
            end
            if Config.FavKeybindEnabled then
                FavoriteEmote = FavEmoteTable[index]
                ShowNotification("~o~" .. firstToUpper(FavoriteEmote) .. Config.Languages[lang]['newsetemote'])
            end
        end
    end

    -- dancemenu.OnItemSelect = function(sender, item, index)
    -- EmoteMenuStart(DanceTable[index], "dances")
    -- end

    submenu.OnItemSelect = function(sender, item, index)
        if EmoteTable[index] ~= Config.Languages[lang]['favoriteemotes'] then
            EmoteMenuStart(EmoteTable[index], "emotes")
        end
    end
end

function AddCancelEmote(menu)
    local newitem =
        NativeUI.CreateItem(Config.Languages[lang]['cancelemote'], Config.Languages[lang]['cancelemoteinfo'])
    menu:AddItem(newitem)
    menu.OnItemSelect = function(sender, item, checked_)
        if item == newitem then
            EmoteCancel()
            DestroyAllProps()
        end
    end
end

function AddWalkMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]['walkingstyles'], "", "", Menuthing, Menuthing)

    walkreset = NativeUI.CreateItem(Config.Languages[lang]['normalreset'], Config.Languages[lang]['resetdef'])
    submenu:AddItem(walkreset)
    table.insert(WalkTable, Config.Languages[lang]['resetdef'])

    WalkInjured = NativeUI.CreateItem("Injured", "")
    submenu:AddItem(WalkInjured)
    table.insert(WalkTable, "move_m@injured")

    for a, b in pairsByKeys(DP.Walks) do
        x = table.unpack(b)
        walkitem = NativeUI.CreateItem(a, "")
        submenu:AddItem(walkitem)
        table.insert(WalkTable, x)
    end

    submenu.OnItemSelect = function(sender, item, index)
        if item ~= walkreset then
            WalkMenuStart(WalkTable[index])
        else
            ResetPedMovementClipset(PlayerPedId())
        end
    end
end

function OpenEmoteMenu()
    mainMenu:Visible(not mainMenu:Visible())
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

AddEmoteMenu(mainMenu)
AddDanceMenu(mainMenu)
AddWalkMenu(mainMenu)
AddPropMenu(mainMenu)
AddHotEmotes(mainMenu)
AddCancelEmote(mainMenu)

_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
    end
end)

RegisterNetEvent("dp:Update")
AddEventHandler("dp:Update", function(state)
    UpdateAvailable = state
    -- AddInfoMenu(mainMenu)
    _menuPool:RefreshIndex()
end)

RegisterNetEvent("dp:RecieveMenu") -- For opening the emote menu from another resource.
AddEventHandler("dp:RecieveMenu", function()
    OpenEmoteMenu()
end)
