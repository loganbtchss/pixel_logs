# Pixel Logs
This is an advanced Discord logging system for FiveM and RedM servers, providing comprehensive logging capabilities with a clean and modern interface.

## 🚀 Features

### 📝 Event Logging
- Player joins/leaves with detailed information
- Chat messages with channel tracking
- Player deaths with location and weapon details
- Command usage with arguments
- Administrative actions (bans/kicks/warns)
- Resource start/stop events
- Custom event support

### 🐛 Debug System
> [!IMPORTANT]
> Debug logging requires the `pixel_logs_debug` convar to be set to `true`.

- In-memory debug logging with configurable retention
- Separate debug webhook for critical errors
- Detailed error tracking with stack traces
- Automatic error catching and reporting
- Resource information included in error logs

### ⚙️ Configuration
> [!TIP]
> All configuration is done through convars in your server.cfg file.

- Per-event type toggling
- Customizable message templates
- Configurable identifier display
- Custom embed colors
- Player avatar support

### 💬 Discord Integration
- Rich embeds with dynamic fields
- Customizable webhook settings
- Clean message formatting
- Player identifier integration
- Automatic timestamp handling

## 📦 Installation

1. Download the latest release
2. Place the `pixel_logs` folder in your server's resources directory
3. Add `ensure pixel_logs` to your server.cfg
4. Configure the resource using the convars below

## ⚙️ Configuration

### Required Convars

```cfg
setr pixel_logs_webhook "YOUR_DISCORD_WEBHOOK_URL"
```

### Optional Convars

#### Webhook Settings
```cfg
setr pixel_logs_username "Server Logs" # Webhook username
setr pixel_logs_avatar "" # Webhook avatar URL
```

#### Debug Settings
```cfg
setr pixel_logs_debug "false" # Enable debug logging
setr pixel_logs_debug_maxlogs "100" # Maximum number of debug logs to keep
setr pixel_logs_debug_webhook "" # Optional separate webhook for debug logs
```

#### Log Type Toggles
```cfg
setr pixel_logs_join "true" # Player join logs
setr pixel_logs_leave "true" # Player leave logs
setr pixel_logs_death "true" # Player death logs
setr pixel_logs_chat "true" # Chat message logs
setr pixel_logs_bans "true" # Ban logs
setr pixel_logs_kicks "true" # Kick logs
setr pixel_logs_warns "true" # Warning logs
setr pixel_logs_commands "true" # Command usage logs
setr pixel_logs_connections "true" # Connection logs
setr pixel_logs_resources "true" # Resource start/stop logs
```

#### Identifier Settings
```cfg
setr pixel_logs_steam "true" # Show Steam ID
setr pixel_logs_discord "true" # Show Discord ID
setr pixel_logs_license "true" # Show License
setr pixel_logs_xbox "true" # Show Xbox ID
setr pixel_logs_live "true" # Show Live ID
setr pixel_logs_fivem "true" # Show FiveM ID
setr pixel_logs_ip "false" # Show IP address
```

#### Avatar Settings
```cfg
setr pixel_logs_avatars "true" # Enable player avatars
setr pixel_logs_default_avatar "https://i.imgur.com/example.png" # Default avatar URL
setr pixel_logs_steam_avatar "true" # Use Steam avatars
setr pixel_logs_discord_avatar "true" # Use Discord avatars
setr pixel_logs_fivem_avatar "true" # Use FiveM avatars
```

## 💻 Usage

### Basic Logging

> [!NOTE]
> Basic logging works out of the box with no additional setup required.

The resource automatically logs various events based on your configuration. No additional setup is required for basic logging.

### Custom Logs

You can send custom logs from any resource using the exports:

```lua
-- Server-side
exports['pixel_logs']:SendCustomLog('custom_type', 'Your message', source, color)

-- Client-side
exports['pixel_logs']:SendCustomLog('custom_type', 'Your message', color)
```

### Custom Embeds

For more control over the embed appearance:

```lua
-- Server-side
exports['pixel_logs']:SendCustomEmbed({
    color = 16711680,
    title = 'Custom Title',
    description = 'Custom Description',
    fields = {
        {name = 'Field 1', value = 'Value 1', inline = true},
        {name = 'Field 2', value = 'Value 2', inline = true}
    }
})

-- Client-side
exports['pixel_logs']:SendCustomEmbed({
    color = 16711680,
    title = 'Custom Title',
    description = 'Custom Description',
    fields = {
        {name = 'Field 1', value = 'Value 1', inline = true},
        {name = 'Field 2', value = 'Value 2', inline = true}
    }
})
```

### Debug Logging

> [!CAUTION]
> Debug logging should only be enabled when needed as it can generate a large number of logs.

When debug logging is enabled, you can add debug logs:

```lua
exports['pixel_logs']:AddDebugLog('error', 'Something went wrong', {
    error = 'Detailed error message',
    stack = 'Stack trace'
})
```

Debug logs will:
- Be stored in memory (up to the configured maximum)
- Create a Discord embed with the log information
- Include detailed error information and stack traces
- Use a separate webhook if configured

## 📝 Message Templates

> [!TIP]
> You can customize the message format for each event type in the config.

```lua
Config.Messages = {
    ['player_join'] = {
        title = 'Player Joined',
        description = '**{player}** has joined the server',
        fields = {
            {
                name = 'Player Information',
                value = '```\nName: {player}\nID: {id}\n```',
                inline = false
            }
        }
    }
}
```

### Available Placeholders

| Placeholder | Description | Example |
|------------|-------------|---------|
| `{player}` | Player name | Timmy Turner |
| `{admin}` | Admin name | Admin |
| `{reason}` | Reason for action | Breaking rules |
| `{message}` | Chat message | Hello world! |
| `{command}` | Command used | /kick |
| `{resource}` | Resource name | pixel_logs |
| `{action}` | Action performed | started |
| `{time}` | Timestamp | 2024-04-13 12:00:00 |
| `{id}` | Player ID | 1 |
| `{location}` | Location coordinates | 123.45, 67.89, 10.0 |
| `{killer}` | Killer name | Player2 |
| `{weapon}` | Weapon name | WEAPON_PISTOL |

## ❓ Support

> [!IMPORTANT]
> For support, feature requests, or bug reports, please:
> 1. Check the [GitHub Issues](https://github.com/ByteBrushStudios/pixel_logs/issues)
> 2. Join our [Discord Server](https://discord.gg/Vv2bdC44Ge)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Credits

- Developed by [Pixelated](https://codemeapixel.dev)
- Maintained by [ByteBrush Studios](https://github.com/ByteBrushStudios) 