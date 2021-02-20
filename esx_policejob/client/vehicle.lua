
local spawnedVehicles = {}

function OpenVehicleSpawnerMenu(type,station,part,partnum)
	local ped = PlayerPedId()
	if(IsPedInAnyVehicle(ped,false))then
		DeleteEntity(GetVehiclePedIsIn(ped,false))
		return
	end
	local elements={}
	local grade = ESX.PlayerData.job.grade_name
	authorizedVehicles = Config.AuthorizedVehicles.car[grade]
	for k,v in pairs(authorizedVehicles) do
		if IsModelInCdimage(v.model)then
			table.insert(elements,{
				value=v.model,
				label=v.name
			})
		end
	end

	ESX.UI.Menu.Open('default',GetCurrentResourceName(),'vehicle',{
		title="Vehiculos disponibles",
		align='top-left',
		elements=elements
	}, function(data,menu)
		ESX.Game.SpawnVehicle(data.current.value, Config.Vehicles[1].SpawnPoints[1].coords, Config.Vehicles[1].SpawnPoints[1].heading, function(vehicle)
				WashDecalsFromVehicle(vehicle, 1.0)
				SetVehicleDirtLevel(vehicle)
				TaskWarpPedIntoVehicle(ped, vehicle, -1)
				SetVehicleNumberPlateText(vehicle, GetPlayerServerId(PlayerId()))
				
			end)
			menu.close()
	end, function(data,menu)
		menu.close()
	end)
end

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName(_U('vehicleshop_awaiting_model'))
		EndTextCommandBusyspinnerOn(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		BusyspinnerOff()
	end
end
