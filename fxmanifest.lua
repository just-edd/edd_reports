-- Resource metadata
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'edd'
description 'Advanced report system'
version '1.0.0'

files {
    'locales/*.json',
    'web/dist/**'
}

ui_page 'web/dist/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    'config/config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}