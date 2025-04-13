Config = {}

-- Discord Webhook Configuration
Config.DiscordWebhook = GetConvar('pixel_logs_webhook', '') -- Discord webhook URL
Config.DiscordUsername = GetConvar('pixel_logs_username', 'Server Logs') -- Username for the webhook
Config.DiscordAvatar = GetConvar('pixel_logs_avatar', '') -- Avatar URL for the webhook

-- Debug Configuration
Config.Debug = {
    Enabled = GetConvar('pixel_logs_debug', 'false') == 'true',
    MaxLogs = tonumber(GetConvar('pixel_logs_debug_maxlogs', '100')),
    Webhook = GetConvar('pixel_logs_debug_webhook', '')
}

-- Logging Settings
Config.LogTypes = {
    ['player_join'] = GetConvar('pixel_logs_join', 'true') == 'true',
    ['player_leave'] = GetConvar('pixel_logs_leave', 'true') == 'true',
    ['player_death'] = GetConvar('pixel_logs_death', 'true') == 'true',
    ['player_chat'] = GetConvar('pixel_logs_chat', 'true') == 'true',
    ['player_bans'] = GetConvar('pixel_logs_bans', 'true') == 'true',
    ['player_kicks'] = GetConvar('pixel_logs_kicks', 'true') == 'true',
    ['player_warns'] = GetConvar('pixel_logs_warns', 'true') == 'true',
    ['player_commands'] = GetConvar('pixel_logs_commands', 'true') == 'true',
    ['player_connections'] = GetConvar('pixel_logs_connections', 'true') == 'true',
    ['player_resources'] = GetConvar('pixel_logs_resources', 'true') == 'true'
}

-- Embed Colors
Config.Colors = {
    ['player_join'] = 65280, -- Green
    ['player_leave'] = 16711680, -- Red
    ['player_death'] = 16711680, -- Red
    ['player_chat'] = 16776960, -- Yellow
    ['player_bans'] = 16711680, -- Red
    ['player_kicks'] = 16711680, -- Red
    ['player_warns'] = 16776960, -- Yellow
    ['player_commands'] = 16776960, -- Yellow
    ['player_connections'] = 255, -- Blue
    ['player_resources'] = 16776960 -- Yellow
}

-- Message Templates
Config.Messages = {
    ['player_join'] = '**{player}** has joined the server',
    ['player_leave'] = '**{player}** has left the server',
    ['player_death'] = '**{player}** has died',
    ['player_chat'] = '**{player}**: {message}',
    ['player_bans'] = '**{player}** has been banned by **{admin}** for: {reason}',
    ['player_kicks'] = '**{player}** has been kicked by **{admin}** for: {reason}',
    ['player_warns'] = '**{player}** has been warned by **{admin}** for: {reason}',
    ['player_commands'] = '**{player}** used command: {command}',
    ['player_connections'] = '**{player}** {action} the server',
    ['player_resources'] = 'Resource **{resource}** has been {action}'
}

-- Identifier Settings
Config.Identifiers = {
    ['steam'] = GetConvar('pixel_logs_steam', 'true') == 'true',
    ['discord'] = GetConvar('pixel_logs_discord', 'true') == 'true',
    ['license'] = GetConvar('pixel_logs_license', 'true') == 'true',
    ['xbox'] = GetConvar('pixel_logs_xbox', 'true') == 'true',
    ['live'] = GetConvar('pixel_logs_live', 'true') == 'true',
    ['fivem'] = GetConvar('pixel_logs_fivem', 'true') == 'true',
    ['ip'] = GetConvar('pixel_logs_ip', 'false') == 'true'
} 