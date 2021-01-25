Config = {}
Config.Locale = 'es'

Config.Main = {
	MenuAlign = 'top-left', -- Menu Align. Current will show on Top Left.
	DrawDistance = 45, -- Draw Distance to Markers.
	AdvVehShop = false, -- Set to true if using esx_advancedvehicleshop.
	Commands = false, -- Will allow players to do /getproperties instead of having to log out & back in to see Private Garages.
	ParkVehicles = true, -- true = Automatically Park all Vehicles in Garage on Server/Script Restart | false = Opposite of true but players will have to go to Pound to get their Vehicle Back.
	KickCheaters = true, -- true = Kick Player that tries to Cheat Garage by changing Vehicle Hash/Plate.
	CustomKickMsg = true, -- true = Sets Custom Kick Message for those that try to Cheat. Note: "Config.KickPossibleCheaters" must be true.
	GiveSocMoney = false, -- true = Gives money to society_mechanic. Note: REQUIRES esx_mechanicjob.
	ShowVehLoc = true, -- true = Will show Location of Vehicles in the Garage Menus.
	Spacers = true, -- true = Shows Spacers in Menus.
	PoundTimer = false, -- true = Uses Pound Timer
	PoundWait = 5, -- How many Minutes someone must wait before Opening Pound Menu Again.
	JPoundTimer = false, -- true = Uses Job Pound Timer
	JPoundWait = 2.5, -- How many Minutes someone must wait before Opening Job Pound Menu Again.
	DamageMult = false, -- true = Costs more to Store a Broken/Damaged Vehicle.
	MultAmount = 60 -- Higher Number = Higher Repair Price.
}

Config.Blips = {
	Garages = {Sprite = 290, Color = 38, Display = 2, Scale = 1.0}, -- Public Garage Blip.
	Pounds = {Sprite = 67, Color = 64, Display = 2, Scale = 1.0}, -- Pound Blip.
}

Config.Aircrafts = {
	Garages = false, -- true = Allows use of Aircraft Garages.
	Blips = false, -- true = Use Aircraft Blips.
	PoundP = 2500, -- How much it Costs to get Vehicles from Aircraft Pound.
	Markers = {
		Points = {Type = 1, r = 0, g = 255, b = 0, x = 1.5, y = 1.5, z = 1.0}, -- Green Color / Standard Size Circle.
		Delete = {Type = 1, r = 255, g = 0, b = 0, x = 5.0, y = 5.0, z = 1.0}, -- Red Color / Big Size Circle.
		Pounds = {Type = 1, r = 0, g = 0, b = 100, x = 1.5, y = 1.5, z = 1.0} -- Blue Color / Standard Size Circle.
	}
}

Config.Boats = {
	Garages = false, -- true = Allows use of Boat Garages.
	Blips = false, -- true = Use Boat Blips.
	PoundP = 500, -- How much it Costs to get Vehicles from Boat Pound.
	Markers = {
		Points = {Type = 1, r = 0, g = 255, b = 0, x = 1.5, y = 1.5, z = 1.0}, -- Green Color / Standard Size Circle.
		Delete = {Type = 1, r = 255, g = 0, b = 0, x = 5.0, y = 5.0, z = 1.0}, -- Red Color / Big Size Circle.
		Pounds = {Type = 1, r = 0, g = 0, b = 100, x = 1.5, y = 1.5, z = 1.0} -- Blue Color / Standard Size Circle.
	}
}

Config.Cars = {
	Garages = true, -- true = Allows use of Car Garages.
	Blips = true, -- true = Use Car Blips.
	PoundP = 300, -- How much it Costs to get Vehicles from Car Pound.
	Markers = {
		Points = {Type = 1, r = 0, g = 255, b = 0, x = 5.0, y = 5.0, z = 1.0}, -- Green Color / Standard Size Circle.
		Delete = {Type = 1, r = 255, g = 0, b = 0, x = 5.0, y = 5.0, z = 1.0}, -- Red Color / Big Size Circle.
		Pounds = {Type = 1, r = 0, g = 0, b = 100, x = 3.0, y = 3.0, z = 1.0} -- Blue Color / Standard Size Circle.
	}
}

-- Start of Aircrafts
Config.AircraftGarages = {
	Los_Santos_Airport = {
		Marker = vector3(-1617.14, -3145.52, 12.99),
		Spawner = vector3(-1657.99, -3134.38, 12.99),
		Deleter = vector3(-1642.12, -3144.25, 12.99),
		Heading = 330.11
	},
	Sandy_Shores_Airport = {
		Marker = vector3(1723.84, 3288.29, 40.16),
		Spawner = vector3(1710.85, 3259.06, 40.69),
		Deleter = vector3(1714.45, 3246.75, 40.07),
		Heading = 104.66
	},
	Grapeseed_Airport = {
		Marker = vector3(2152.83, 4797.03, 40.19),
		Spawner = vector3(2122.72, 4804.85, 40.78),
		Deleter = vector3(2082.36, 4806.06, 40.07),
		Heading = 115.04
	}
}

Config.AircraftPounds = {
	Los_Santos_Airport = {
		Marker = vector3(-1243.0, -3391.92, 12.94),
		Spawner = vector3(-1272.27, -3382.46, 12.94),
		Heading = 330.25
	}
}
-- End of Aircrafts

-- Start of Boats
Config.BoatGarages = {
	Los_Santos_Dock = {
		Marker = vector3(-735.87, -1325.08, 0.6),
		Spawner = vector3(-718.87, -1320.18, -0.47),
		Deleter = vector3(-731.15, -1334.71, -0.47),
		Heading = 45.0
	},
	Sandy_Shores_Dock = {
		Marker = vector3(1333.2, 4269.92, 30.5),
		Spawner = vector3(1334.61, 4264.68, 29.86),
		Deleter = vector3(1323.73, 4269.94, 29.86),
		Heading = 87.0
	},
	Paleto_Bay_Dock = {
		Marker = vector3(-283.74, 6629.51, 6.3),
		Spawner = vector3(-290.46, 6622.72, -0.47),
		Deleter = vector3(-304.66, 6607.36, -0.47),
		Heading = 52.0
	}
}

Config.BoatPounds = {
	Los_Santos_Dock = {
		Marker = vector3(-738.67, -1400.43, 4.0),
		Spawner = vector3(-738.33, -1381.51, 0.12),
		Heading = 137.85
	}
	--[[Sandy_Shores_Dock = {
		Marker = vector3(1299.36, 4217.93, 32.91),
		Spawner = vector3(1294.35, 4226.31, 29.86),
		Heading = 345.0
	},
	Paleto_Bay_Dock = {
		Marker = vector3(-270.2, 6642.43, 6.36),
		Spawner = vector3(-290.38, 6638.54, -0.47),
		Heading = 130.0
	}]]--
}
-- End of Boats
--x=732.75,y=-1088.99,z=21.17
Config.Dismantle = {
	Police = {
		Marker = vector3(1564.15,-2167.36,76.51),
	}
}

-- Start of Cars
Config.CarGarages = {
	Los_Santos = {
		Marker = vector3(-305.86,-899.12,30.08),
		Spawner = vector3(-305.86,-899.12,30.08),
		Deleter = vector3(-327.56,-892.89,30.07),
		Heading = 343.37
	},
	Los_Santos2_McdonaldStreet = {
		Marker = vector3(345.23, -1687.46, 31.6),
		Spawner = vector3(357.76, -1672.07, 31.6),
		Deleter = vector3(374.98, -1687.86, 31.6),
		Heading = 157.84
	},
	Los_Santos2_RockfordDrive = {
		Marker = vector3(-1212.45, -654.57, 24.8),
		Spawner = vector3(-1208.61, -666.29, 24.8),
		Deleter = vector3(-1225.75, -648.28, 24.8),
		Heading = 157.84
	},
	Los_Santos_Mechanics = {
		Marker = vector3(1113.44, -2277.14, 29.14),
		Spawner = vector3(1113.44, -2287.14, 29.14),
		Deleter = vector3(1090.84, -2300.48, 29.14),
		Heading = 157.84
	},
	Sandy_Shores = {
		Marker = vector3(1737.59, 3710.2, 33.14),
		Spawner = vector3(1737.84, 3719.28, 33.04),
		Deleter = vector3(1722.66, 3713.74, 33.21),
		Heading = 21.22
	},
	Paleto_Bay = {
		Marker = vector3(105.36, 6613.59, 31.40),
		Spawner = vector3(128.78, 6622.99, 30.78),
		Deleter = vector3(126.36, 6608.41, 30.86),
		Heading = 315.01
	},
	Casino={
		Marker= vector3(885.04, -40.26, 77.76),
		Spawner=vector3(885.04, -40.26, 77.76),
		Deleter=vector3(903.72, -51.50, 77.76),
		Heading=147.51
	}
}

Config.CarPounds = {
	Los_Santos = {
		Marker = vector3(408.61, -1625.47, 28.29),
		-- ESTO LO USABA PARA TESTEAR AUTOS EN CONCE Marker = vector3(-34, -1088, 25.29),
		Spawner = vector3(405.64, -1643.4, 27.61),
		Heading = 229.54
	},
	Sandy_Shores = {
		Marker = vector3(1651.38, 3804.84, 37.65),
		Spawner = vector3(1627.84, 3788.45, 33.77),
		Heading = 308.53
	},
	Paleto_Bay = {
		Marker = vector3(-234.82, 6198.65, 30.94),
		Spawner = vector3(-230.08, 6190.24, 30.49),
		Heading = 140.24
	}
}
-- End of Cars