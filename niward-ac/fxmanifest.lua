fx_version 'adamant'
game 'gta5'

author 'chaini & polini'
description 'NiWard Anti-Cheat'
version 'V5'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'ClConfig.lua',
	'SvConfig.lua',
	'server/server.lua',
	'server/main.lua',
	'server/instalador.lua',
	'menu/server.lua',
}

client_scripts {
	'ClConfig.lua',
	'client/client.lua',
	'menu/client.lua',
}

shared_script {
	'Shareds/ToLoad.lua',
}
