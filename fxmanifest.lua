fx_version 'cerulean'
games { 'gta5', 'rdr3' }

author 'Pixelated <codemeapixel.dev>'
description 'Advanced Discord logging system for FiveM and RedM'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
repository 'https://github.com/ByteBrushStudios/pixel_logs'
version '1.04122025'

lua54 'yes'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/c_chat.lua',
    'client/c_events.lua',
    'client/c_exports.lua'
}

server_scripts {
    'server/s_utils.lua',
    'server/s_chat.lua',
    'server/s_events.lua',
    'server/s_exports.lua',
    'server/s_debug.lua',
    'server/s_web.lua'
}

server_exports {
    'GetUtils',
    'SendCustomLog',
    'SendCustomEmbed',
    'AddDebugLog',
    'GetDebugLogUrl'
}

client_exports {
    'SendCustomLog',
    'SendCustomEmbed'
}