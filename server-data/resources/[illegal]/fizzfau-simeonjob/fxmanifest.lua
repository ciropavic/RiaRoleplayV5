fx_version 'adamant'

game 'gta5'

description 'fizzfau presents'

client_scripts {
	'@es_extended/locale.lua',
	'client/client.lua',
    'config.lua',
    'locales/eng.lua',
    'locales/tr.lua'

}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
	'@es_extended/locale.lua',
    'server/server.lua',
    'locales/eng.lua',
    'locales/tr.lua',
    "config.lua"
}