Config = {}

-- Initialize Messages and Colors tables
Config.Messages = {}
Config.Colors = {}

-- Discord Webhook Configuration
Config.DiscordWebhook = GetConvar('pxl_webhook', '') -- Discord webhook URL
Config.DiscordUsername = GetConvar('pxl_username', 'Server Logs') -- Username for the webhook
Config.DiscordAvatar = GetConvar('pxl_avatar', '') -- Avatar URL for the webhook

-- Proxy Configuration
Config.Proxy = {
    Enabled = GetConvar('pxl_proxy_enabled', 'false') == 'true',
    URL = GetConvar('pxl_proxy_url', ''),
    Username = GetConvar('pxl_proxy_username', ''),
    Password = GetConvar('pxl_proxy_password', '')
}

-- Debug Configuration
Config.Debug = {
    Enabled = GetConvar('pxl_debug', 'false') == 'true',
    MaxLogs = tonumber(GetConvar('pxl_debug_maxlogs', '100')),
    Webhook = GetConvar('pxl_debug_webhook', ''),
    NoVersion = GetConvar('pxl_debug_noversion', 'false') == 'true'
}

-- Logging Settings
Config.LogTypes = {
    ['player_join'] = GetConvar('pxl_join', 'true') == 'true',
    ['player_leave'] = GetConvar('pxl_leave', 'true') == 'true',
    ['player_death'] = GetConvar('pxl_death', 'true') == 'true',
    ['player_chat'] = GetConvar('pxl_chat', 'true') == 'true',
    ['player_bans'] = GetConvar('pxl_bans', 'true') == 'true',
    ['player_kicks'] = GetConvar('pxl_kicks', 'true') == 'true',
    ['player_warns'] = GetConvar('pxl_warns', 'true') == 'true',
    ['player_commands'] = GetConvar('pxl_commands', 'true') == 'true',
    ['player_connections'] = GetConvar('pxl_connections', 'true') == 'true',
    ['player_resources'] = GetConvar('pxl_resources', 'true') == 'true',
    -- txAdmin Event Log Types
    ['txadmin_announcement'] = GetConvar('pxl_txadmin_announcement', 'true') == 'true',
    ['txadmin_shutdown'] = GetConvar('pxl_txadmin_shutdown', 'true') == 'true',
    ['txadmin_restart_skipped'] = GetConvar('pxl_txadmin_restart_skipped', 'true') == 'true',
    ['txadmin_direct_message'] = GetConvar('pxl_txadmin_direct_message', 'true') == 'true',
    ['txadmin_player_healed'] = GetConvar('pxl_txadmin_player_healed', 'true') == 'true',
    ['txadmin_whitelist_preapproval'] = GetConvar('pxl_txadmin_whitelist_preapproval', 'true') == 'true',
    ['txadmin_whitelist_request'] = GetConvar('pxl_txadmin_whitelist_request', 'true') == 'true',
    ['txadmin_action_revoked'] = GetConvar('pxl_txadmin_action_revoked', 'true') == 'true',
    ['txadmin_admin_auth'] = GetConvar('pxl_txadmin_admin_auth', 'true') == 'true',
    ['txadmin_admins_updated'] = GetConvar('pxl_txadmin_admins_updated', 'true') == 'true',
    ['txadmin_config_changed'] = GetConvar('pxl_txadmin_config_changed', 'true') == 'true',
    ['txadmin_console_command'] = GetConvar('pxl_txadmin_console_command', 'true') == 'true',
}

-- Identifier Settings
Config.Identifiers = {
    ['steam'] = GetConvar('pxl_steam', 'true') == 'true',
    ['discord'] = GetConvar('pxl_discord', 'true') == 'true',
    ['license'] = GetConvar('pxl_license', 'true') == 'true',
    ['xbox'] = GetConvar('pxl_xbox', 'true') == 'true',
    ['live'] = GetConvar('pxl_live', 'true') == 'true',
    ['fivem'] = GetConvar('pxl_fivem', 'true') == 'true',
    ['ip'] = GetConvar('pxl_ip', 'false') == 'true'
}

-- Avatar Configuration
Config.Avatars = {
    Enabled = GetConvar('pxl_avatars', 'true') == 'true',
    Default = GetConvar('pxl_default_avatar', 'https://i.imgur.com/example.png'),
    Types = {
        ['steam'] = GetConvar('pxl_steam_avatar', 'true') == 'true',
        ['discord'] = GetConvar('pxl_discord_avatar', 'true') == 'true',
        ['fivem'] = GetConvar('pxl_fivem_avatar', 'true') == 'true'
    }
}