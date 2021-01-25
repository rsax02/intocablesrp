Config.Jobs.miner = {

	BlipInfos = {
		Sprite = 318,
		Color = 5
	},

	Vehicles = {

		Truck = {
			Spawner = 1,
			Hash = "rubble",
			Trailer = "none",
			HasCaution = true
		}

	},

	Zones = {

		CloakRoom = {
			Pos = {x = 892.35, y = -2172.77, z = 31.28},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U("m_miner_locker"),
			Type = "cloakroom",
			Hint = _U("cloak_change"),
			GPS = {x = 884.86, y = -2176.51, z = 29.51}
		},

		Mine = {
			Pos = {x = 2962.40, y = 2746.20, z = 42.39},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U("m_rock"),
			Type = "work",
			Item = {
				{
					name = "Piedra",
					db_name = "stone",
					time = 5000,
					max = 14,
					add = 1,
					remove = 1,
					requires = "nothing",
					requires_name = "Piedra",
					drop = 100
				}
			},
			Hint = _U("m_pickrocks"),
			GPS = {x = 289.24, y = 2862.90, z = 42.64}
		},

		StoneWash = {
			Pos = {x = 289.24, y = 2862.90, z = 42.64},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U("m_washrock"),
			Type = "work",
			Item = {
				{
					name = "Piedra lavada",
					db_name = "washed_stone",
					time = 6000,
					max = 14,
					add = 1,
					remove = 1,
					requires = "stone",
					requires_name = "Piedra",
					drop = 100
				}
			},
			Hint = _U("m_rock_button"),
			GPS = {x = 1109.14, y = -2007.87, z = 30.01}
		},

		Foundry = {
			Pos = {x = 1109.14, y = -2007.87, z = 30.01},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U("m_rock_smelting"),
			Type = "work",
			Item = {
				{
					name = _U("m_copper"),
					db_name = "copper",
					time = 4000,
					max = 112,
					add = 8,
					remove = 1,
					requires = "washed_stone",
					requires_name = "Piedra lavada",
					drop = 100
				},
				{
					name = _U("m_iron"),
					db_name = "iron",
					max = 84,
					add = 6,
					drop = 100
				},
				{
					name = _U("m_gold"),
					db_name = "gold",
					max = 42,
					add = 3,
					drop = 100
				},
				{
					name = _U("m_diamond"),
					db_name = "diamond",
					max = 100,
					add = 1,
					drop = 4
				}
			},
			Hint = _U("m_melt_button"),
			GPS = {x = -169.48, y = -2659.16, z = 5.00}
		},

		VehicleSpawner = {
			Pos = {x = 884.86, y = -2176.51, z = 29.51},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = false,
			Name = _U("spawn_veh"),
			Type = "vehspawner",
			Spawner = 1,
			Hint = _U("spawn_veh_button"),
			Caution = 100,
			GPS = {x = 2962.40, y = 2746.20, z = 42.39}
		},

		VehicleSpawnPoint = {
			Pos = {x = 879.55, y = -2189.79, z = 29.51},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Marker = -1,
			Blip = false,
			Name = _U("service_vh"),
			Type = "vehspawnpt",
			Spawner = 1,
			Heading = 90.1,
			GPS = 0
		},

		VehicleDeletePoint = {
			Pos = {x = 881.93, y = -2198.01, z = 29.51},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Marker = 1,
			Blip = false,
			Name = _U("return_vh"),
			Type = "vehdelete",
			Hint = _U("return_vh_button"),
			Spawner = 1,
			Caution = 100,
			GPS = 0,
			Teleport = 0
		},

		CopperDelivery = {
			Pos = {x = -169.481, y = -2659.16, z = 5.00103},
			Color = {r = 204, g = 204, b = 0},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			Marker = 1,
			Blip = true,
			Name = _U("m_sell_copper"),
			Type = "delivery",
			Spawner = 1,
			Item = {
				{
					name = _U("delivery"),
					time = 500,
					remove = 1,
					max = 120, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 2,
					requires = "copper",
					requires_name = _U("m_copper"),
					drop = 100
				}
			},
			Hint = _U("m_deliver_copper"),
			GPS = {x = -148.78, y = -1040.38, z = 26.27}
		},

		IronDelivery = {
			--Pos = {x = -148.78, y = -1040.38, z = 26.27}, 
			Pos = {x=75.21,y=-346.75,z=41.63},
			Color = {r = 204, g = 204, b = 0},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U("m_sell_iron"),
			Type = "delivery",
			Spawner = 1,
			Item = {
				{
					name = _U("delivery"),
					time = 1500,
					remove = 1,
					max = 42, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 6,
					requires = "iron",
					requires_name = _U("m_iron"),
					drop = 100
				}
			},
			Hint = _U("m_deliver_iron"),
			GPS = {x = 261.48, y = 207.35, z = 109.28}
		},

		GoldDelivery = {
			Pos = {x = 261.48, y = 207.35, z = 105.28},
			Color = {r = 204, g = 204, b = 0},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U("m_sell_gold"),
			Type = "delivery",
			Spawner = 1,
			Item = {
				{
					name = _U("delivery"),
					time = 2000,
					remove = 1,
					max = 21, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 8,
					requires = "gold",
					requires_name = _U("m_gold"),
					drop = 100
				}
			},
			Hint = _U("m_deliver_gold"),
			GPS = {x = -621.04, y = -228.53, z = 37.05}
		},

		DiamondDelivery = {
			Pos = {x = -661.81, y = -220.21, z = 36.73},
			Color = {r = 204, g = 204, b = 0},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U("m_sell_diamond"),
			Type = "delivery",
			Spawner = 1,
			Item = {
				{
					name = _U("delivery"),
					time = 500,
					remove = 1,
					max = 50, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 60,
					requires = "diamond",
					requires_name = _U("m_diamond"),
					drop = 100
				}
			},
			Hint = _U("m_deliver_diamond"),
			GPS = {x = 2962.40, y = 2746.20, z = 42.39}
		}

	}
}
