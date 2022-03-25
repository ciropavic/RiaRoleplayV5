fx_version 'adamant'

game 'gta5'

description 'ESX Taglialegna Serse Dio Re'

version '1.4.2'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended'
}
