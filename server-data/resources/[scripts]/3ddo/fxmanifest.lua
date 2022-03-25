fx_version 'adamant'

game 'gta5'

name "Optimized 3D /ME Script."
author "Mart475 - Universal Development."
credit "Elio."
description "The optimized 3d /me script is 3d display of a person’s ingame actions, face expressions & more."

client_script 'client.lua'
server_scripts {
    'server.lua',
    '@mysql-async/lib/MySQL.lua',
  }