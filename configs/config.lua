Config = {}

-- Initialize Messages and Colors tables
Config.Messages = {}
Config.Colors = {}

-- Discord Webhook Configuration
Config.DiscordWebhook = GetConvar('pixel_logs_webhook', '') -- Discord webhook URL
Config.DiscordUsername = GetConvar('pixel_logs_username', 'Server Logs') -- Username for the webhook
Config.DiscordAvatar = GetConvar('pixel_logs_avatar', '') -- Avatar URL for the webhook

-- Proxy Configuration
Config.Proxy = {
    Enabled = GetConvar('pixel_logs_proxy_enabled', 'false') == 'true',
    URL = GetConvar('pixel_logs_proxy_url', ''),
    Username = GetConvar('pixel_logs_proxy_username', ''),
    Password = GetConvar('pixel_logs_proxy_password', '')
}

-- Debug Configuration
Config.Debug = {
    Enabled = GetConvar('pixel_logs_debug', 'false') == 'true',
    MaxLogs = tonumber(GetConvar('pixel_logs_debug_maxlogs', '100')),
    Webhook = GetConvar('pixel_logs_debug_webhook', ''),
    NoVersion = GetConvar('pixel_logs_debug_noversion', 'false') == 'true'
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
    ['player_resources'] = GetConvar('pixel_logs_resources', 'true') == 'true',
    -- txAdmin Event Log Types
    ['txadmin_announcement'] = GetConvar('pixel_logs_txadmin_announcement', 'true') == 'true',
    ['txadmin_shutdown'] = GetConvar('pixel_logs_txadmin_shutdown', 'true') == 'true',
    ['txadmin_restart_skipped'] = GetConvar('pixel_logs_txadmin_restart_skipped', 'true') == 'true',
    ['txadmin_direct_message'] = GetConvar('pixel_logs_txadmin_direct_message', 'true') == 'true',
    ['txadmin_player_healed'] = GetConvar('pixel_logs_txadmin_player_healed', 'true') == 'true',
    ['txadmin_whitelist_preapproval'] = GetConvar('pixel_logs_txadmin_whitelist_preapproval', 'true') == 'true',
    ['txadmin_whitelist_request'] = GetConvar('pixel_logs_txadmin_whitelist_request', 'true') == 'true',
    ['txadmin_action_revoked'] = GetConvar('pixel_logs_txadmin_action_revoked', 'true') == 'true',
    ['txadmin_admin_auth'] = GetConvar('pixel_logs_txadmin_admin_auth', 'true') == 'true',
    ['txadmin_admins_updated'] = GetConvar('pixel_logs_txadmin_admins_updated', 'true') == 'true',
    ['txadmin_config_changed'] = GetConvar('pixel_logs_txadmin_config_changed', 'true') == 'true',
    ['txadmin_console_command'] = GetConvar('pixel_logs_txadmin_console_command', 'true') == 'true',
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