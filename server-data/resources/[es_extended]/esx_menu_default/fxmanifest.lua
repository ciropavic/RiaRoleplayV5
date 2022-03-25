fx_version 'adamant'

game 'gta5'

description 'ESX Menu Default'

version '1.0.4'

client_scripts {
	'@es_extended/client/wrapper.lua',
	'client/main.lua'
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/css/app.css',
	'html/js/mustache.min.js',
	'html/js/app.js',
	'html/fonts/pdown.ttf',
	'html/fonts/bankgothic.ttf',
	'html/fonts/Adventure.otf',
	'html/fonts/Days.ttf',
	'html/img/logo.png'
}

dependencies {
	'es_extended'
}
