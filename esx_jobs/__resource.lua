resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Jobs'

version '1.1.0'

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
	'client/jobs/*.lua',
	'client/drugs.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/jobs/*.lua',
	'client/main.lua',
	'client/drugs.lua'
}

dependencies {
	'es_extended',
	'esx_addonaccount',
	'skinchanger',
	'esx_skin',
}
 