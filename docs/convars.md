# Convars Guide

This guide explains what convars are and provides detailed information about all the convars used in Pixel Logs.

## What are Convars?

Convars (Configuration Variables) are a FiveM/RedM feature that allows you to store and retrieve configuration values that persist across server restarts. They are similar to environment variables in other systems and are commonly used for configuration in FiveM/RedM resources.

### How Convars Work

- Convars are set using the `set` command in your server configuration files
- They can be retrieved in Lua code using the `GetConvar` or `GetConvarInt` functions
- Convars persist across server restarts
- They can be changed at runtime without restarting the server

## Setting Convars

Convars are typically set in your server configuration files:

```cfg
# Basic syntax
set convar_name "value"

# Example
set pixel_logs_webhook "https://discord.com/api/webhooks/your-webhook-url"
```

## Required Convars

> [!IMPORTANT]
> These convars are **mandatory** for the resource to start. If any of these are not set, the resource will not initialize and will display an error message in the server console.

```cfg
# Discord webhook URL (required)
set pixel_logs_webhook "YOUR_DISCORD_WEBHOOK_URL"
```

## Webhook Settings

These convars control the appearance of your Discord webhook:

```cfg
# Webhook username (default: "Server Logs")
set pixel_logs_username "Server Logs"

# Webhook avatar URL (default: "")
set pixel_logs_avatar "https://example.com/avatar.png"
```

## Debug Settings

> [!TIP]
> Debug logging should only be enabled when needed as it can generate a large number of logs.

These convars control the debug system:

```cfg
# Enable debug mode (default: false)
set pixel_logs_debug "true"

# Maximum number of debug logs to keep in memory (default: 100)
set pixel_logs_debug_maxlogs "100"

# Optional separate webhook for debug logs (default: "")
set pixel_logs_debug_webhook "YOUR_DEBUG_WEBHOOK_URL"

# Skip version checks while keeping debug logging active (default: false)
set pixel_logs_debug_noversion "false"
```

## Proxy Settings

> [!TIP]
> Proxy support is useful when your server is behind a firewall or when you need to route Discord webhook requests through a specific proxy server.

These convars control proxy settings for Discord webhook requests:

```cfg
# Enable proxy support (default: false)
set pixel_logs_proxy_enabled "true"

# Proxy URL (default: "")
set pixel_logs_proxy_url "http://proxy.example.com:8080"

# Proxy username (default: "")
set pixel_logs_proxy_username "proxyuser"

# Proxy password (default: "")
set pixel_logs_proxy_password "proxypass"
```

## Log Type Toggles

These convars control which events are logged:

```cfg
# Player join logs (default: true)
set pixel_logs_join "true"

# Player leave logs (default: true)
set pixel_logs_leave "true"

# Player death logs (default: true)
set pixel_logs_death "true"

# Chat message logs (default: true)
set pixel_logs_chat "true"

# Ban logs (default: true)
set pixel_logs_bans "true"

# Kick logs (default: true)
set pixel_logs_kicks "true"

# Warning logs (default: true)
set pixel_logs_warns "true"

# Command usage logs (default: true)
set pixel_logs_commands "true"

# Connection logs (default: true)
set pixel_logs_connections "true"

# Resource start/stop logs (default: true)
set pixel_logs_resources "true"
```

## txAdmin Log Type Toggles

These convars control which txAdmin events are logged:

```cfg
# txAdmin announcement logs (default: true)
set pixel_logs_txadmin_announcement "true"

# txAdmin shutdown logs (default: true)
set pixel_logs_txadmin_shutdown "true"

# txAdmin restart skipped logs (default: true)
set pixel_logs_txadmin_restart_skipped "true"

# txAdmin direct message logs (default: true)
set pixel_logs_txadmin_direct_message "true"

# txAdmin player healed logs (default: true)
set pixel_logs_txadmin_player_healed "true"

# txAdmin whitelist preapproval logs (default: true)
set pixel_logs_txadmin_whitelist_preapproval "true"

# txAdmin whitelist request logs (default: true)
set pixel_logs_txadmin_whitelist_request "true"

# txAdmin action revoked logs (default: true)
set pixel_logs_txadmin_action_revoked "true"

# txAdmin admin auth logs (default: true)
set pixel_logs_txadmin_admin_auth "true"

# txAdmin admins updated logs (default: true)
set pixel_logs_txadmin_admins_updated "true"

# txAdmin config changed logs (default: true)
set pixel_logs_txadmin_config_changed "true"

# txAdmin console command logs (default: true)
set pixel_logs_txadmin_console_command "true"
```

## Identifier Settings

These convars control which player identifiers are displayed in logs:

```cfg
# Show Steam ID (default: true)
set pixel_logs_steam "true"

# Show Discord ID (default: true)
set pixel_logs_discord "true"

# Show License (default: true)
set pixel_logs_license "true"

# Show Xbox ID (default: true)
set pixel_logs_xbox "true"

# Show Live ID (default: true)
set pixel_logs_live "true"

# Show FiveM ID (default: true)
set pixel_logs_fivem "true"

# Show IP address (default: false)
set pixel_logs_ip "false"
```

## Avatar Settings

These convars control how player avatars are displayed in logs:

```cfg
# Enable player avatars (default: true)
set pixel_logs_avatars "true"

# Default avatar URL (default: "")
set pixel_logs_default_avatar "https://i.imgur.com/example.png"

# Use Steam avatars (default: true)
set pixel_logs_steam_avatar "true"

# Use Discord avatars (default: true)
set pixel_logs_discord_avatar "true"

# Use FiveM avatars (default: true)
set pixel_logs_fivem_avatar "true"
```

## Using Convars in Your Code

> [!NOTE]
> Always provide default values when retrieving convars in your code to ensure your code works even if a convar is not set.

You can access convars in your Lua code using the following functions:

```lua
-- Get a convar as a string
local webhook = GetConvar('pixel_logs_webhook', '')

-- Get a convar as an integer
local maxLogs = GetConvarInt('pixel_logs_debug_maxlogs', 100)

-- Get a convar as a boolean
local debugEnabled = GetConvar('pixel_logs_debug', 'false') == 'true'
```

## Best Practices

1. **Use a Separate Configuration File**
   - Keep all Pixel Logs convars in a separate file (e.g., `pixel_convars.cfg`)
   - Include this file in your `server.cfg` using the `exec` command

2. **Set Default Values**
   - Always provide default values when retrieving convars in your code
   - This ensures your code works even if a convar is not set

3. **Document Your Configuration**
   - Keep a copy of your convar settings for reference
   - Document any changes you make to the default settings

4. **Security Considerations**
   - Be careful with sensitive information in convars (e.g., webhook URLs)
   - Consider using environment variables for sensitive data

5. **Regular Maintenance**
   - Review your convar settings periodically
   - Update settings as needed when updating the resource

## Related Documentation

- [Configuration Guide](configuration.md) - Detailed configuration instructions
- [Installation Guide](installation.md) - Setting up convars during installation
- [Troubleshooting Guide](troubleshooting.md) - Solving convar-related issues