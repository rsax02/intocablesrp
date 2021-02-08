Config = {
-- Change the language of the menu here!.
-- Note fr and de are google translated, if you would like to help out with translation / just fix it for your server check below and change translations yourself
-- try en, fr, de or sv.
	MenuLanguage = 'es',	
-- Set this to true to enable some extra prints
	DebugDisplay = false,
-- Set this to false if you have something else on X, and then just use /e c to cancel emotes.
	EnableXtoCancel = true,
-- Set this to true if you want to disarm the player when they play an emote.
	DisarmPlayer= false,
-- Set this if you really wanna disable emotes in cars, as of 1.7.2 they only play the upper body part if in vehicle
    AllowedInCars = true,
-- You can disable the (F3) menu here / change the keybind.
	MenuKeybindEnabled = true,
	MenuKeybind = 166, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Favorite emote keybinding here.
	FavKeybindEnabled = false,
	FavKeybind = 171, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can change the header image for the f3 menu here
-- Use a 512 x 128 image!
-- NOte this might cause an issue of the image getting stuck on peoples screens
	CustomMenuEnabled = true,
	MenuImage = " ",
-- You can change the menu position here
	MenuPosition = "left", -- (left, right)
-- You can disable the Ragdoll keybinding here.
	RagdollEnabled = true,
	RagdollKeybind = 101, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Facial Expressions menu here.
	ExpressionsEnabled = true,
-- You can disable the Walking Styles menu here.
	WalkingStylesEnabled = true,	
-- You can disable the Shared Emotes here.
    SharedEmotesEnabled = true,
    CheckForUpdates = true,
-- If you have the SQL imported enable this to turn on keybinding.
    SqlKeybinding = true,
}

Config.KeybindKeys = {

}

Config.Languages = {
  ['es'] = {
        ['emotes'] = "🤾 Animaciones",
        ['danceemotes'] = "🕺 Bailes",
        ['propemotes'] = "📦 Objetos",
        ['hotemotes'] = '😈 Animaciones +18',
        ['keybindemotes'] = "🌟 Favorita",
        ['keybindinfo'] = "Selecciona una animacion como su favorita.",
        ['rkeybind'] = "Reiniciar favorito",
        ['prop2info'] = "❓ Animaciones de objetos al final.",
        ['set'] = "Elegir (",
        ['setboundemote'] = ") como tu animacion favorita?",
        ['newsetemote'] = "~w~ es ahora tu animacion favorita, presiona ~g~[CapsLock]~w~ para usarla.",
        ['cancelemote'] = "❌ Cancelar",
        ['cancelemoteinfo'] = "Cancelar la animacion actual.",
        ['walkingstyles'] = "🏃 Caminatas",
        ['resetdef'] = "Reiniciar a por defecto",
        ['normalreset'] = "Normal (Reiniciar)",
        ['moods'] = "Estados de animo",
        ['infoupdate'] = "Informacion",
        ['infoupdateav'] = "Informacion (Actualizacion disponible)",
        ['infoupdateavtext'] = "Una actualizacion esta disponible, para conseguir la ultima version ingresa a ~y~https://github.com/andristum/dpemotes~w~",
        ['suggestions'] = "Sugerencias?",
        ['suggestionsinfo'] = "dullpear_dev' en el foro de FiveM para cualquier sugerencia! ✉️",
        ['notvaliddance'] = "no es un baile valido.",
        ['notvalidemote'] = "no es una animacion valida.",
        ['nocancel'] = "No hay animacion para cancelar.",
        ['maleonly'] = "Esta animacion es solo de hombre!",
        ['emotemenucmd'] = "Escribe /emotemenu para abrir el menu.",
        ['shareemotes'] = "👫 Animaciones compartidas",
        ['shareemotesinfo'] = "Invita a una persona cercana para la animacion.",
        ['sharedanceemotes'] = "🕺 Bailes compartidos",
        ['notvalidsharedemote'] = "no es una animacion compartida valida.",
        ['sentrequestto'] = "Solicitud enviada ~y~",
        ['nobodyclose'] = "Nadie ~r~cerca~w~.",
        ['doyouwanna'] = "~y~Y~w~ para aceptar, ~r~L~w~ para rechazar (~g~",
        ['refuseemote'] = "Animacion rechazada.",
        ['makenearby'] = "hacer que el jugador cercano juegue",
        ['camera'] = "Presione ~y~G~w~ para usar el flash de la camara.",
        ['makeitrain'] = "Presiona ~y~G~w~ para hacer llover.",
        ['pee'] = "Mantiene ~y~G~w~ para mear.",
        ['spraychamp'] = "Mantiene ~y~G~w~ rociar champán.",
        ['bound'] = "Unida ",
        ['to'] = "a",
        ['currentlyboundemotes'] = " Emotes vinculados actualmente:",
        ['notvalidkey'] = "no es una clave válida.",
        ['keybinds'] = "🔢 Atajos",
        ['keybindsinfo'] = "Utilizar"
  }
}