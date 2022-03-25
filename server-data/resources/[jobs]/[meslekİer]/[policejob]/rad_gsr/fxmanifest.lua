fx_version 'adamant'

game 'gta5'

description 'RADGSR'

version '1.1.0'

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
	'@mysql-async/lib/MySQL.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	"client/main.lua"
}
