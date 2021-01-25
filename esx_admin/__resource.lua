resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

version '1.0.8'

client_script 'client.lua'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'sqlban.lua'
}

dependencies {
	'essentialmode',
	'async'
}