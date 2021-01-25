Config = {
	Store = {
		cooldown = 1800,
		last = 0
	},
	Bank = {
		cooldown = 5400,
		last = 0
	},
	Custom = {
		cooldown = 3600,
		last = 0
	},
	Extras = {
		cooldown = 10800,
		last = 0
	}
}

Config.MaxDistance=35

Config.Vangelico={
		position = { ['x'] = -630.27, ['y'] = -228.94, ['z'] = 38.05 },       
		nameofstore = "jewelry",
		lastrobbed = 0
}

Config.Stores = {
	["Armery"] = {
		position = { x = 808.44, y = -2159.47, z = 29.62 },
		reward = math.random(65000, 78000),
		name = "Armeria (Popular Street)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0,
		armery=true
	},
	["paleto_twentyfourseven"] = {
		position = { x = 1736.32, y = 6419.47, z = 35.03 },
		reward = math.random(40000, 50000),
		name = "24/7. (Paleto Bay)",
		secondsRemaining = 350, -- seconds
		lastRobbed = 0
	},
	["sandyshores_twentyfoursever"] = {
		position = { x = 1961.24, y = 3749.46, z = 32.34 },
		reward = math.random(40000, 50000),
		name = "24/7. (Sandy Shores)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["littleseoul_twentyfourseven"] = {
		position = { x = -709.17, y = -904.21, z = 19.21 },
		reward = math.random(40000, 50000),
		name = "24/7. (Little Seoul)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	-- ["bar_one"] = {
		-- position = { x = 1990.57, y = 3044.95, z = 47.21 },
		-- reward = math.random(5000, 35000),
		-- name = "Yellow Jack. (Sandy Shores)",
		-- secondsRemaining = 300, -- seconds
		-- lastRobbed = 0
	-- },
	["ocean_liquor"] = {
		position = { x = -2959.33, y = 388.21, z = 14.00 },
		reward = math.random(40000, 50000),
		name = "Robs Liquor. (Great Ocean Highway)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["rancho_liquor"] = {
		position = { x = 1126.80, y = -980.40, z = 45.41 },
		reward = math.random(40000, 50000),
		name = "Robs Liquor. (El Rancho Blvd)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["sanandreas_liquor"] = {
		position = { x = -1219.85, y = -916.27, z = 11.32 },
		reward = math.random(40000, 50000),
		name = "Robs Liquor. (San Andreas Avenue)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["grove_ltd"] = {
		position = { x = -43.40, y = -1749.20, z = 29.42 },
		reward = math.random(40000, 50000),
		name = "LTD Gasoline. (Grove Street)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["mirror_ltd"] = {
		position = { x = 1160.67, y = -314.40, z = 69.20 },
		reward = math.random(40000, 50000),
		name = "LTD Gasoline. (Mirror Park Boulevard)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	}
}

Config.Places = {
	-- STORES
	--[[ ["paleto_twentyfourseven"] = {
		position = {x = 1734.68, y = 6420.43, z = 35.04},
		reward = function()
			return math.random(170000, 200000)
		end,
		name = "24/7 (Paleto Bay)",
		type = "Store",
		police = 2
	},
	["littleseoul_twentyfourseven"] = {
		position = {x = -709.17, y = -904.21, z = 19.21},
		reward = function()
			return math.random(170000, 200000)
		end,
		name = "24/7 (Little Seoul)",
		type = "Store",
		police = 2
	},
	["bar_one"] = {
		position = {x = 1987.35, y = 3050.8, z = 47.22},
		reward = function()
			return math.random(170000, 200000)
		end,
		name = "Yellow Jack (Sandy Shores)",
		type = "Store",
		police = 2
	},
	["grove_ltd"] = {
		position = {x = -42.88, y = -1748.91, z = 29.42},
		reward = function()
			return math.random(170000, 200000)
		end,
		name = "LTD Gasoline (Grove Street)",
		type = "Store",
		police = 2
	},
	["mirror_ltd"] = {
		position = {x = 1160.33, y = -313.98, z = 69.21},
		reward = function()
			return math.random(170000, 200000)
		end,
		name = "LTD Gasoline (Mirror Park Boulevard)",
		type = "Store",
		police = 2
	}, ]]

	-- BANKS
	["phonestore"] = {
		position = {x = -1054.77,  y = -231.37,  z = 44.02},
		reward = function()
			return math.random(200000, 210000)
		end,
		name = "Tienda de informatica",
		type = "phonestore",
		help="la tienda de informatica",
		police = 4
	},
	["fleeca"] = {
		position = {x = 146.64, y = -1045.55, z = 29.38},
		reward = function()
			return math.random(150000, 160000)
		end,
		name = "Fleeca Bank",
		type = "Bank",
		police = 4,
		help="el banco"
	},
	["fleeca2"] = {
		position = {x = -2957.05, y = 481.26, z = 15.57},
		reward = function()
			return math.random(150000, 160000)
		end,
		name = "Fleeca Bank (Autopista)",
		type = "Bank",
		police = 4,
		help="el banco"
	},
	["blainecounty"] = {
		position = {x = -105.24, y = 6470.81, z = 31.63},
		reward = function()
			return math.random(150000, 160000)
		end,
		name = "Blaine County Savings",
		type = "Bank",
		police = 4,
		help="el banco"
	},

	-- CUSTOM
	--[[ ["jewelry"] = {
		position = {x = -630.69, y = -229.11, z = 38.06},
		reward = function()
			return math.random(200000, 600000)
		end,
		name = "Joyería Vangelico",
		type = "Custom",
		police = 3
	}, ]]

	-- EXTRAS
	["grandbank"] = {
		position = {x = 253.89, y = 228.23, z = 101.68},
		reward = function()
			return math.random(250000, 260000)
		end,
		name = "Banco Principal",
		type = "Bank",
		police = 6,
		help="el banco",
		lastRob = 0
	}
}

Config.Houses={
	["1"]={
		position={x=102.03,y=3645.35,z=39.75,heading=90.72},
		alert=false,
		lastRob= 0
	},
	["2"]={
		position={x=22.41,y=3671.93,z=39.75,heading=245.45},
		alert=false,
		lastRob= 0
	},
	["3"]={
		position={x=0.53,y=3727.66,z=39.75,heading=224.87},
		alert=false,
		lastRob= 0
	},
	["4"]={
		position={x=76.68,y=3757.4,z=39.75,heading=106.21},
		alert=false,
		lastRob= 0
	},
	["5"]={
		position={x=30.78,y=3735.94,z=40.61,heading=322.09},
		alert=false,
		lastRob= 0
	}
}

Config.Doors={
	["grandbankdoor"] = {
		position = {x=261.84, y=223.09,z= 106.28},
		bankdoor=true,
		name = "Banco Principal",
	},
}

