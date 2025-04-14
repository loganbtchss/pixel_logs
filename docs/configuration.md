# Configuration Guide

This guide provides detailed information about configuring Pixel Logs to suit your server's needs.

## Basic Configuration

> [!TIP]
> All basic configuration is done through the `pixel_convars.cfg` file. For a complete list of convars, see the [Convars Guide](convars.md).

The `pixel_convars.cfg` file contains all the basic configuration options for Pixel Logs. This file should be placed in your server's config directory and included in your `server.cfg` using the `exec` command.

```cfg
# Required: Discord webhook URL
set pixel_logs_webhook "YOUR_DISCORD_WEBHOOK_URL"

# Optional: Webhook username
set pixel_logs_username "Server Logs"

# Optional: Webhook avatar URL
set pixel_logs_avatar "https://example.com/avatar.png"

# Optional: Enable debug mode
set pixel_logs_debug "false"
```

## Advanced Configuration

> [!NOTE]
> Advanced configuration is done through the `configs/config.lua` file. This file contains more detailed configuration options that cannot be set through convars.

### Log Types

You can configure which events are logged by editing the `Config.LogTypes` table in `configs/config.lua`:

```lua
Config.LogTypes = {
    ['player_join'] = true,
    ['player_leave'] = true,
    ['player_death'] = true,
    ['chat_message'] = true,
    ['command_used'] = true,
    ['resource_start'] = true,
    ['resource_stop'] = true,
    ['ban_added'] = true,
    ['ban_removed'] = true,
    ['kick'] = true,
    ['warn'] = true
}
```

### Identifier Display

You can configure which player identifiers are displayed in logs by editing the `Config.Identifiers` table in `configs/config.lua`:

```lua
Config.Identifiers = {
    ['steam'] = true,
    ['discord'] = true,
    ['license'] = true,
    ['xbox'] = true,
    ['live'] = true,
    ['fivem'] = true,
    ['ip'] = false
}
```

## Event Configuration

> [!IMPORTANT]
> Some events require additional configuration to work properly. Make sure to check the specific requirements for each event type.

### Chat Events

Chat events are logged automatically when a player sends a message in the chat. You can configure which chat channels are logged by editing the `Config.ChatChannels` table in `configs/config.lua`:

```lua
Config.ChatChannels = {
    ['global'] = true,
    ['local'] = true,
    ['ooc'] = true,
    ['me'] = true,
    ['do'] = true
}
```

### Command Events

Command events are logged automatically when a player uses a command. You can configure which commands are logged by editing the `Config.Commands` table in `configs/config.lua`:

```lua
Config.Commands = {
    ['all'] = true, -- Log all commands
    ['specific'] = { -- Log specific commands
        ['kick'] = true,
        ['ban'] = true,
        ['warn'] = true
    }
}
```

### Death Events

Death events are logged automatically when a player dies. You can configure which death causes are logged by editing the `Config.DeathCauses` table in `configs/config.lua`:

```lua
Config.DeathCauses = {
    ['player_kill'] = true,
    ['vehicle'] = true,
    ['animal'] = true,
    ['fire'] = true,
    ['explosion'] = true,
    ['drowning'] = true,
    ['fall'] = true,
    ['suicide'] = true,
    ['environmental'] = true
}
```

## Debug Configuration

> [!CAUTION]
> Debug mode should only be enabled when needed as it can generate a large number of logs.

Debug mode can be enabled by setting the `pixel_logs_debug` convar to `true` in your `pixel_convars.cfg` file:

```cfg
set pixel_logs_debug "true"
```

You can also configure a separate webhook for debug logs:

```cfg
set pixel_logs_debug_webhook "YOUR_DEBUG_WEBHOOK_URL"
```

## Proxy Configuration

> [!TIP]
> Proxy support is useful when your server is behind a firewall or when you need to route Discord webhook requests through a specific proxy server.

Proxy support can be enabled by setting the following convars in your `pixel_convars.cfg` file:

```cfg
set pixel_logs_proxy_enabled "true"
set pixel_logs_proxy_url "http://proxy.example.com:8080"
set pixel_logs_proxy_username "proxyuser"
set pixel_logs_proxy_password "proxypass"
```

## Customization

### Discord Appearance

You can customize the appearance of your Discord logs by editing the `Config.Colors` table in `configs/config.lua`:

```lua
Config.Colors = {
    ['player_join'] = 65280, -- Green
    ['player_leave'] = 16711680, -- Red
    ['player_death'] = 16711680, -- Red
    ['chat_message'] = 255, -- Blue
    ['command_used'] = 16776960, -- Yellow
    ['resource_start'] = 65280, -- Green
    ['resource_stop'] = 16711680, -- Red
    ['ban_added'] = 16711680, -- Red
    ['ban_removed'] = 65280, -- Green
    ['kick'] = 16711680, -- Red
    ['warn'] = 16776960 -- Yellow
}
```

### Message Templates

> [!TIP]
> You can customize the message format for each event type in the `configs/messages.lua` file.

You can customize the message format for each event type by editing the `Config.Messages` table in `configs/messages.lua`:

```lua
Config.Messages = {
    ['player_death'] = {
        title = 'Player Death',
        description = '**{player}** has died',
        fields = {
            {
                name = 'Player Information',
                value = '```\nName: {player}\nID: {id}\n```',
                inline = false
            },
            {
                name = 'Death Cause',
                value = '{cause}',
                inline = true
            },
            {
                name = 'Location',
                value = '{location}',
                inline = true
            },
            {
                name = 'Coordinates',
                value = '{coords}',
                inline = false
            }
        }
    }
}
```

For a complete list of available placeholders, see the [Customization Guide](customization.md).

## Related Documentation

- [Customization Guide](customization.md) - Detailed message template customization
- [Events Guide](events.md) - Events that can be configured
- [Convars Guide](convars.md) - Configuration through convars