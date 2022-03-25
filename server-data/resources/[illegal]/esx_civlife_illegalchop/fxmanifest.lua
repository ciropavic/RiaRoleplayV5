fx_version 'adamant'

game 'gta5'

server_scripts {
    '@es_extended/locale.lua',
	"@mysql-async/lib/MySQL.lua",
	'server/main.lua',
	'config.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'client/main.lua',
	'config.lua'
}