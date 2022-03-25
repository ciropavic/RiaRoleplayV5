fx_version 'adamant'

game 'gta5'

client_script "yordi-client.lua"
server_script {
    '@mysql-async/lib/MySQL.lua',
    'yordi-server.lua'
}