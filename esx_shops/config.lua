Config              = {}
Config.DrawDistance = 38
Config.Size         = {x = 1.5, y = 1.5, z = 1.5}
Config.Color        = {r = 0, g = 128, b = 255}
Config.Type         = 1
Config.Locale       = 'es'

Config.Zones = {
	Pharmacy = {
		Blip=true,
		Sprite=403,
		Color=1,
		Size=1.0,
		Name="InkaFarma",
		Items={
			{name="bandage", label="Venda", type="money", amount=150, level=1}
		},
		Jobs=nil,
		Pos={
			{ x = 68.71,    y = -1569.78, z = 28.59, time='10-18'},
			{ x = 98.45,    y = -225.41,  z = 53.64, time='10-18'},
			{ x = 591.24,   y = 2744.42,  z = 41.04, time=nil},
			{ x = 326.53,   y = -1074.25, z = 28.48, time='10-18'},
			{ x = 213.69,   y = -1835.14, z = 26.56, time='10-18'},
			{ x = -3157.74, y = 1095.24,  z = 19.85, time='10-18'},
			{x=-56.46,y=6521.72,z=30.49, time='10-18'},
			{x=1815.61,y=3679.29,z=33.28, time=nil},
		}
	},

	Arcadius ={
		Blip=false,
		Sprite=76,
		Size=1.2,
		Color=40,
		Name="Arcadius",
		Items={
			{name = 'WEAPON_HEAVYPISTOL', bullets= 300, label = 'weapon', type = 'black_money', amount = 100000, level = 5},
			{name = 'WEAPON_MACHINEPISTOL',  bullets= 300, label = 'weapon', type = 'black_money', amount = 300000, level = 5},
			{name = 'WEAPON_MICROSMG',  bullets= 300,label = 'weapon', type = 'black_money', amount = 300000, level = 5},
			{name = 'WEAPON_SMG',  bullets= 300,label = 'weapon', type = 'black_money', amount = 300000, level = 5},
			{name = 'WEAPON_BULLPUPSHOTGUN', bullets= 300, label = 'weapon', type = 'black_money', amount = 300000, level = 5},
			{name = 'WEAPON_PUMPSHOTGUN',  bullets= 300,label = 'weapon', type = 'black_money', amount = 300000, level = 5},
			{name = 'WEAPON_CARBINERIFLE',  bullets= 300,label = 'weapon', type = 'black_money', amount = 600000, level = 5},
			{name = 'WEAPON_ASSAULTRIFLE', bullets= 300, label = 'weapon', type = 'black_money', amount = 600000, level = 5},
			{name = 'WEAPON_MARKSMANRIFLE',  bullets= 300,label = 'weapon', type = 'black_money', amount = 1000000, level = 5},
			{name = 'WEAPON_SNIPERRIFLE',  bullets= 300,label = 'weapon', type = 'black_money', amount = 1000000, level = 1}
		},
		Jobs={["arcadius"]=3},
		Pos={
			{x=2556.31,y=4661.21,z=34}
		}
	},-- restaurante real paleto
	Dinner = {
		Blip=true,
		Sprite=52,   
		Size=0.95,
		Color=1,
		Name="La parrilla de Choco",
		Items={
			{name="hamburger", label="Cangreburger", type="money", amount=20, level=1},
			{name="cocacola", label="CocaCola 350ml", type="money", amount=15, level=1},
			{name="icecream", label="Helado", type="money", amount=12, level=1},
			{name="sandwich", label="Sandwich Milanesa", type="money", amount=25, level=1},
			{name="empanada", label="Empanada de Carne", type="money", amount=30, level=1},
		},
		Jobs=nil,
		Pos={
			{x=1588.32,y=6455.15,z=25.01, time='0-24'},
		}
	},

	IllegalGuns = {
		Blip=false,
		Sprite=52,
		Size=1.2,
		Color=2,
		Name="Tienda Ilegal",
		Items = {
			{name="weapon_snspistol",  bullets= 52,label="weapon",type="black_money",amount=2900*8,level=50},
			{name="weapon_pistol",bullets= 52, label="weapon",type="black_money",amount=4500*8,level=50},
			--{name="weapon_pistol_mk2", label="weapon",type="black_money",amount=75000,level=30},
			{name="weapon_knife", bullets= 52,label="weapon",type="black_money",amount=1050*8,level=50},
			{name="armour", label="Chaleco",type="black_money",amount=36000*8,level=50},
		},
		Jobs=nil,
		Pos = {
			{x=-277.77,y=2205.38,z=129.4},
		}
	},

	IllegalMeleeGuns = {
		Blip=false,
		Sprite=52,
		Size=1.2,
		Color=2,
		Name="Tienda Ilegal",
		Items = {
			{name="weapon_knuckle",bullets= 52, label="weapon",type="black_money",amount=120000,level=50},
			--{name="weapon_switchblade",bullets= 52, label="weapon",type="black_money",amount=50000,level=25},
			{name="weapon_bat",bullets= 52, label="weapon",type="black_money",amount=160000,level=50},
			{name="weapon_golfclub",bullets= 52, label="weapon",type="black_money",amount=95000,level=50},
			{name="weapon_machete",bullets= 52, label="weapon",type="black_money",amount=120000,level=50},
		},
		Jobs=nil,
		Pos = {
			{x=1638.5,y=4879.29,z=41.03},
		}
	}, 

	Tecnologhy = {
		Blip=true,
		Sprite=521,
		Size=1.0,
		Color=27,
		Name="Tienda de informatica",
		Items={
			{name="phone", label="Samsung S10", type="money",amount=750,level=1},
			{name="phone", label="Iphone 8", type="money",amount=800,level=1},
		},
		Jobs=nil,
		Pos={
			{x=-1081.92, y=-248.09, z=36.76, time='8-21'}
		}
	},

	 IllegalItems = {
		Blip=false,
		Sprite=52,
		Size=1.2,
		Color=2,
		Name="Tienda Ilegal",
		Items = {
			{name="hackcard", label="Tarjeta de hackeo",type="money",amount=1600,level=15},
			{name="hackphone", label="Celular de hackeo",type="money",amount=5200,level=15},
			{name = 'blowpipe', label = 'Soplete', type = 'black_money', amount = 13000*5, level = 15}
			--{name="usb", label="Usb",type="black_money",amount=30000,level=15},
		},
		Jobs=nil,
		Pos = {
			{x=-222.07,y=-2358.85,z=20.33},
		}
	}, 
	
	TwentyFourSeven = {
		Blip=true,
		Sprite=52,
		Size=1.0,
		Color=2,
		Name="Tienda",
		Items = {
			{name="water", label="Cifrut",type="money",amount=7,level=1},
			{name="bread", label="Cuates",type="money",amount=18,level=1},
			{name="icecream", label="Helado",type="money",amount=11,level=1},
			{name="bombon", label="Caja de bombones",type="money",amount=30,level=1},
		},
		Jobs=nil,
		Pos = {
			{x = 373.875,   y = 325.896,  z = 102.566, time = nil},
			{x = 2557.458,  y = 382.282,  z = 107.622, time = nil},
			{x = -3038.939, y = 585.954,  z = 6.908, time = nil},
			{x = -3241.927, y = 1001.462, z = 11.830, time = nil},
			{x = 547.431,   y = 2671.710, z = 41.156, time = nil},
			{x = 1961.464,  y = 3740.672, z = 31.343, time = nil},
			{x = 2678.916,  y = 3280.671, z = 54.241, time = nil},
			{x = 1729.216,  y = 6414.131, z = 34.037, time = nil},
			{x = 1135.808,  y = -982.281,  z = 45.415, time = nil},
			{x = -1222.915, y = -906.983,  z = 11.326, time = nil},
			{x = -1487.553, y = -379.107,  z = 39.163, time = nil},
			{x = -2968.243, y = 390.910,   z = 14.043, time = nil},
			{x = 1166.024,  y = 2708.930,  z = 37.157, time = nil},
			{x = 1392.562,  y = 3604.684,  z = 33.980, time = nil},
			--{x = 127.830,   y = -1284.796, z = 28.280}, --StripClub
			--{x = -1393.409, y = -606.624,  z = 29.319}, --Tequila la
			{x = -48.519,   y = -1757.514, z = 28.421, time = nil},
			{x = 1163.373,  y = -323.801,  z = 68.205, time = nil},
			{x = -707.501,  y = -914.260,  z = 18.215, time = nil},
			{x = -1820.523, y = 792.518,   z = 137.118, time = nil},
			{x = 1698.388,  y = 4924.404,  z = 41.063, time = nil}
		}
	},
	Cucardas = {
		Blip=true,
		Sprite=121,
		Size=1.0,
		Color=27,
		Name="Las Cucardas",
		Items = {
			{name="beer", label="Cerveza",type="money",amount=20,level=1},
			{name="oldtime", label="OldTimes",type="money",amount=30,level=1},
			{name="russkaya", label="russkaya",type="money",amount=30,level=1},
		},
		Jobs=nil,
		Pos = {
			{x = 127.830,   y = -1284.796, z = 28.280,time = '0-24'}, --StripClub
			--{x = -1393.409, y = -606.624,  z = 29.319}, --Tequila la
		}
	},

	Scarlett = {
		Blip=true,
		Sprite=121,
		Size=1.0,
		Color=27,
		Name="Scarlett",
		Items = {
			{name="beer", label="Cerveza",type="money",amount=20,level=1},
			{name="oldtime", label="OldTimes",type="money",amount=30,level=1},
			{name="russkaya", label="russkaya",type="money",amount=30,level=1},
		},
		Jobs=nil,
		Pos = {
			--{x = 127.830,   y = -1284.796, z = 28.280}, --StripClub
			{x = -1393.409, y = -606.624,  z = 29.319,time = '0-24'}, --Tequila la
		}
	},

	Tequilala = {
		Blip=true,
		Sprite=121,
		Size=1.0,
		Color=27,
		Name="Tequi lala",
		Items = {
			{name="beer", label="Cerveza",type="money",amount=20,level=1},
			{name="oldtime", label="OldTimes",type="money",amount=30,level=1},
			{name="russkaya", label="russkaya",type="money",amount=30,level=1},
		},
		Jobs=nil,
		Pos = {
			{x = -559.906,  y = 287.093,   z = 81.176,time = '0-24'},
		}
	},

	ToolShop = {
		Blip = true,
		Sprite = 566,
		Size = 0.9,
		Color = 81,
		Name="Ferreteria",
		Items = {
			{name = 'WEAPON_HATCHET', label = 'weapon', type = 'money', amount = 1350, level = 1},
			{name = 'WEAPON_FLASHLIGHT', label = 'weapon', type = 'money', amount = 140, level = 1},
			{name = 'blowpipe', label = 'Soplete', type = 'money', amount = 13000, level = 35},
			{name = 'fixkit', label = 'Kit de reparacion', type = 'money', amount = 3000, level = 15},
			{name = 'scissors', label = 'Tijeras', type = 'money', amount = 120, level = 1},
		},
		Jobs=nil,
		Pos = {
			{x=-3153.65, y=1054.16, z=19.84, time='8-20' },
			{x=2748.87, y=3472.31, z=54.68, time='8-20' }
		}
	},

	Guns = {
		Blip=true,
		Sprite=110,
		Size=1.0,
		Color=81,
		Name="Armeria",
		Items={
			{name="WEAPON_PISTOL",bullets= 52, label="weapon",type="money",amount=4100, level=10},
			{name="WEAPON_SNSPISTOL",bullets= 52, label="weapon",type="money",amount=2900, level=10},
			{name="WEAPON_KNIFE",bullets= 52, label="weapon",type="money",amount=1050, level=10},
			{name="armour", bullets= 52,label="Chaleco",type="money",amount=38000, level=15},
			{name="clip",bullets= 52, label="Cargador",type="money",amount=400, level=10},
		},
		Jobs=nil,
		Pos={
			{ x = -662.180,   y = -934.961,   z = 20.829, time='10-18'  },
            { x = 810.25,     y = -2157.60,   z = 28.62, time='10-18'  },
            { x = 1693.44,    y = 3760.16,    z = 33.71, time='10-18'  },
            { x = -330.24,    y = 6083.88,    z = 30.45, time='10-18'  },
            { x = 252.63,     y = -50.00,     z = 68.94, time='10-18'  },
            { x = 22.09,      y = -1107.28,   z = 28.80, time='10-18'  },
            { x = 2567.69,    y = 294.38,     z = 107.73, time='10-18'  },
            { x = -1117.58,   y = 2698.61,    z = 17.55 },
            { x = 842.44,     y = -1033.42,   z = 27.19, time='10-18'  },
		}
	},

	Food = {
		Blip=true,
		Sprite=52,   
		Size=0.95,
		Color=46,
		Name="Comida rapida",
		Items = {
			{name="food", label="Jugo de naranja",type="money",typeRefill="thirst",refill=108000,amount=5,level=1},
			{name="food", label="Emoliente",type="money",typeRefill="thirst",refill=198000,amount=7,level=1},
			{name="food", label="Dona",type="money",typeRefill="hunger",refill=125000,amount=8,level=1},
			{name="food", label="Tostado(picarones)",type="money",typeRefill="hunger",refill=132000,amount=10,level=1},
			{name="food", label="Medialuna JyQ",type="money",typeRefill="hunger",refill=178000,amount=15,level=1},
			{name="food", label="Siete colores",type="money",typeRefill="hunger",refill=190000,amount=17,level=1},
			{name="food", label="Hamburguesa triple",type="money",typeRefill="hunger",refill=240000,amount=20,level=1},
			{name="food", label="Chivito canadiense",type="money",typeRefill="hunger",refill=305000,amount=25,level=1},
		},
		Jobs=nil,
		Pos = {
			{x=231.96,y=-896.91,z=29.69, food=true, loaded=false, name="gc",time = '0-24'}, --GC
			{x=1845.23,y=3766.31,z=32.24, food=true, loaded=false, name="sandy",time = '0-24'}, --sandy
			{x=-1173.49,y=-725.26,z=19.75, food=true, loaded=false, name="bahamas",time = '0-24'}, --bahamas
			{x=-35.26,y=-102.46,z=56.43, food=true, loaded=false, name="bank",time = '0-24'}, --banco central
			{x=-271.52,y=6072.3,z=30.46,time = '0-24'}, --paleto
			{x=114.81,y=-1567.82,z=28.6, food=true, loaded=false, name="confis",time = '0-24'}, --confiscados
		}
	},

	Scooter = {
		Blip=false,
		Spritte=1,
		Size=1,
		Color=1,
		Name="Alquiler de vehiculos",
		Items = {
			{name="car", label="Motoneta",type="money",amount=400,level=1},
		},
		Jobs=nil,
		Pos={
			{x=-520.93,y=-262.4,z=34.5}
		},
		Car=true
	}
}

Config.Objects = {
	["gc"]={-- GC
		--Pos={x=224.3908996582, y=-907.43743896484, z=30.692161560059}, 
		Pos={x=233.21,y=-897.87,z=30.69},
		Heading=234.31330871582,
		Prop='prop_food_van_02'
	},
	["sandy"]={-- SANDY
		Pos={x=1846.8946533203,y=3767.2133789062,z=33.176322937012},
		Forward=vector3(0.9065312,0.4221388,0),
		Heading=298.05276489258,
		Prop='prop_food_van_02'
	},
	["bahamas"]={-- BAHAMAS
		Pos={x=-1174.7452392578, y=-724.04913330078, z=20.77770614624},
		Forward=vector3(-0.6941989,0.7197834,0),
		Heading=45.923206329346,
		Prop='prop_food_van_02'
	},-- central
	["bank"]={
		Pos={x=-34.478103637695,y=-100.66858673096,z=57.419258117676},
		Forward=vector3(0.4169402,0.908934,0),
		Heading=336.4399108867,
		Prop='prop_food_van_02'
	},-- confiscados
	["confis"]={
		Pos={x=113.84583282471, y=-1569.4333496094, z=29.602656318115},
		Forward=vector3(-0.641866,-0.7668169,0),
		Heading=142.0061340332,
		Prop='prop_food_van_02'
	}
}
