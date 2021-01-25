Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableLicenses             = false -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = false -- enable blips for cops on duty, requires esx_society
Config.EnableCustomPeds           = false -- enable custom peds in cloak room? See Config.CustomPeds below to customize peds

Config.EnableESXService           = false -- enable esx service?
Config.MaxInService               = 5

Config.Locale                     = 'es'

Config.Blip = {
	Coords  = vector3(425.1, -979.5, 30.7),
	Sprite  = 60,
	Display = 4,
	Scale   = 1.2,
	Colour  = 29
}

Config.Cloakrooms = {
	vector3(452.6, -992.8, 30.6)
}

Config.Armories = {
	vector3(458.28, -979.23, 30.6)
}

Config.Vehicles = {
	{
		Spawner = vector3(454.6, -1017.4, 28.4),
		InsideShop = vector3(228.5, -993.5, -99.5),
		SpawnPoints = {
			{coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0},
			{coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
			{coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0},
			{coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0}
		}
	},
}

Config.BossActions = {
	vector3(448.4, -973.2, 30.6)
}

Config.AuthorizedWeapons = {
	recruit = {
		{weapon = 'WEAPON_COMBATPISTOL', components = {0, 0, 1000, 4000, nil}, price = 600},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 10},
		{weapon = 'WEAPON_FLASHLIGHT', price = 10}
	},

	officer = {
		{weapon = 'WEAPON_COMBATPISTOL', components = {0, 0, 1000, 4000, nil}, price = 600},
		--{weapon = 'WEAPON_CARBINERIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 10},
		{weapon = 'WEAPON_FLASHLIGHT', price = 10}
	},

	sergeant = {
		{weapon = 'WEAPON_COMBATPISTOL', components = {0, 0, 1000, 4000, nil}, price = 600},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 1000},
		{weapon = 'WEAPON_SMG', components = {0, 6000, 1000, 4000, 8000, nil}, price = 1100},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 10},
		{weapon = 'WEAPON_FLASHLIGHT', price = 10}
	},

	lieutenant = {
		{weapon = 'WEAPON_COMBATPISTOL', components = {0, 0, 1000, 4000, nil}, price = 600},
		{weapon = 'WEAPON_CARBINERIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 2000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 1000},
		{weapon = 'WEAPON_SMG', components = {0, 6000, 1000, 4000, 8000, nil}, price = 1100},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 10},
		{weapon = 'WEAPON_FLASHLIGHT', price = 10}
	},

	chief = {
		{weapon = 'WEAPON_COMBATPISTOL', components = {0, 0, 1000, 4000, nil}, price = 600},
		{weapon = 'WEAPON_CARBINERIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 2000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 1000},
		{weapon = 'WEAPON_SMG', components = {0, 6000, 1000, 4000, 8000, nil}, price = 1100},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 10},
		{weapon = 'WEAPON_FLASHLIGHT', price = 10}
	},

	boss = {
		{weapon = 'WEAPON_COMBATPISTOL', components = {0, 0, 1000, 4000, nil}, price = 600},
		{weapon = 'WEAPON_CARBINERIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 2000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 1000},
		{weapon = 'WEAPON_SMG', components = {0, 6000, 1000, 4000, 8000, nil}, price = 1100},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 10},
		{weapon = 'WEAPON_FLASHLIGHT', price = 10}
	}
}

Config.AuthorizedVehicles = {
	car = {
		recruit = {--CABO
			{model = 'chargertest', price = 25000, name="Patrullero"},
			{model = 'sp21', price = 25000, name="Camioneta"},
			{model = 'policeb', price = 18500, name="Moto"}
		
		},

		officer = {--OFICIAL
			{model = 'chargertest', price = 25000,name="Patrullero"},
			{model = 'sp21', price = 25000, name="Camioneta"},
			{model = 'policeb', price = 18500, name="Moto"},
		},

		sergeant = {--TENIENTE
			{model = 'chargertest', price = 25000,name="Patrullero"},
			{model = 'sp21', price = 25000, name="Camioneta"},
			{model = 'policeb', price = 18500, name="Moto"},
			{model = 'ghispo2', price = 10000,name="Persecucion GM"},
		},

		lieutenant = {--CAPITAN
			{model = 'chargertest', price = 25000,name="Patrullero"},
			{model = 'sp21', price = 25000, name="Camioneta"},
			{model = 'policeb', price = 18500, name="Moto"},
			{model = 'ghispo2', price = 10000,name="Persecucion GM"},
			{model = 'lencorus', price = 70000, name="Unidad Antidisturbios"},
			{model = 'policet', price = 20500, name="Unidad de Traslado"},
		},

		chief = {--CAPITAN
			{model = 'chargertest', price = 25000,name="Patrullero"},
			{model = 'sp21', price = 25000, name="Camioneta"},
			{model = 'policeb', price = 18500, name="Moto"},
			{model = 'ghispo2', price = 10000,name="Persecucion GM"},
			{model = 'lencorus', price = 70000, name="Unidad Antidisturbios"},
			{model = 'policet', price = 20500, name="Unidad de Traslado"},
		},

		boss = {--MAYOR
			{model = 'chargertest', price = 25000,name="Patrullero"},
			{model = 'sp21', price = 25000, name="Camioneta"},
			{model = 'policeb', price = 18500, name="Moto"},
			{model = 'ghispo2', price = 10000,name="Persecucion GM"},
			{model = 'lencorus', price = 70000, name="Unidad Antidisturbios"},
			{model = 'policet', price = 20500, name="Unidad de Traslado"},
		}
	},

}

Config.CustomPeds = {
	shared = {
		{label = 'Sheriff Ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'},
		{label = 'Police Ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'}
	},

	recruit = {},

	officer = {},

	sergeant = {},

	lieutenant = {},

	boss = {
		{label = 'SWAT Ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	recruit = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 9,   torso_2 = 6,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 28,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = 2,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	officer = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 9,   torso_2 = 5,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 28,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = 2,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 1,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	sergeant = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 9,   torso_2 = 4,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 28,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = 2,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 152,  tshirt_2 = 0,
			torso_1 = 43,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 38,
			pants_1 = 30,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	lieutenant = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 9,   torso_2 = 3,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 28,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = 2,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 152,  tshirt_2 = 0,
			torso_1 = 43,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 38,
			pants_1 = 30,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	chief = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 9,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 28,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = 2,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 152,  tshirt_2 = 0,
			torso_1 = 43,   torso_2 = 1,
			decals_1 = 7,   decals_2 = 3,
			arms = 38,
			pants_1 = 30,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 105,  helmet_2 = 21,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	boss = {
		male = {
			tshirt_1 = 122,  tshirt_2 = 0,
			torso_1 = 9,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 28,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = 2,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 152,  tshirt_2 = 0,
			torso_1 = 43,   torso_2 = 1,
			decals_1 = 7,   decals_2 = 3,
			arms = 38,
			pants_1 = 30,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 105,  helmet_2 = 21,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	bullet_wear = {
		male = {
			bproof_1 = 7,  bproof_2 = 3
		},
		female = {
			bproof_1 = 4,  bproof_2 = 0
		}
	},

	gilet_wear = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}
