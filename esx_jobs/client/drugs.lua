Config.Jobs.drugs={
    BlipInfos = {
		Sprite = 429,
		Color = 1,
        Radius = 120.0
	},

    Zones = {
        PbcFarm = {
			Pos = {x=2330.16,y=2571.92,z=45.68},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
            Duty=true,
			Blip = true,
			Name = "Zona Roja",
			Type = "work",
			Item = {
				{
					name = "PBC",
					db_name = "pbc",
					time = 3,
					max = 500,
					add = 1,
					remove = 1,
					requires = "nothing",
					requires_name = "Nothing",
					drop = 100
				}
			},
			Hint =  _U("d_pickpbc"),
			GPS = {x=-507.41,y=-831.82,z=29.5}
		},
        PbcDelivery = {
			Pos = {x=1344.59,y=4389.44,z=43.34},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
            Duty=true,
			Blip = true,
			Name = "Zona Roja",
			Type = "work",
			Item = {
				{
					name = _U("delivery"),
					time = 2,
					remove = 1,
					max = 500, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 14,
					requires = "pbc",
					requires_name = _U("d_pbc"),
					drop = 100
				}
			},
			Hint = _U("d_deliver_pbc"),
			GPS = {x=-507.41,y=-831.82,z=29.5}
		},
    }
}