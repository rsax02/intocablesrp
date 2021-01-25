Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 4, g = 201, b = 245, a = 100, rotate = false }

Config.ReviveReward               = 100  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'es'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 6 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 10 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(358.79, -567.7, 28.96), heading = 60.0 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(363.6, -591.44, 27.7),
			sprite = 61,
			scale  = 1.2,
			color  = 1
		},

		AmbulanceActions = {
		--X:327.2  Y:-596.46  Z:28.79
			vector3(327.2, -596.46, 27.79)
		},
		
		AmbulanceStock = {
			vector3(314.7,-589.89,27.79)
		},
		
		CloakRoom = {
			vector3(336.22,-580.31,27.79)
		},

		Pharmacies = {
			vector3(353.78, -577.9, 27.7)
		},

		Vehicles = {
			{
			--X:320.0  Y:-541.25   Z:28.74
				Spawner = vector3(320.0, -541.25, 28.74),
				InsideShop = vector3(340.68, -561.67, 28.7),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(321.04, -541.7, 28.7), heading = 170, radius = 4.0 },
					{ coords = vector3(326.04, -541.7, 28.7), heading = 170, radius = 4.0 },
					{ coords = vector3(331.04, -541.7, 28.7), heading = 170, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(317.5, -1449.5, 46.5),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(313.5, -1465.1, 46.5), heading = 142.7, radius = 10.0 },
					{ coords = vector3(299.5, -1453.2, 46.5), heading = 142.7, radius = 10.0 }
				}
			}
		},

	}
}

Config.AuthorizedVehicles = {

	ambulance = {
		{ model = 'ambulance', label = 'Ambulancia', price = 5000},
		{ model = 'qrv', label = 'Ambulancia 4x4', price = 5000}
	},

	doctor = {
		{ model = 'ambulance', label = 'Ambulancia', price = 4500},
		{ model = 'qrv', label = 'Ambulancia 4x4', price = 5000}
	},

	chief_doctor = {
		{ model = 'ambulance', label = 'Ambulancia', price = 3000},
		{ model = 'qrv', label = 'Ambulancia 4x4', price = 5000}
	},

	supervisor = {
		{ model = 'ambulance', label = 'Ambulancia', price = 3000}, 
		{ model = 'qrv', label = 'Ambulancia 4x4', price = 5000}
	},
	
	boss = {
		{ model = 'ambulance', label = 'Ambulancia', price = 2000},
		{ model = 'qrv', label = 'Ambulancia 4x4', price = 5000}
	}

}

Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 150000 }
	},

	chief_doctor = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 150000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 300000 }
	},

	boss = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 10000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 250000 }
	}

}
