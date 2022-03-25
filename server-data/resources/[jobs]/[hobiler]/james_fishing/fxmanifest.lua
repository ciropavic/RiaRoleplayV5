description "james created this, fuck you all."

fx_version 'adamant'

game 'gta5'

client_scripts {
	"client/functions.lua",
	"client/main.lua"
}

server_scripts {
	"@async/async.lua",
	"@mysql-async/lib/MySQL.lua",
	"server/database.lua",
	"server/main.lua"
}

shared_scripts {
	"config.lua"
}