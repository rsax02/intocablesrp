Config = {}

Config.Locale = 'es'

Config.serverLogo = 'https://i.imgur.com/5HYOL6Q.png'

Config.font = {
	name 	= 'Montserrat',
	url 	= 'https://fonts.googleapis.com/css?family=Montserrat:300,400,700,900&display=swap'
}

Config.date = {
	format	 	= 'withHours',
	AmPm		= false
}

Config.voice = {

	levels = {
		default = 6.5, --verde
		whisper = 26.0, --rojo
		shout = 15.5, --amarillo
		current = 0
	},
	
	keys = {
		distance 	= 'F9',
	}
}


Config.vehicle = {
	speedUnit = 'KMH',
	maxSpeed = 240,

	keys = {
		seatbelt 	= 'K',
		cruiser		= 'NONE',
		signalLeft	= 'LEFT',
		signalRight	= 'RIGHT',
		signalBoth	= 'DOWN',
	}
}

Config.ui = {
	showServerLogo		= false,

	showJob		 		= true,
	

	showWalletMoney 	= true,
	showBankMoney 		= true,
	showBlackMoney 		= true,
	showSocietyMoney	= true,

	showInfoTime		= true,
	showDate 			= true,
	showLocation 		= true,
	showVoice	 		= true,

	showHealth			= false,
	showArmor	 		= true,
	showHunger 			= true,
	showThirst	 		= true,
	showDrunk          = true,
	showStatus 			=true,
	showMinimap			= true,

	showWeapons			= false,	
}