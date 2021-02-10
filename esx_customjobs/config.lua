Config              = {}
Config.DrawDistance = 60.0
Config.Truck = "trans_mbenzarocs" -- ONLY 1 TRUCK
Config.Trailer = "trans-laso_trailer" -- ONLY 1 TRAILER
Config.nameJob = "works"
Config.nameJobLabel = "Electricista"
Config.Locale = 'es'

--Possible alternative trailer for a vehicle delivery job: "tr4"

Config.Jobs={
	["trucker"]={
		Blip={
			Pos       = {x=153.27,y=-3112.24,z=4.9},
			Colour    = 5, 
			Id        = 477, 
			Title     = "Distribuidor",
		},
		Zones={
			CloakRoom = {
				Pos = {x=153.27,y=-3112.24,z=4.9},
				Size = {x=2.0, y=2.0, z=1.0},
				Color = {r=204,g=204,b=0},
				Duty=false,
				Hint="Presiona ~INPUT_CONTEXT~ para acceder al vestuario",
				Type="cloakroom"
			},
			VehicleSpawner = {
				Pos   = {x=140.8,y=-3096.47,z=4.9},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Duty=true,
				Hint = "Presiona ~INPUT_CONTEXT~ para trabajar",
				Type="vehiclespawner"
			},
			VehicleDeleter = {
				Pos   = {x=141.72,y=-3088.88,z=4.9},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 256, g = 0, b = 0},
				Duty=true,
				Hint = "Presiona ~INPUT_CONTEXT~ para devolver el vehículo",
				Type = "vehicledelete"
			},
		},
		VehicleSpawnPoint = {
			Pos     = {x=140.8,y=-3096.47,z=4.9},
			Size    = {x = 3.0, y = 3.0, z = 1.0},
			Type    = -1,
			Heading = 270.4
		},
		Vehicles={
			[1]={
				hash="benson3"
			}
		},
		DeliveryTime=3500,
		Delivery={
			Delivery1 = {
				Route={
					[1]={x=6.67,y=-1454.4,z=29.4},
					[2]={x=408.35,y=-1793.12,z=27.9},
					[3]={x=477.64,y=-1778.07,z=27.67},
					[4]={x=411.09,y=-1866.01,z=25.81},
					[5]={x=410.72,y=-2074.92,z=20.25},
					[6]={x=346.86,y=-1808.52,z=27.42},
					
				},
				Pos   = {x = 1214.22, y = 2659.63, z = 37.05},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 308,
			} ,
			--Fort Zancudo (Route 68) 3.02KM
			Delivery2 = {
				Route={
					[1]={x=-1104.22,y=-913.35,z=2.02},
					[2]={x=-1406.89,y=-589.89,z=29.43},
					[3]={x=-1662.82,y=-1034.44,z=12.17},
					[4]={x=-1203.92,y=-1185.01,z=6.75},
					[5]={x=-829.85,y=-1218.03,z=6.08},
					[6]={x=-740.78,y=-879.81,z=20.56},
				},
				Pos   = {x = -2531.8655, y = 2344.23, z = 32.27},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment =340,
			},
			Delivery3 = {
				Route={
					[1]={x=-1114.68,y=-1475.92,z=3.7},
					[2]={x=-1133.27,y=-1476.54,z=3.42},
					[3]={x=-1166.04,y=-1361.41,z=3.8},
					[4]={x=-1246.86,y=-1271.72,z=3.23},
					[5]={x=-1435.99,y=-891.99,z=9.81},
					[6]={x=-1299.46,y=-863.63,z=12.8}
					
				},
				Pos   = {x = 1991.3655, y = 3762.47, z = 31.18},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 320,
			},
			--Senora Freeway (right side towards paleto) 5.91KM
			Delivery4 = {
				Route={
					[1]={x=1158.98,y=-1665.31,z=35.66},
					[2]={x=1239.16,y=-1616.55,z=51.05},
					[3]={x=1352.11,y=-1589.24,z=51.52},
					[4]={x=1359.21,y=-1544.31,z=53.74},
					[5]={x=1432.87,y=-1500.04,z=62.16},
					[6]={x=1363.02,y=-1706.69,z=60.71},
					[7]={x=1253.52,y=-1749.28,z=46.7}
					
				},
				Pos      = {x = 1689.95, y = 6418.29, z = 31.73},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 370,
			} ,
			--Paleto Boulevard (At the paleto garage) 7.42KM
			Delivery5 = {
				Route={
					[1]={x=1150.79,y=-998.35,z=44.17},
					[2]={x=1204.77,y=-700.92,z=59.95},
					[3]={x=1272.22,y=-721.28,z=63.44},
					[4]={x=1258.94,y=-578.97,z=68.95},
					[5]={x=772.52,y=221.69,z=84.90},
					[6]={x=942.4,y=-501.92,z=59.0}
					
				},
				Pos   = {},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 380,
			},
			--Senora Freeway (close to YOUTOOL) 3.14KM
			Delivery6 = {
				Route={
					[1]={x=-1371.71,y=-655.91,z=27.33},
					[2]={x=-1420.14,y=-643.11,z=27.67},
					[3]={x=-1449.31; y=-56.05 ;z=51.57},
					[4]={x=-955.96, y=-503.38 ,z=35.86},
					[5]={x=-786.55, y=-806.42 ,z=19.63},
					[6]={x=-221.34, y=-1162.3 ,z=22.03},
					[7]={x=85.16,y=-1439.82,z=28.31}
					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 310,
			},
			Delivery7 = {
				Route={
					[1]={x=-819.83,y=-27.22,z=37.54},
					[2]={x=-904.11,y=18.8,z=45.31},
					[3]={x=-856.4,y=179.07,z=68.22},
					[4]={x=-690.73,y=231.22,z=79.86},
					[5]={x=-820.12,y=280.05,z=85.28},
					[6]={x=-849.94,y=303.99,z=85.15},
					[7]={x=-863.21,y=386.51,z=86.41}
					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 290,
			},
			Delivery8 = {
				Route={
					[1]={x=-804.16,y=429.02,z=90.48},
					[2]={x=-711.19,y=487.47,z=107.61},
					[3]={x=-1222.91,y=662.6,z=143.13},
					[4]={x=-1361.8,y=613.2,z=133.14},
					[5]={x=-1471.89,y=512.7,z=116.81},
					[6]={x=-1796.61,y=477.18,z=132.88},
					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 310,
			},
			Delivery9 = {
				Route={
					[1]={x=-1894.54,y=156.57,z=80.42},
					[2]={x=-1940.67,y=522.52,z=108.23},
					[3]={x=-1983.19,y=601.91,z=117.3},
					[4]={x=-1962.85,y=618.93,z=120.09},
					[5]={x=-1797.26,y=477.19,z=132.89},
					[6]={x=-1408.82,y=538.27,z=121.92},
					[7]={x=-1050.05,y=316.63,z=65.78}
					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 320,
			},
			Delivery10 = {
				Route={
					[1]={x=141.01,y=-304.59,z=44.0},
					[2]={x=-17.41,y=-356.01,z=39.85},
					[3]={x=39.03,y=-136.84,z=54.33},
					[4]={x=152.4,y=-207.15,z=54.16},
					[5]={x=130.05,y=-70.95,z=66.67},
					[6]={x=17.5,y=-6.57,z=69.13},
					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 360,
			},
		}
	},
	["delivery"]={
		Blip={
			Pos       = {x = 814.27, y = -2982.49, z = 5.02},
			Colour    = 5, 
			Id        = 477, 
			Title     = "Camionero",
		},
		Zones={
			CloakRoom = {
				Pos = {x = 814.27, y = -2982.49, z = 5.02},
				Size = {x=2.0, y=2.0, z=1.0},
				Color = {r=204,g=204,b=0},
				Duty=false,
				Hint="Presiona ~INPUT_CONTEXT~ para acceder al vestuario",
				Type="cloakroom"
			},
			VehicleSpawner = {
				Pos   = {x = 828.45, y = -2981.3, z = 4.91},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Duty=true,
				Hint = "Presiona ~INPUT_CONTEXT~ para trabajar",
				Type="vehiclespawner"
			},
			VehicleDeleter = {
				Pos   = {x = 834.16, y = -2981.3, z = 4.91},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 256, g = 0, b = 0},
				Duty=true,
				Hint = "Presiona ~INPUT_CONTEXT~ para devolver el vehículo",
				Type = "vehicledelete"
			},
		},
		VehicleSpawnPoint = {
			Pos   = {x = 828.45, y = -2981.3, z = 4.91},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Type  = -1,
			Heading = 180.12
		},
		Vehicles={
			[1]={
				hash="pounder"
			}
		},
		DeliveryTime=5000,
		Delivery={
			Delivery1 = {
				Route={
					[1]={x = 2574.5144, y = 328.5554, z = 107.45},
					
				},
				Pos   = {x = 1214.22, y = 2659.63, z = 37.05},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 610,
			} ,
			--Fort Zancudo (Route 68) 3.02KM
			Delivery2 = {
				Route={
					[1]={x = -2565.0894, y = 2345.8904, z = 32.06},
				},
				Pos   = {x = -2531.8655, y = 2344.23, z = 32.27},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment =680,
			},
			Delivery3 = {
				Route={
					[1]={x = 1212.4463, y = 2667.4351, z = 36.81},
					
				},
				Pos   = {x = 1991.3655, y = 3762.47, z = 31.18},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 620,
			},
			--Senora Freeway (right side towards paleto) 5.91KM
			Delivery4 = {
				Route={
					[1]={x = 1693.57, y = 4940.73, z = 41.23},		
				},
				Pos      = {x = 1689.95, y = 6418.29, z = 31.73},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 720,
			} ,
			--Paleto Boulevard (At the paleto garage) 7.42KM
			Delivery5 = {
				Route={
					[1]={x = 146.29, y = 6602.85, z = 30.86},
					
				},
				Pos   = {},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 800,
			},
			--Senora Freeway (close to YOUTOOL) 3.14KM
			Delivery6 = {
				Route={
					[1]={x = 68.42, y = 96.07, z = 78.00},
					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 530,
			},
			Delivery7 = {
				Route={
					[1]={x = 2215.14, y = 5596.97, z = 53.00},
					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 750,
			},
			Delivery8 = {
				Route={
					[1]={x = 1834.75, y = 3663.76, z = 32.74},
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 680,
			},
			Delivery9 = {
				Route={
					[1]={x = 1964.88, y = 3698.59, z = 31.36},
					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 690,
			},
			Delivery10 = {
				Route={
					[1]={x = -1372.84, y = -651.14, z = 27.67},					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 490,
			},
			Delivery11 = {
				Route={
					[1]={x = -1660.53, y = -204.98, z = 54.34},					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 570,
			},
			Delivery12 = {
				Route={
					[1]={x = -1398.68, y = -84.25, z = 51.73},					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 550,
			},
			Delivery13 = {
				Route={
					[1]={x = -127.76, y = 1930.9, z = 195.64},					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 630,
			},
			Delivery14 = {
				Route={
					[1]={x = 1846.15, y = 2542.49, z = 44.67},					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 600,
			},
			Delivery15 = {
				Route={
					[1]={x = -452.83, y = 2865.28, z = 34.65},					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 750,
			},
			Delivery16 = {
				Route={
					[1]={x = 2695.92, y = 3448.14, z = 54.8},					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 680,
			},
			Delivery17 = {
				Route={
					[1]={x=-3170.95,y=1102.7,z=19.7},					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 660,
			},
			Delivery18 = {
				Route={
					[1]={x=2568.43,y=414.94,z=107.46},					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 620,
			},
			Delivery19 = {
				Route={
					[1]={x=2453.83,y=-367.38,z=91.99},					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 580,
			},
			Delivery20 = {
				Route={
					[1]={x=-2174.28,y=4270.48,z=47.96},					
				},
				Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
				Size  = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Type  = 1,
				Payment  = 700,
			},

		}
	}
}
Config.Blip={
	Pos       = {x=153.27,y=-3112.24,z=4.9},
	Colour    = 5, 
	Id        = 477, 
	Title     = "Distribuidor",
}

Config.Zones = {
	--This is the job start point
	CloakRoom = {
	  	Pos = {x=153.27,y=-3112.24,z=4.9},
		Size = {x=2.0, y=2.0, z=1.0},
		Color = {r=204,g=204,b=0},
		Duty=false,
		Hint="Presiona ~INPUT_CONTEXT~ para acceder al vestuario",
		Type="cloakroom"
	},
	VehicleSpawner = {
		Pos   = {x=140.8,y=-3096.47,z=4.9},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Duty=true,
		Hint = "Presiona ~INPUT_CONTEXT~ para trabajar",
		Type="vehiclespawner"
	},
	
	--Here you can cancel the job
	VehicleDeleter = {
		Pos   = {x=141.72,y=-3088.88,z=4.9},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 256, g = 0, b = 0},
		Duty=true,
		Hint = "Presiona ~INPUT_CONTEXT~ para devolver el camion",
		Type = "vehicledelete"
	},
}

--The truck spawns here
Config.VehicleSpawnPoint = {
      Pos   = {x=140.8,y=-3096.47,z=4.9},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Type  = -1,
}

Config.Vehicles = {
	Truck = {
		Spawner = 1,
		Label = 'Camión de servicio',
		Hash = "boxville",
		Livery = 0,
		Trailer = "none",
	}	
}

Config.Zones2 = {

  Cloakroom = {
    Pos     = {x=2473.99, y=-332.03,z=91.99},
    Size    = {x = 2.5, y = 2.5, z = 1.0},
    Color   = {r = 204, g = 204, b = 0},
    Type    = 1,
	BlipSprite = 354,
	BlipColor = 46,
	BlipName = Config.nameJobLabel.." : Central de trabajo",
	hint = 'Presiona ~INPUT_CONTEXT~ para acceder al vestuario',
  },

  VehicleSpawner = {
	Pos   = {x=2496.94,y=-338.37,z=91.99},
	Size  = {x = 3.0, y = 3.0, z = 1.0},
	Color = {r = 204, g = 204, b = 0},
	Type  = 1,
	--BlipName = Config.nameJobLabel.." : Vehicle",
	hint = 'Presiona ~INPUT_CONTEXT~ para seleccionar un vehículo',
  },

  VehicleSpawnPoint = {
	Pos   = {x=2498.19,y=-328.93,z=92.99},
	Size  = {x = 3.0, y = 3.0, z = 1.0},
	Type  = -1,
	Heading = 20.51,
  },

  VehicleDeleter = {
	Pos   = {x = 2503.7, y = -338.37,z=91.99},
	Size  = {x = 4.0, y = 4.0, z = 1.0},
	Color = {r = 255, g = 0, b = 0},
	Type  = 1,
	BlipSprite = 354,
	BlipColor = 46,
	BlipName = Config.nameJobLabel.." : Vehículos",
	hint = 'Presiona ~INPUT_CONTEXT~ para regresar el vehículo',
  },
}

Config.Delivery = {
	Delivery1 = {
		Route={
			[1]={x=6.67,y=-1454.4,z=29.4},
			[2]={x=408.35,y=-1793.12,z=27.9},
			[3]={x=477.64,y=-1778.07,z=27.67},
			[4]={x=411.09,y=-1866.01,z=25.81},
			[5]={x=410.72,y=-2074.92,z=20.25},
			[6]={x=346.86,y=-1808.52,z=27.42},
			
		},
		Pos   = {x = 1214.22, y = 2659.63, z = 37.05},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 308,
	} ,
	--Fort Zancudo (Route 68) 3.02KM
	Delivery2 = {
		Route={
			[1]={x=-1104.22,y=-913.35,z=2.02},
			[2]={x=-1406.89,y=-589.89,z=29.43},
			[3]={x=-1662.82,y=-1034.44,z=12.17},
			[4]={x=-1203.92,y=-1185.01,z=6.75},
			[5]={x=-829.85,y=-1218.03,z=6.08},
			[6]={x=-740.78,y=-879.81,z=20.56},
		},
		Pos   = {x = -2531.8655, y = 2344.23, z = 32.27},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment =340,
	},
	Delivery3 = {
		Route={
			[1]={x=-1114.68,y=-1475.92,z=3.7},
			[2]={x=-1133.27,y=-1476.54,z=3.42},
			[3]={x=-1166.04,y=-1361.41,z=3.8},
			[4]={x=-1246.86,y=-1271.72,z=3.23},
			[5]={x=-1435.99,y=-891.99,z=9.81},
			[6]={x=-1299.46,y=-863.63,z=12.8}
			
		},
		Pos   = {x = 1991.3655, y = 3762.47, z = 31.18},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 320,
	},
	--Senora Freeway (right side towards paleto) 5.91KM
	Delivery4 = {
		Route={
			[1]={x=1158.98,y=-1665.31,z=35.66},
			[2]={x=1239.16,y=-1616.55,z=51.05},
			[3]={x=1352.11,y=-1589.24,z=51.52},
			[4]={x=1359.21,y=-1544.31,z=53.74},
			[5]={x=1432.87,y=-1500.04,z=62.16},
			[6]={x=1363.02,y=-1706.69,z=60.71},
			[7]={x=1253.52,y=-1749.28,z=46.7}
			
		},
		Pos      = {x = 1689.95, y = 6418.29, z = 31.73},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 370,
	} ,
	--Paleto Boulevard (At the paleto garage) 7.42KM
	Delivery5 = {
		Route={
			[1]={x=1150.79,y=-998.35,z=44.17},
			[2]={x=1204.77,y=-700.92,z=59.95},
			[3]={x=1272.22,y=-721.28,z=63.44},
			[4]={x=1258.94,y=-578.97,z=68.95},
			[5]={x=772.52,y=221.69,z=84.90},
			[6]={x=942.4,y=-501.92,z=59.0}
			
		},
		Pos   = {},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 380,
	},
	--Senora Freeway (close to YOUTOOL) 3.14KM
	Delivery6 = {
		Route={
			[1]={x=-1371.71,y=-655.91,z=27.33},
			[2]={x=-1420.14,y=-643.11,z=27.67},
			[3]={x=-1449.31; y=-56.05 ;z=51.57},
			[4]={x=-955.96, y=-503.38 ,z=35.86},
			[5]={x=-786.55, y=-806.42 ,z=19.63},
			[6]={x=-221.34, y=-1162.3 ,z=22.03},
			[7]={x=85.16,y=-1439.82,z=28.31}
			
		},
		Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 310,
	},
	Delivery7 = {
		Route={
			[1]={x=-819.83,y=-27.22,z=37.54},
			[2]={x=-904.11,y=18.8,z=45.31},
			[3]={x=-856.4,y=179.07,z=68.22},
			[4]={x=-690.73,y=231.22,z=79.86},
			[5]={x=-820.12,y=280.05,z=85.28},
			[6]={x=-849.94,y=303.99,z=85.15},
			[7]={x=-863.21,y=386.51,z=86.41}
			
		},
		Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 290,
	},
	Delivery8 = {
		Route={
			[1]={x=-804.16,y=429.02,z=90.48},
			[2]={x=-711.19,y=487.47,z=107.61},
			[3]={x=-1222.91,y=662.6,z=143.13},
			[4]={x=-1361.8,y=613.2,z=133.14},
			[5]={x=-1471.89,y=512.7,z=116.81},
			[6]={x=-1796.61,y=477.18,z=132.88},
			
		},
		Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 310,
	},
	Delivery9 = {
		Route={
			[1]={x=-1894.54,y=156.57,z=80.42},
			[2]={x=-1940.67,y=522.52,z=108.23},
			[3]={x=-1983.19,y=601.91,z=117.3},
			[4]={x=-1962.85,y=618.93,z=120.09},
			[5]={x=-1797.26,y=477.19,z=132.89},
			[6]={x=-1408.82,y=538.27,z=121.92},
			[7]={x=-1050.05,y=316.63,z=65.78}
			
		},
		Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 320,
	},
		Delivery10 = {
		Route={
			[1]={x=141.01,y=-304.59,z=44.0},
			[2]={x=-17.41,y=-356.01,z=39.85},
			[3]={x=39.03,y=-136.84,z=54.33},
			[4]={x=152.4,y=-207.15,z=54.16},
			[5]={x=130.05,y=-70.95,z=66.67},
			[6]={x=17.5,y=-6.57,z=69.13},
			
		},
		Pos      = {x = 2654.40, y = 3264.30, z = 54.47},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 360,
	},
	
	--[[###Between Blaine County and Los Santos###
	--Banham Canyon (Somewhere above Kortz Center) 3.72KM
	Delivery7 = {
		Pos      = {x = -1819.87, y = 806.18, z = 137.92},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 1200,
	},
	--Palomino Freeway (Right side of the map, that bigger center with multiple shops in the middle of the highway) 5.44KM
	Delivery8 = {
		Pos      = {x = 2549.72, y = 343.02, z = 107.70},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 1300,
	},
	
	--###Los Santos###
	--Entering (Close to Vinewood Bowl) 3.64KM
	Delivery9 = {
		Pos      = {x = 630.39, y = 249.15, z = 102.34},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 2400,
	},
	--Mirror Park 4.24KM
	Delivery10 = {
		Pos      = {x = 1172.43, y = -315.52, z = 68.41},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 1500,
	},
	--Close to LSPD 4.94KM
	Delivery11 = {
		Pos      = {x = 826.12, y = -1044.24, z = 26.38},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 1900,
	},
	--Del Perro Freeway (Close to the beach, leaving city) 5.76KM
	Delivery12 = {
		Pos      = {x = -2080.37, y = -306.59, z = 12.30},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 10000,
	},
	--Ginger Street (Close to store and Ammunation) 5.40KM
	Delivery13 = {
		Pos      = {x = -727.42, y = -912.37, z = 18.25},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 1500,
	},
	--Calais Ave & Innocence Blvd (Close to heli pad and dock) 5.78KM
	Delivery14 = {
		Pos      = {x = -517.79, y = -1214.73, z = 17.47},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 2350,
	},
	--Strawberry Ave (Close to Vanilla Unicorn and Legion Square) 5.31KM
	Delivery15 = {
		Pos      = {x = 294.55, y = -1247.08, z = 28.52},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 2500,
	},
	--Groove Street 5.71KM
	Delivery16 = {
		Pos      = {x = -63.73, y = -1774.58, z = 28.14},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = 3500,
	}, ]]
}

Config.Pool = {
  --{ [ 'x' ] = 	 738.48	, [ 'y' ] = 	6489.67	, [ 'z' ] = 	26.66	},
--{ [ 'x' ] = 	 1304.29	, [ 'y' ] = 	6508.83	, [ 'z' ] = 	20.05	},
--{ [ 'x' ] = 	 2501.19	, [ 'y' ] = 	5458.68	, [ 'z' ] = 	44.53	},
--{ [ 'x' ] = 	 2585.95	, [ 'y' ] = 	5065.64	, [ 'z' ] = 	44.92	},
--{ [ 'x' ] = 	 2836.66	, [ 'y' ] = 	4196.10	, [ 'z' ] = 	50.17	},
--{ [ 'x' ] = 	 2858.91	, [ 'y' ] = 	3709.94	, [ 'z' ] = 	48.42	},
--{ [ 'x' ] = 	 2517.14	, [ 'y' ] = 	3027.60	, [ 'z' ] = 	42.26	},
--{ [ 'x' ] = 	 1719.09	, [ 'y' ] = 	1691.41	, [ 'z' ] = 	81.03	},
{ [ 'x' ] = 	 1076.30	, [ 'y' ] = 	423.74	, [ 'z' ] = 	91.53	},
{ [ 'x' ] = 	 1151.32	, [ 'y' ] = 	383.38	, [ 'z' ] = 	91.41	},
{ [ 'x' ] = 	 274.71	, [ 'y' ] = 	-838.78	, [ 'z' ] = 	29.24	},
{ [ 'x' ] = 	 304.90	, [ 'y' ] = 	-869.71	, [ 'z' ] = 	29.29	},
{ [ 'x' ] = 	 100.93	, [ 'y' ] = 	-969.27	, [ 'z' ] = 	29.37	},
{ [ 'x' ] = 	 -172.42	, [ 'y' ] = 	-914.07	, [ 'z' ] = 	29.30	},
{ [ 'x' ] = 	 -289.49	, [ 'y' ] = 	-1157.72	, [ 'z' ] = 	23.02	},
{ [ 'x' ] = 	 -345.84	, [ 'y' ] = 	-1491.37	, [ 'z' ] = 	30.79	},
{ [ 'x' ] = 	 -415.40	, [ 'y' ] = 	-1781.36	, [ 'z' ] = 	21.27	},
{ [ 'x' ] = 	 -360.67	, [ 'y' ] = 	-1857.71	, [ 'z' ] = 	20.54	},
{ [ 'x' ] = 	 -114.79	, [ 'y' ] = 	-1554.54	, [ 'z' ] = 	33.90	},
{ [ 'x' ] = 	 -36.22	, [ 'y' ] = 	-1576.17	, [ 'z' ] = 	29.29	},
{ [ 'x' ] = 	 -71.57	, [ 'y' ] = 	-1802.43	, [ 'z' ] = 	27.77	},
{ [ 'x' ] = 	 99.75	, [ 'y' ] = 	-1924.24	, [ 'z' ] = 	20.74	},
{ [ 'x' ] = 	 334.79	, [ 'y' ] = 	-1932.80	, [ 'z' ] = 	24.71	},
{ [ 'x' ] = 	 355.73	, [ 'y' ] = 	-2171.11	, [ 'z' ] = 	14.07	},
{ [ 'x' ] = 	 -776.03	, [ 'y' ] = 	-1698.30	, [ 'z' ] = 	29.26	},
{ [ 'x' ] = 	 -904.76	, [ 'y' ] = 	-1781.51	, [ 'z' ] = 	37.37	},
{ [ 'x' ] = 	 -469.08	, [ 'y' ] = 	-2302.44	, [ 'z' ] = 	63.11	},
{ [ 'x' ] = 	 193.46	, [ 'y' ] = 	-3194.00	, [ 'z' ] = 	5.79	},
{ [ 'x' ] = 	 305.07	, [ 'y' ] = 	-3115.05	, [ 'z' ] = 	5.85	},
{ [ 'x' ] = 	 371.47	, [ 'y' ] = 	-2487.27	, [ 'z' ] = 	6.09	},
{ [ 'x' ] = 	 1019.09	, [ 'y' ] = 	-2266.90	, [ 'z' ] = 	30.51	},
{ [ 'x' ] = 	 1452.70	, [ 'y' ] = 	-1893.86	, [ 'z' ] = 	90.91	},
{ [ 'x' ] = 	 1471.78	, [ 'y' ] = 	-1755.72	, [ 'z' ] = 	69.08	},
{ [ 'x' ] = 	 1226.93	, [ 'y' ] = 	-1488.12	, [ 'z' ] = 	35.03	},
{ [ 'x' ] = 	 1244.40	, [ 'y' ] = 	-1475.49	, [ 'z' ] = 	34.90	},
{ [ 'x' ] = 	 1092.56	, [ 'y' ] = 	-794.64	, [ 'z' ] = 	58.27	},
{ [ 'x' ] = 	 830.22	, [ 'y' ] = 	-566.65	, [ 'z' ] = 	57.71	},
{ [ 'x' ] = 	 1167.46	, [ 'y' ] = 	-321.40	, [ 'z' ] = 	69.29	},
--{ [ 'x' ] = 	 1917.62	, [ 'y' ] = 	585.99	, [ 'z' ] = 	178.37	},
{ [ 'x' ] = 	 778.55	, [ 'y' ] = 	-390.47	, [ 'z' ] = 	33.37	},
{ [ 'x' ] = 	 22.60	, [ 'y' ] = 	270.32	, [ 'z' ] = 	109.55	},
{ [ 'x' ] = 	 -1673.20	, [ 'y' ] = 	-264.09	, [ 'z' ] = 	51.88	},
{ [ 'x' ] = 	 -1705.91	, [ 'y' ] = 	-559.74	, [ 'z' ] = 	36.65	},
{ [ 'x' ] = 	 -1661.65	, [ 'y' ] = 	-1146.25	, [ 'z' ] = 	13.02	},
{ [ 'x' ] = 	 -960.59	, [ 'y' ] = 	-3059.56	, [ 'z' ] = 	13.94	},
{ [ 'x' ] = 	 -1222.60	, [ 'y' ] = 	-1182.44	, [ 'z' ] = 	7.72	},
{ [ 'x' ] = 	 -916.12	, [ 'y' ] = 	-1523.36	, [ 'z' ] = 	5.03	},
{ [ 'x' ] = 	 -943.56	, [ 'y' ] = 	-708.14	, [ 'z' ] = 	19.91	},
{ [ 'x' ] = 	 -698.33	, [ 'y' ] = 	-917.51	, [ 'z' ] = 	19.21	},
{ [ 'x' ] = 	 121.07	, [ 'y' ] = 	-1020.88	, [ 'z' ] = 	29.36	},
{ [ 'x' ] = 	 197.70	, [ 'y' ] = 	-586.80	, [ 'z' ] = 	29.52	},
{ [ 'x' ] = 	 -2064.52	, [ 'y' ] = 	-312.61	, [ 'z' ] = 	13.26	},
{ [ 'x' ] = 	 -3011.40	, [ 'y' ] = 	234.31	, [ 'z' ] = 	16.32	},
{ [ 'x' ] = 	 -3067.57	, [ 'y' ] = 	784.82	, [ 'z' ] = 	21.36	},
{ [ 'x' ] = 	 -3195.12	, [ 'y' ] = 	949.41	, [ 'z' ] = 	16.59	},
--{ [ 'x' ] = 	 -2520.74	, [ 'y' ] = 	2307.97	, [ 'z' ] = 	33.21	},
--{ [ 'x' ] = 	 2053.09	, [ 'y' ] = 	3689.79	, [ 'z' ] = 	34.59	},
--{ [ 'x' ] = 	 2295.99	, [ 'y' ] = 	2943.90	, [ 'z' ] = 	46.58	},
--{ [ 'x' ] = 	 2269.45	, [ 'y' ] = 	3756.33	, [ 'z' ] = 	38.42	},
--{ [ 'x' ] = 	 1717.32	, [ 'y' ] = 	4822.47	, [ 'z' ] = 	41.34	},
--{ [ 'x' ] = 	 2226.90	, [ 'y' ] = 	4957.15	, [ 'z' ] = 	41.46	},
--{ [ 'x' ] = 	 1713.54	, [ 'y' ] = 	6426.50	, [ 'z' ] = 	32.77	},
--{ [ 'x' ] = 	 9.27	, [ 'y' ] = 	6221.19	, [ 'z' ] = 	31.47	},
--{ [ 'x' ] = 	 -292.75	, [ 'y' ] = 	6023.74	, [ 'z' ] = 	31.53	},
--{ [ 'x' ] = 	 -254.59	, [ 'y' ] = 	6478.92	, [ 'z' ] = 	11.42	},
--{ [ 'x' ] = 	 -366.16	, [ 'y' ] = 	6691.01	, [ 'z' ] = 	3.45	},
--{ [ 'x' ] = 	 189.04	, [ 'y' ] = 	6624.92	, [ 'z' ] = 	31.81	},
--{ [ 'x' ] = 	 2622.84	, [ 'y' ] = 	1957.90	, [ 'z' ] = 	29.79	},
--{ [ 'x' ] = 	 2462.96	, [ 'y' ] = 	1481.91	, [ 'z' ] = 	36.20	},
{ [ 'x' ] = 	 2553.96	, [ 'y' ] = 	90.32	, [ 'z' ] = 	111.88	},
{ [ 'x' ] = 	 1789.11	, [ 'y' ] = 	-822.89	, [ 'z' ] = 	74.34	},
{ [ 'x' ] = 	 -82.72	, [ 'y' ] = 	-535.78	, [ 'z' ] = 	40.40	},
{ [ 'x' ] = 	 -1355.97	, [ 'y' ] = 	117.83	, [ 'z' ] = 	56.26	},
--{ [ 'x' ] = 	 790.78	, [ 'y' ] = 	1269.96	, [ 'z' ] = 	360.30	}, zona faccion
--{ [ 'x' ] = 	 760.05	, [ 'y' ] = 	1280.54	, [ 'z' ] = 	360.30	}, zona faccion
--{ [ 'x' ] = 	 661.19	, [ 'y' ] = 	1283.88	, [ 'z' ] = 	360.30	}, zona faccion
{ [ 'x' ] = 	 -2232.35	, [ 'y' ] = 	-361.99	, [ 'z' ] = 	13.31	},
{ [ 'x' ] = 	 -1144.74	, [ 'y' ] = 	-511.52	, [ 'z' ] = 	33.65	},
{ [ 'x' ] = 	 -1509.44	, [ 'y' ] = 	-563.27	, [ 'z' ] = 	33.02	},
{ [ 'x' ] = 	 -1182.22	, [ 'y' ] = 	-904.37	, [ 'z' ] = 	13.46	},
{ [ 'x' ] = 	 1100.28	, [ 'y' ] = 	-1288.20	, [ 'z' ] = 	23.32	},
{ [ 'x' ] = 	 1569.03	, [ 'y' ] = 	855.00	, [ 'z' ] = 	77.48	},
--{ [ 'x' ] = 	 399.44	, [ 'y' ] = 	2628.99	, [ 'z' ] = 	44.50	},
--{ [ 'x' ] = 	 604.59	, [ 'y' ] = 	2784.48	, [ 'z' ] = 	42.22	},
--{ [ 'x' ] = 	 699.34	, [ 'y' ] = 	3116.41	, [ 'z' ] = 	44.16	},
--{ [ 'x' ] = 	 1182.14	, [ 'y' ] = 	3265.08	, [ 'z' ] = 	39.43	},
--{ [ 'x' ] = 	 -1932.09	, [ 'y' ] = 	2038.77	, [ 'z' ] = 	140.83	},
{ [ 'x' ] = 	 -1199.56	, [ 'y' ] = 	-3501.91	, [ 'z' ] = 	14.00	},
{ [ 'x' ] = 	 -1445.40	, [ 'y' ] = 	-3310.26	, [ 'z' ] = 	13.94	},
{ [ 'x' ] = 	 -1744.13	, [ 'y' ] = 	-2785.27	, [ 'z' ] = 	13.94	},
{ [ 'x' ] = 	 364.19	, [ 'y' ] = 	-763.14	, [ 'z' ] = 	29.27	}, --por GC
{ [ 'x' ] = 	 346.38	, [ 'y' ] = 	-560.82	, [ 'z' ] = 	28.74	}, --hosp
{ [ 'x' ] = 	 666.58	, [ 'y' ] = 	1212.77	, [ 'z' ] = 	344.31	}, --facción xd
--{ [ 'x' ] = 	 730.69	, [ 'y' ] = 	2534.22	, [ 'z' ] = 	73.22	},
--{ [ 'x' ] = 	 3604.94	, [ 'y' ] = 	3636.08	, [ 'z' ] = 	41.34	},
--{ [ 'x' ] = 	 2998.59	, [ 'y' ] = 	4098.67	, [ 'z' ] = 	56.98	},
--{ [ 'x' ] = 	 2943.66	, [ 'y' ] = 	4632.41	, [ 'z' ] = 	48.72	},
--{ [ 'x' ] = 	 2872.57	, [ 'y' ] = 	4869.52	, [ 'z' ] = 	62.32	},
--{ [ 'x' ] = 	 -165.08	, [ 'y' ] = 	6446.54	, [ 'z' ] = 	31.92	},
--{ [ 'x' ] = 	 -777.80	, [ 'y' ] = 	5593.62	, [ 'z' ] = 	33.63	},
--{ [ 'x' ] = 	 337.87	, [ 'y' ] = 	3402.43	, [ 'z' ] = 	36.48	},
--{ [ 'x' ] = 	 -2379.49	, [ 'y' ] = 	2712.15	, [ 'z' ] = 	3.42	},


}

for i=1, #Config.Pool, 1 do

    Config.Zones2['Pool' .. i] = {
        Pos   = Config.Pool[i],
        Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 204, g = 204, b = 0},
        Type  = -1
    }

end

Config.Uniforms = {
    job_wear = {
        male = {
            ['tshirt_1'] = 129,
            ['tshirt_2'] = 0,
            ['torso_1'] = 95,
            ['torso_2'] = 1,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 37,
            ['pants_1'] = 9,
            ['pants_2'] = 0,
            ['shoes_1'] = 27,
            ['shoes_2'] = 0,
            ['helmet_1'] = 59,
            ['helmet_2'] = 8,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['ears_1'] = 0,
            ['ears_2'] = 0
        },
        female = {
            ['tshirt_1'] = 36,
            ['tshirt_2'] = 0,
            ['torso_1'] = 49,
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 33,
            ['pants_1'] = 45,
            ['pants_2'] = 2,
            ['shoes_1'] = 52,
            ['shoes_2'] = 0,
            ['helmet_1'] = 54,
            ['helmet_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['glasses_1'] = 5,
            ['glasses_2'] = 0,
            ['ears_1'] = 0,
            ['ears_2'] = 0
        }
    }
}

Config.SecurityPeds={
	{x=130.14,y=-1298.43,z=28.23, heading= 207.87},
}

Config['PoleDance'] = { -- allows you to pole dance at the strip club, you can of course add more locations if you want.
    ['Enabled'] = true,
    ['Locations'] = {
        {['Position'] = vector3(112.60, -1286.76, 28.56), ['Number'] = '3'},
        {['Position'] = vector3(104.18, -1293.94, 29.26), ['Number'] = '1'},
        {['Position'] = vector3(102.24, -1290.54, 29.26), ['Number'] = '2'}
    }
}

Config['Synced'] = {
        -- NSFW animations vvvvvvvv
        {
            ['Label'] = 'Give blowjob (standing)',
            ['RequesterLabel'] = 'darte una mamada',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'pimpsex_hooker', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.0,
                    ['yP'] = 0.65,
                    ['zP'] = 0.0,
    
                    ['xR'] = 120.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'pimpsex_punter', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = 'Get fucked (standing)',
            ['RequesterLabel'] = 'follar',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'shagloop_hooker', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 0.4,
                    ['zP'] = 0.0,
    
                    ['xR'] = 120.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'shagloop_pimp', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = 'Anal (standing)', 
            ['RequesterLabel'] = 'tener sexo anal',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'rcmpaparazzo_2', ['Anim'] = 'shag_loop_a', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'rcmpaparazzo_2', ['Anim'] = 'shag_loop_poppy', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.015,
                    ['yP'] = 0.35,
                    ['zP'] = 0.0,
    
                    ['xR'] = 0.9,
                    ['yR'] = 0.3,
                    ['zR'] = 0.0,
                },
            },
        },
        {
            ['Label'] = "Have sex (fuck) (driver's seat)", 
            ['RequesterLabel'] = 'tener sexo en el carro',
            ['Car'] = true,
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@assassinate@vice@sex', ['Anim'] = 'frontseat_carsex_loop_m', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@assassinate@vice@sex', ['Anim'] = 'frontseat_carsex_loop_f', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = "Have sex (get fucked) (driver's seat)", 
            ['RequesterLabel'] = 'tener sexo en el auto',
            ['Car'] = true,
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'random@drunk_driver_2', ['Anim'] = 'cardrunksex_loop_f', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'random@drunk_driver_2', ['Anim'] = 'cardrunksex_loop_m', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = "Recieve blowjob (driver's seat)", 
            ['RequesterLabel'] = 'give blowjob to',
            ['Car'] = true,
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@towing', ['Anim'] = 'm_blow_job_loop', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@towing', ['Anim'] = 'f_blow_job_loop', ['Flags'] = 1,
            },
        },
        -- NSFW animations ^^^^^^^
}

GarbageConfig              = {}
GarbageConfig.DrawDistance = 50.0
GarbageConfig.MaxDelivery	= 7
GarbageConfig.TruckPrice	= 120       
GarbageConfig.Locale       = 'en'   -- Traduções disponiveis: br/en.
GarbageConfig.BagPay       = 25     -- Pague por sacola puxada do lixo.
GarbageConfig.MulitplyBags = false   -- Multiplica BagPay pelo número de trabalhadores | 4 máximo.

GarbageConfig.Trucks = {
	"trash",
	"trash2",
	--"biff",  -- Veículo está fora...
	--"scrap"
}

GarbageConfig.Cloakroom = {
	CloakRoom = {
			Pos   = {x = -321.70, y = -1545.94, z = 30.02},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1
		},
}

GarbageConfig.Zones = {
	VehicleSpawner = {
			Pos   = {x = -316.16, y = -1536.08, z = 26.65},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1
		},

	VehicleSpawnPoint = {
			Pos   = {x = -328.50, y = -1520.99, z = 27.53},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Type  = -1
		},
}
GarbageConfig.DumpstersAvaialbe = {
  "prop_dumpster_01a",
  "prop_dumpster_02a",
	"prop_dumpster_02b",
	"prop_dumpster_3a",
	"prop_dumpster_4a",
	"prop_dumpster_4b",
	"prop_skip_01a",
	"prop_skip_02a",
	"prop_skip_06a",
	"prop_skip_05a",
	"prop_skip_03",
	"prop_skip_10a"
}


GarbageConfig.Livraison = {
-- Los Santos
	-- fleeca
	Delivery1LS = {
			Pos   = {x = 114.83280181885, y = -1462.3127441406, z = 28.295083999634},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 150
		},
	-- fleeca2
	Delivery2LS = {
			Pos   = {x = -6.0481648445129, y = -1566.2338867188, z = 28.209197998047},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 170
		},
	-- blainecounty
	Delivery3LS = {
			Pos   = {x = -1.8858588933945, y = -1729.5538330078, z = 28.300233840942},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 160
		},
	-- PrincipalBank
	Delivery4LS = {
			Pos   = {x = 159.09, y = -1816.69, z = 27.3},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 200
		},
	-- route68e
	Delivery5LS = {
			Pos   = {x = 358.94696044922, y = -1805.0723876953, z = 28.966590881348},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 140
		},
	--littleseoul
	Delivery6LS = {
			Pos   = {x = 481.36560058594, y = -1274.8297119141, z = 28.64475440979},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 130
		},
	--grovestreetgas
	Delivery7LS = {
			Pos   = {x = 254.70010375977, y = -985.32482910156, z = 28.196590423584},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 120
		},
	--fleecacarpark
	Delivery8LS = {
			Pos   = {x = 240.08079528809, y = -826.91204833984, z = 28.018426895142},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 150
		},
	--Mt Haan Dr Radio Tower
	Delivery9LS = {
			Pos   = {x = 342.78308105469, y = -1036.4720458984, z = 28.194206237793},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 190
		},
	--Senora Way Fuel Depot
	Delivery10LS = {
			Pos   = {x = 462.17517089844, y = -949.51434326172, z = 26.94},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 150
		},
-- 2nd Patrol
	-- Palomino Noose HQ
	Delivery1BC = {
			Pos   = {x = 317.53698730469, y = -737.95416259766, z = 27.278547286987},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 200
		},
	-- El Burro Oil plain
	Delivery2BC = {
			Pos   = {x = 410.22503662109, y = -795.30517578125, z = 28.22},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 120
		},
	-- Orchardville ave
	Delivery3BC = {
			Pos   = {x = 398.36038208008, y = -716.35577392578, z = 27.29},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 130
		},
	-- Elysian Fields
	Delivery4BC = {
			Pos   = {x = 443.96984863281, y = -574.33978271484, z = 27.49},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 140
		},

		-- Carson Ave
	Delivery5BC = {
		Pos   = {x = -1332.53, y = -1198.49, z = 3.9},
		Color = {r = 204, g = 204, b = 0},
		Size  = {x = 5.0, y = 5.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Paye = 190
	},


	-- Carson Ave
	Delivery6BC = {
			Pos   = {x = -45.443946838379, y = -191.32261657715, z = 51.59},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 210
		},
	-- Dutch London
	Delivery7BC = {
			Pos   = {x = -31.948055267334, y = -93.437454223633, z = 56.249073028564},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 140
		},
	-- Autopia Pkwy
	Delivery8BC = {
			Pos   = {x = 283.10873413086, y = -164.81878662109, z = 58.10},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 160
		},
	-- Miriam Turner Overpass
	Delivery9BC = {
			Pos   = {x = 455.46835327148, y = -66.485572814941, z = 73.154975891113},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 150
		},
	-- Exceptionalist Way
	Delivery10BC = {
			Pos   = {x = 441.89678955078, y = 125.97653198242, z = 98.887702941895},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 155
		},

	RetourCamion = {
			Pos   = {x = -335.26095581055, y = -1529.5614013672, z = 24.565467834473},
			Color = {r = 255, g = 0, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Type  = 1,
			Paye = 0
		},

	AnnulerMission = {
			Pos   = {x = -314.62796020508, y = -1514.5662841797, z = 24.677434921265},
			Color = {r = 255, g = 0, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Type  = 1,
			Paye = 0
		},
}
