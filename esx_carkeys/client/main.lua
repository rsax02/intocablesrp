-- Client

ESX               = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("esx_givecarkeys:keys")
AddEventHandler("esx_givecarkeys:keys", function(id)

giveCarKeys(id)

end)

function giveCarKeys(id)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
        vehicle = GetVehiclePedIsIn(playerPed, false)			
    else
		ESX.ShowNotification('Tienes que estar en un vehículo para dar las llaves a otro jugador')
		return
    end

	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)


	ESX.TriggerServerCallback('esx_givecarkeys:requestPlayerCars', function(isOwnedVehicle)

		if isOwnedVehicle then

 	ESX.ShowNotification('Le diste las llaves de tu vehículo con placa ~g~'..vehicleProps.plate..'~w~ al jugador~y~ '..id)
	  
	 TriggerServerEvent('esx_givecarkeys:setVehicleOwnedPlayerId', id, vehicleProps, GetPlayerServerId(PlayerId()))


		else
		 ESX.ShowNotification('QUÉ FLASHÁS WACHÍN? ESTE AUTO NO ES TUYO CONCHETUMADRE')
		end
	end, GetVehicleNumberPlateText(vehicle))
end
