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
Config.BleedoutTimer              = 12 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(-459.19,-283.89,34.91), heading = 196.86 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(-445.25,-312.68,34.09),
			sprite = 61,
			scale  = 1.3,
			color  = 1
		},

		AmbulanceActions = {
		--X:327.2  Y:-596.46  Z:28.79
			vector3(-498.02,-315.74, 41.32)
		},
		
		AmbulanceStock = {
			vector3(-437.81,-307.92, 33.91)
		},
		
		CloakRoom = {
			vector3(-443.62,-310.16, 33.91)
		},

		Pharmacies = {
			vector3(-457.12,-310.46,33.91)
		},

		Vehicles = {
			{
			--X:320.0  Y:-541.25   Z:28.74
				Spawner = vector3(-420.33, -334.55, 33.11),
				InsideShop = vector3(340.68, -561.67, 28.7),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-425, -353.62, 33.11 ), heading = 163.87, radius = 4.0 },
					{ coords = vector3(-425, -353.62, 33.11 ), heading = 163.87, radius = 4.0 },
					{ coords = vector3(-425, -353.62, 33.11 ), heading = 163.87, radius = 4.0 },
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
