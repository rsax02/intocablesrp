Config = {}
Config.Size         = {x = 2.0, y = 2.0, z = 1.0}
Config.Color        = {r = 255, g = 255, b = 0}
Config.Type         = 1

vector3(-125.74, -638.83, 168.82)
Config.Factions = {
    ["arcadius"]={
        Label="Arcadius",
        Blip={
            Coords=vector3(-107.14, -609.82, 36.05),
			Sprite  = 269,
			Display = 4,
			Scale   = 1.2,
			Colour  = 40,
            Radius  = nil
        },
        Zones={
            ["armory"]={x=-128.19, y=-632.53, z=167.82,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder a la armeria",            
                        color={r = 255, g = 255, b = 0}
            },
            ["boss"]={x=-125.74, y=-638.83, z=167.82,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder al menu de jefe",
                        color = {r = 255, g = 255, b = 0}
            },
            ["vehicles"]={x=-109.71,y=-618.14,z=35.06,
                        grade=1,
                        hint=("Presiona ~INPUT_CONTEXT~ para acceder al garage"),
                        color = {r = 255, g = 255, b = 0}            
            },
            ["uniform"]={x=-132.49, y=-634.78, z=167.82,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para cambiar el vestuario",
                        color={r = 255, g = 255, b = 0}            
            },
        },
        Vehicles={
            {label="Seven 70",spawn="seven70"},
            {label="Dubsta 2",spawn="dubsta2"},
            {label="Baller 4",spawn="baller4"},
            {label="Schafter 6",spawn="schafter6"},
        },
        VehicleSpawner={x=-108.09,y=-619.93,z=35.07,heading=159.56},
        Uniforms={
            ["vest1"]={
                label="Vestimenta 1",
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
            }
        }
    },
    --[[["faction4"]={
        Label="Los Ballas",
        Blip={
            Coords=vector3(103.74,-1937.11,19.8),
			Sprite  = 429,
			Display = 4,
			Scale   = 0.6,
			Colour  = 83,
            Radius  = 62.0
        },
        Zones={ 
            ["armory"]={x = 106.56 ,y =-1981.45 ,z= 19.96,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder a la armeria",            
                        color={r = 255, g = 255, b = 0}
            },
            ["stock"]={x= 90.98,  y = -1987.83, z= 20.42,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder al stock",
                        color={r = 255, g = 255, b = 0}            
            },
            ["boss"]={x =119.67, y= -1968.39, z =20.33,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder al menu de jefe",
                        color = {r = 255, g = 255, b = 0}
            },
            ["vehicles"]={x= 102.58, y =-1963.65, z= 19.84,
                        grade=1,
                        hint=("Presiona ~INPUT_CONTEXT~ para acceder al garage"),
                        color = {r = 255, g = 255, b = 0}            
            },
            ["uniform"]={x =118.53 ,y =-1963.34 ,z= 20.33,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para cambiar el vestuario",
                        color={r = 255, g = 255, b = 0}            
            },
        },
        Vehicles={
            {label="Asea",spawn="asea"}
        },
        VehicleSpawner={x=102.97,y=-1958.72,z=20.41,heading=356.45},
        Uniforms={
            ["vest1"]={
                label="Vestimenta 1",
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
            }
        }
    },
    ["faction2"]={
        Label="Los Vagos",
        Blip={
            Coords=vector3(362.64,-2054.79,25.29),
			Sprite  = 429,
			Display = 4,
			Scale   = 0.6,
			Colour  = 5,
            Radius  = 75.0
        },
        Zones={
            ["armory"]={x = 106.56 ,y =-1981.45 ,z= 19.96,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder a la armeria",            
                        color={r = 255, g = 255, b = 0}
            },
            ["stock"]={x= 1272.38, y= -1711.96, z= 54.77,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder al stock",
                        color={r = 255, g = 255, b = 0}            
            },
            ["boss"]={x =119.67, y= -1968.39, z =20.33,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder al menu de jefe",
                        color = {r = 255, g = 255, b = 0}
            },
            ["vehicles"]={x= 102.58, y =-1963.65, z= 19.84,
                        grade=1,
                        hint=("Presiona ~INPUT_CONTEXT~ para acceder al garage"),
                        color = {r = 255, g = 255, b = 0}            
            },
            ["uniform"]={x =118.53 ,y =-1963.34 ,z= 20.33,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para cambiar el vestuario",
                        color={r = 255, g = 255, b = 0}            
            },
        },
        Vehicles={
            {label="Asea",spawn="asea"}
        },
        VehicleSpawner={x=102.97,y=-1958.72,z=20.41,heading=356.45},
        Uniforms={
            ["vest1"]={
                label="Vestimenta 1",
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
            }
        }
    },
     ["faction7"]={
        Label="Los Aztecas",
        Blip={
            Coords=vector3(1276.83,-1736.35,51.92),
			Sprite  = 429,
			Display = 4,
			Scale   = 0.6,
			Colour  = 3,
            Radius  = 72.0
        },
        Zones={
            ["armory"]={x=1289.27,y=-1710.5,z=54.48,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder a la armeria",            
                        color={r = 255, g = 255, b = 0}
            },
            ["stock"]={x= 1272.38, y= -1711.96, z= 53.77,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder al stock",
                        color={r = 255, g = 255, b = 0}            
            },
            ["boss"]={x =1275.46, y= -1710.85, z= 53.77,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder al menu de jefe",
                        color = {r = 255, g = 255, b = 0}
            },
            ["vehicles"]={x=1303.55,y=-1708.85,z=54.12 ,
                        grade=1,
                        hint=("Presiona ~INPUT_CONTEXT~ para acceder al garage"),
                        color = {r = 255, g = 255, b = 0}            
            },
            
            ["uniform"]={x =1272.26, y =-1714.83, z =53.77,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para cambiar el vestuario",
                        color={r = 255, g = 255, b = 0}            
            },
        },
        Vehicles={
            {label="Asea",spawn="asea"}
        },
        VehicleSpawner={x=102.97,y=-1958.72,z=20.41,heading=356.45},
        Uniforms={
            ["vest1"]={
                label="Vestimenta 1",
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
            }
        }
    },
    ["faction5"]={
        Label="Los Families",
        Blip={
            Coords=vector3(-117.85,-1624.01,40.25),
			Sprite  = 429,
			Display = 4,
			Scale   = 0.6,
			Colour  = 2,
            Radius  = 62.0
        },
        Zones={
            ["armory"]={x =-136.86, y =-1608 ,z =35.03,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder a la armeria",            
                        color={r = 255, g = 255, b = 0}
            },
            ["stock"]={x =-135.06, y =-1611.01, z =35.03,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder al stock",
                        color={r = 255, g = 255, b = 0}            
            },
            ["boss"]={x =-145.15,  y =-1600.03,  z= 35.07 ,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder al menu de jefe",
                        color = {r = 255, g = 255, b = 0}
            },
            ["vehicles"]={x =-150.97, y =-1661.55, z= 32.84,
                        grade=1,
                        hint=("Presiona ~INPUT_CONTEXT~ para acceder al garage"),
                        color = {r = 255, g = 255, b = 0}            
            },
            ["uniform"]={x =-157.56, y =-1062.92, z =35.04,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para cambiar el vestuario",
                        color={r = 255, g = 255, b = 0}            
            },
        },
        Vehicles={
            {label="Asea",spawn="asea"}
        },
        VehicleSpawner={x=102.97,y=-1958.72,z=20.41,heading=356.45},
        Uniforms={
            ["vest1"]={
                label="Vestimenta 1",
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
            }
        }
    },
    ["faction1"]={
        Label="Mafia 1",
        Blip=nil,
        Zones={
            ["armory"]={x=-1866.44,y=2065.14,z=134.43,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder a la armeria",            
                        color={r = 255, g = 255, b = 0}
            },
            ["stock"]={x=-1878.08,y=2063.23,z=134.92,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder al stock",
                        color={r = 255, g = 255, b = 0}            
            },
            ["boss"]={x=-1875.79,y=2060.91,z=144.57,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para acceder al menu de jefe",
                        color = {r = 255, g = 255, b = 0}
            },
            ["vehicles"]={x=-1920.92,y=2048.77,z=139.73,
                        grade=1,
                        hint=("Presiona ~INPUT_CONTEXT~ para acceder al garage"),
                        color = {r = 255, g = 255, b = 0}            
            },
            ["uniform"]={x=-1887.2,y=2070.23,z=144.57,
                        grade=1,
                        hint="Presiona ~INPUT_CONTEXT~ para cambiar el vestuario",
                        color={r = 255, g = 255, b = 0}            
            },
        },
        Vehicles={
            {label="Asea",spawn="asea"}
        },
        VehicleSpawner={x=-1920.92,y=2048.77,z=135.73,heading=256.33},
        Uniforms={
            ["vest1"]={
                label="Vestimenta 1",
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
            }
        }
    },]]
}
