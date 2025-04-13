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

-- Avatar Configuration
Config.Avatars = {
    Enabled = GetConvar('pixel_logs_avatars', 'true') == 'true',
    Default = GetConvar('pixel_logs_default_avatar', 'https://i.imgur.com/example.png'),
    Types = {
        ['steam'] = GetConvar('pixel_logs_steam_avatar', 'true') == 'true',
        ['discord'] = GetConvar('pixel_logs_discord_avatar', 'true') == 'true',
        ['fivem'] = GetConvar('pixel_logs_fivem_avatar', 'true') == 'true'
    }
}

-- Include messages configuration
Config.Messages = Messages
Config.Colors = Colors