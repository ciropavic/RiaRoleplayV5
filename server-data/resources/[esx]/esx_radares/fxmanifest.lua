fx_version 'adamant'

games { 'gta5' }

author 'ElGammaYT'

description 'ESX - egyt_radares - Script de radares que multan al propietario del vehículo.'

client_scripts {
    'client/main.lua',
    'config.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'config.lua',
}