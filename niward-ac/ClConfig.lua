ClConfig                        = {}

ClConfig.Interval               = 1000 -- Mientras mas tiempo, mas tarda en verificar todo lo del cliente.
ClConfig.ESXGetSharedObject     = 'esx:getSharedObject' -- Su ESXGetSharedObject

ClConfig.PrintConsoleClientSide = false -- Si está en false, no muestra ningun printeo en consola del cliente.

ClConfig.AntiSpectate           = true -- Detecta si el usuario esta specteando o no.
ClConfig.AntiResourceStopCheck  = true -- Detecta si el usuario stoppea un resource o no. (Si está en true no podrán reiniciar/stoppear/iniciar resources nuevos)
ClConfig.AntiResourceStartCheck = true -- Detecta si un usuario startear un resource o no. (Si está en true no podrán reiniciar/stoppear/iniciar resources nuevos)
ClConfig.AntiLuas               = true -- Bloquea la mayoría de lua's.
ClConfig.AntiNiwardBypass       = true -- Varios bypass de niward fueron parcheados.

ClConfig.PlayerProtection       = true -- Le deshabilita varias funciones de cheats. (balas explosivas, piñas explosivas, etc)
ClConfig.DeleteVehicleDamaged   = true -- Borra todos los vehiculos que estan por explotar.
ClConfig.AntiVehicleHashChanger = true -- Parche Cheat Engine (hash de vehiculos)
ClConfig.AntiVehicleRainbow     = false -- Si el vehiculo cambia de color más de 3 veces, lo banea por anti-rainbow.
ClConfig.AntiMenyoo             = false -- AntiMenyoo injections

ClConfig.AntiGiveWeapon         = true -- Si detecta que un usuario esta intentando givear un arma, lo banea.
ClConfig.AntiClearPedTaskEvent  = false -- Si detecta que un usuario expulsa de un vehiculo (o lo para) de forma inmediata lo banea.

ClConfig.QuantityResources      = true -- Verifica cada 30s la cantidad de resources que tiene.
ClConfig.QuantityResourcesBan   = true -- Si tiene mas resources que los que detecta el servidor lo banea.

ClConfig.AntiPedWithWeapon      = true -- Verifica si el ped esta armado, si es asi, lo borra.

ClConfig.AdminMenuEnabled       = true
ClConfig.AdminMenuKey           = 121 -- https://gist.github.com/KingCprey/d40f6deb8ac2949d95524448596e2f37

ClConfig.CarBlacklistEnabled    = true -- Verifica en que auto está el usuario, si el auto está en la lista se lo borra, y si el ban está en true lo banea.
ClConfig.CarBlacklisted         = {
	[0]  = { vehicle = "SUBMERSIBLE", ban = false },
	[1]  = { vehicle = "SUBMERSIBLE2", ban = false },
	[2]  = { vehicle = "CERBERUS3", ban = false },
	[3]  = { vehicle = "PHANTOM2", ban = false },
	[4]  = { vehicle = "AKULA", ban = false },
	[5]  = { vehicle = "ANNIHILATOR", ban = false },
	[6]  = { vehicle = "BUZZARD", ban = false },
	[7]  = { vehicle = "CARGOBOB", ban = false },
	[8]  = { vehicle = "CARGOBOB2", ban = false },
	[9]  = { vehicle = "CARGOBOB3", ban = false },
	[10] = { vehicle = "CARGOBOB4", ban = false },
	[11] = { vehicle = "FROGGER", ban = false },
	[12] = { vehicle = "FROGGER2", ban = false },
	[13] = { vehicle = "HAVOK", ban = false },
	[14] = { vehicle = "HUNTER", ban = false },
	[15] = { vehicle = "MAVERICK", ban = false },
	[16] = { vehicle = "SAVAGE", ban = false },
	[17] = { vehicle = "SEASPARROW", ban = false },
	[18] = { vehicle = "SKYLIFT", ban = false },
	[19] = { vehicle = "SUPERVOLITO2", ban = false },
	[20] = { vehicle = "VALKYRIE", ban = false },
	[21] = { vehicle = "VALKYRIE2", ban = false },
	[22] = { vehicle = "VOLATUS", ban = false },
	[23] = { vehicle = "BULLDOZER", ban = false },
	[24] = { vehicle = "CUTTER", ban = false },
	[25] = { vehicle = "DUMP", ban = false },
	[26] = { vehicle = "HANDLER", ban = false },
	[27] = { vehicle = "APC", ban = false },
	[28] = { vehicle = "BARRAGE", ban = false },
	[29] = { vehicle = "CHERNOBOG", ban = false },
	[30] = { vehicle = "HALFTRACK", ban = false },
	[31] = { vehicle = "KHANJALI", ban = false },
	[32] = { vehicle = "MINITANK", ban = false },
	[33] = { vehicle = "RHINO", ban = false },
	[34] = { vehicle = "SCARAB", ban = false },
	[35] = { vehicle = "SCARAB2", ban = false },
	[36] = { vehicle = "SCARAB3", ban = false },
	[37] = { vehicle = "SCARAB3", ban = false },
	[38] = { vehicle = "THRUSTER", ban = false },
	[39] = { vehicle = "TRAILERSMALL2", ban = false },
	[40] = { vehicle = "OPPRESSOR", ban = false },
	[41] = { vehicle = "OPPRESSOR2", ban = false },
	[42] = { vehicle = "SHOTARO", ban = false },
	[43] = { vehicle = "BRUISER", ban = false },
	[44] = { vehicle = "BRUISER2", ban = false },
	[45] = { vehicle = "DUNE", ban = false },
	[46] = { vehicle = "DUNE2", ban = false },
	[47] = { vehicle = "DUNE3", ban = false },
	[48] = { vehicle = "DUNE4", ban = false },
	[49] = { vehicle = "DUNE5", ban = false },
	[50] = { vehicle = "INSURGENT", ban = false },
	[51] = { vehicle = "INSURGENT2", ban = false },
	[52] = { vehicle = "INSURGENT3", ban = false },
	[53] = { vehicle = "RCBANDITO", ban = false },
	[54] = { vehicle = "TECHNICAL", ban = false },
	[55] = { vehicle = "TECHNICAL2", ban = false },
	[56] = { vehicle = "TECHNICAL3", ban = false },
	[57] = { vehicle = "ALPHAZ1", ban = false },
	[58] = { vehicle = "AVENGER", ban = false },
	[59] = { vehicle = "AVENGER2", ban = false },
	[60] = { vehicle = "BESRA", ban = false },
	[61] = { vehicle = "BLIMP", ban = false },
	[62] = { vehicle = "BLIMP3", ban = false },
	[63] = { vehicle = "BOMBUSHKA", ban = false },
	[64] = { vehicle = "CARGOPLANE", ban = false },
	[65] = { vehicle = "CUBAN800", ban = false },
	[66] = { vehicle = "DODO", ban = false },
	[67] = { vehicle = "DUSTER", ban = false },
	[68] = { vehicle = "HOWARD", ban = false },
	[69] = { vehicle = "HYDRA", ban = false },
	[70] = { vehicle = "JET", ban = false },
	[71] = { vehicle = "LAZER", ban = false },
	[72] = { vehicle = "LUXOR", ban = false },
	[73] = { vehicle = "LUXOR2", ban = false },
	[74] = { vehicle = "MAMMATUS", ban = false },
	[75] = { vehicle = "MICROLIGHT", ban = false },
	[76] = { vehicle = "MILJET", ban = false },
	[77] = { vehicle = "MOGUL", ban = false },
	[78] = { vehicle = "MOLOTOK", ban = false },
	[79] = { vehicle = "NIMBUS", ban = false },
	[80] = { vehicle = "NOKOTA", ban = false },
	[81] = { vehicle = "PYRO", ban = false },
	[82] = { vehicle = "ROGUE", ban = false },
	[83] = { vehicle = "SEABREEZE", ban = false },
	[84] = { vehicle = "SHAMAL", ban = false },
	[85] = { vehicle = "STARLING", ban = false },
	[86] = { vehicle = "STRIKEFORCE", ban = false },
	[87] = { vehicle = "STUNT", ban = false },
	[88] = { vehicle = "TITAN", ban = false },
	[89] = { vehicle = "TULA", ban = false },
	[90] = { vehicle = "VELUM", ban = false },
	[91] = { vehicle = "VELUM2", ban = false },
	[92] = { vehicle = "VESTRA", ban = false },
	[93] = { vehicle = "VOLATOL", ban = false },
	[94] = { vehicle = "BALLER5", ban = false },
	[95] = { vehicle = "BALLER6", ban = false },
	[96] = { vehicle = "WASTELANDER", ban = false },
	[97] = { vehicle = "SCRAMJET", ban = false },
}

ClConfig.WeaponBlacklistEnabled = true -- Verifica si el usuario tiene un arma de la lista de abajo.
ClConfig.WeaponBlacklisted      = { -- Lista de armas (recomendado: poner false todas las armas)
	--Handguns
	[14] = { weapon = "weapon_appistol", ban = false },
	[15] = { weapon = "weapon_marksmanpistol", ban = false },
	[16] = { weapon = "weapon_revolver_mk2", ban = false },
	[17] = { weapon = "weapon_doubleaction", ban = false },
	[18] = { weapon = "weapon_raypistol", ban = false },
	[19] = { weapon = "weapon_ceramicpistol", ban = false },
	[20] = { weapon = "weapon_navyrevolver", ban = false },
	--Submachine Guns
	[21] = { weapon = "weapon_smg_mk2", ban = false },
	[22] = { weapon = "weapon_minismg", ban = false },
	[23] = { weapon = "weapon_raycarbine", ban = false },
	--Shotguns
	[24] = { weapon = "weapon_pumpshotgun_mk2", ban = false },
	[25] = { weapon = "weapon_assaultshotgun", ban = false },
	[26] = { weapon = "weapon_musket", ban = false },
	[27] = { weapon = "weapon_heavyshotgun", ban = false },
	[28] = { weapon = "weapon_dbshotgun", ban = false },
	[29] = { weapon = "weapon_autoshotgun", ban = false },
	--Assault Rifles
	[30] = { weapon = "weapon_assaultrifle_mk2", ban = false },
	[58] = { weapon = "weapon_assaultrifle", ban = false },
	[31] = { weapon = "weapon_carbinerifle_mk2", ban = false },
	[32] = { weapon = "weapon_specialcarbine", ban = false },
	[33] = { weapon = "weapon_specialcarbine_mk2", ban = false },
	[34] = { weapon = "weapon_bullpuprifle_mk2", ban = false },
	--Light Machine Guns
	[35] = { weapon = "weapon_mg", ban = false },
	[36] = { weapon = "weapon_combatmg", ban = false },
	[37] = { weapon = "weapon_combatmg_mk2", ban = false },
	[38] = { weapon = "weapon_gusenberg", ban = false },
	--Sniper Rifles
	[39] = { weapon = "weapon_heavysniper", ban = false },
	[40] = { weapon = "weapon_heavysniper_mk2", ban = false },
	[41] = { weapon = "weapon_marksmanrifle", ban = false },
	[42] = { weapon = "weapon_marksmanrifle_mk2", ban = false },
	--Sniper Rifles
	[43] = { weapon = "weapon_rpg", ban = false },
	[44] = { weapon = "weapon_grenadelauncher", ban = false },
	[45] = { weapon = "weapon_grenadelauncher_smoke", ban = false },
	[46] = { weapon = "weapon_minigun", ban = false },
	[47] = { weapon = "weapon_firework", ban = false },
	[48] = { weapon = "weapon_railgun", ban = false },
	[49] = { weapon = "weapon_hominglauncher", ban = false },
	[50] = { weapon = "weapon_compactlauncher", ban = false },
	[51] = { weapon = "weapon_rayminigun", ban = false },
	--Throwables
	[52] = { weapon = "weapon_grenade", ban = false },
	[53] = { weapon = "weapon_molotov", ban = false },
	[54] = { weapon = "weapon_stickybomb", ban = false },
	[55] = { weapon = "weapon_proxmine", ban = false },
	[56] = { weapon = "weapon_pipebomb", ban = false },
	[57] = { weapon = "weapon_flare", ban = false },
}

ClConfig.AntiPedBlacklisted     = true -- Verifica constantemente por todo el servidor si existe una entidad con ese ped, si existe lo borra y le saca las armas.
ClConfig.AntiPedBlacklistedList = { "g_m_y_lost_01","g_m_y_lost_02","g_m_y_lost_03","a_m_y_mexthug_01", "a_c_cat_01", "a_c_boar", "a_c_sharkhammer", "a_c_coyote", "a_c_chimp", "a_c_cow", "a_c_deer", "a_c_dolphin", "a_c_fish", "a_c_hen", "a_c_humpback", "a_c_killerwhale", "a_c_mtlion", "a_c_rabbit_01", "a_c_sharktiger" }

ClConfig.AntiSelfPedBlacklist   = true -- Verifica si el usuario tiene el ped de la lista de abajo, si lo tiene lo banea.
ClConfig.AntiSelfPedList        = { "a_m_y_mexthug_01", "a_c_cat_01", "a_c_boar", "a_c_sharkhammer", "a_c_coyote", "a_c_chimp", "a_c_cow", "a_c_deer", "a_c_dolphin", "a_c_fish", "a_c_hen", "a_c_humpback", "a_c_killerwhale", "a_c_mtlion", "a_c_rabbit_01", "a_c_sharktiger" }
