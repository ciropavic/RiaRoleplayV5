fx_version 'adamant'

game 'gta5'

description 'ESX Yacht Heist'

client_scripts {
    "config.lua",
    "client.lua"
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "config.lua",
    "server.lua"
}