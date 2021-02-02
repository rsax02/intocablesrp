Config = {}
Config.Locale = 'en'

Config.JailBlip = vector3(1854.0, 2622.0, 45.0)
Config.JailLocation = vector3(1642.46, 2528.11, 45.5)
Config.JailTimeSyncInterval = 60000 * 5


Config.Uniforms = {
	prison_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1']  = 15, ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 6,   ['pants_1']  = 64,
			['pants_2']  = 6,   ['shoes_1']  = 12,
			['shoes_2']  = 12,  ['chain_1']  = 50,
			['chain_2']  = 0
		},
		female = {
			['tshirt_1'] = 3,   ['tshirt_2'] = 0,
			['torso_1']  = 38,  ['torso_2']  = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 2,   ['pants_1']  = 3,
			['pants_2']  = 15,  ['shoes_1']  = 69,
			['shoes_2']  = 0,   ['chain_1']  = 0,
			['chain_2']  = 2
		}
	}
}