resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	'config.lua',
	'client/main.lua',
	'client/hacking.lua',
	'client/hacking2.lua',
  'sequentialhack.lua'
}

server_scripts {
	'config.lua',
	'server/main.lua'
}

ui_page 'html/hack.html'

files {
  'html/phone.png',
  'html/snd/beep.ogg',
  'html/snd/correct.ogg',
  'html/snd/fail.ogg', 
  'html/snd/start.ogg',
  'html/snd/finish.ogg',
  'html/snd/wrong.ogg',
  'html/hack.html'
}

dependency 'es_extended'