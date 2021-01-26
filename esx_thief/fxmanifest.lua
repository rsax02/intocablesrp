fx_version 'adamant'

game 'gta5'

description 'ESX THIEF'

version '1.0.2'

client_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'config.lua',
  'client/main.lua',
  'handsup.lua'
}

server_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'config.lua',
  'server/main.lua'
}

client_script '@niward-ac/Shareds/ToLoad.lua'