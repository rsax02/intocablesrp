fx_version 'adamant'

game 'gta5'

version '1.2.0'

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/script.js',
	'html/style.css',
	'html/font/Prototype.ttf',
	'html/img/background.jpg'
}

dependency 'es_extended'

client_script '@niward-ac/Shareds/ToLoad.lua'