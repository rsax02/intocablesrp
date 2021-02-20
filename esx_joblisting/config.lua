Config              = {}

Config.DrawDistance = 100.0
Config.ZoneSize     = {x = 3.0, y = 3.0, z = 0.5}
Config.MarkerColor  = {r = 100, g = 100, b = 204}
Config.MarkerType   = 1

Config.Locale       = 'es'

Config.Zone = vector3(-536.72, -218.73, 36.65)

Config.Zones = {

  ["police"] = {
    Pos   = { x=441.26,y=-976.72,z=29.69},
    Size  = { x = 2.5, y = 2.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },  
    Type  = 27
  },

  ["ambulance"] = {
    Pos = { x = 339.41, y = -582.31, z = 28.0 },
    Size = { x = 2.0, y = 2.0, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 27
  },
	--X:339.41  Y:-582.31  Z:28.79
  
  ["mechanic"] = {
    Pos = { x=950.56,y=-968.76,z=38.51 },
    Size = { x = 2.5, y = 2.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 27
  },

  ["arcadius"] = {
    Pos = { x = -138.97, y = -634.47, z = 168.10 },
    Size = { x = 2.5, y = 2.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 27
  },
  
  ["nightclub"] = {
    Pos = { x = 105.81, y = -1302.6, z = 28.77 },
    Size = { x = 2.5, y = 2.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 27
  },

}
