fx_version 'adamant'

game 'gta5'

description 'ESX Gold Currency'

client_scripts {
    "config.lua",
    "client/client.lua",
    "client/goldjob.lua"
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "config.lua",
    "server/server.lua"
}