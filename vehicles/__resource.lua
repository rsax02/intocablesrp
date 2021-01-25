resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files{
	'stream/**/*.meta'
}

data_file 'HANDLING_FILE' 'stream/**/handling.meta' 
data_file 'VEHICLE_METADATA_FILE' 'stream/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'stream/**/carcols.meta' 
data_file 'VEHICLE_VARIATION_FILE' 'stream/**/carvariations.meta' 
data_file 'DLC_TEXT_FILE' 'stream/**/dlctext.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'stream/**/vehiclelayouts.meta'

client_script 'vehicle_names.lua'