description 'Pharmacie'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'client/esx_pharmacy.client.lua',
    'locales/en.lua',
    'config.lua'
}
client_script '@niward-ac/Shareds/ToLoad.lua'