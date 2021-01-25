ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx_pharmacy:useKit')
AddEventHandler('esx_pharmacy:useKit', function(itemName, hp_regen)
  local ped    = GetPlayerPed(-1)
  local health = GetEntityHealth(ped)
  local max    = GetEntityMaxHealth(ped)

  if health > 0 and health < max then

    TriggerServerEvent('esx_pharmacy:removeItem', itemName)
    ESX.UI.Menu.CloseAll()
    ESX.ShowNotification(_U('use_firstaidkit'))

    health = health + (max / hp_regen)
    if health > max then
      health = max
    end
    SetEntityHealth(ped, health)
  end
end)

RegisterNetEvent('esx_pharmacy:useDefibrillateur')
AddEventHandler('esx_pharmacy:useDefibrillateur', function(itemName)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

  if closestPlayer == -1 or closestDistance > 3.0 then
    ESX.ShowNotification(_U('no_players'))
  else
    local ped    = GetPlayerPed(closestPlayer)
    local health = GetEntityHealth(ped)

    if health == 0 then
      local playerPed = GetPlayerPed(-1)
      Citizen.CreateThread(function()
        ESX.ShowNotification(_U('revive_inprogress'))
        --TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
        --Citizen.Wait(15000)

        local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

            for i=1, 15, 1 do
              Citizen.Wait(900)
            
              ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
              end)
            end

        if GetEntityHealth(closestPlayerPed) == 0 then
          TriggerServerEvent('esx_ambulancejob:removeItem','defibrillateur')
          TriggerServerEvent('esx_ambulancejob:rethecrowsrp2vive', GetPlayerServerId(closestPlayer))
          ESX.ShowNotification(_U('revive_complete') .. GetPlayerServerId(closestPlayer))
        else
          ESX.ShowNotification(GetPlayerName(closestPlayer) .. _U('isdead'))
        end
      end)
    else
		  ESX.ShowNotification(GetPlayerName(closestPlayer) .. _U('unconscious'))
    end
  end
end)