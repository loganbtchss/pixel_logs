# Pixel Logs

An advanced Discord logging system for FiveM and RedM servers, providing comprehensive logging capabilities with a clean and modern interface.

## Features

- **Comprehensive Event Logging**
  - Player joins/leaves
  - Chat messages
  - Player deaths
  - Commands usage
  - Bans/Kicks/Warns
  - Resource start/stop
  - Custom events

- **Advanced Debug System**
  - Debug logging with file downloads
  - Separate debug webhook support
  - Configurable log retention
  - Detailed error tracking

- **Customizable Configuration**
  - Per-event type toggling
  - Customizable message templates
  - Configurable identifier display
  - Custom embed colors

- **Modern Discord Integration**
  - Rich embeds
  - Customizable webhook settings
  - Clean message formatting
  - Player identifier integration

## Installation

1. Download the latest release
2. Place the `pixel_logs` folder in your server's resources directory
3. Add `ensure pixel_logs` to your server.cfg
4. Configure the resource using the convars below

## Configuration

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

## Usage

### Basic Logging

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
- Include a download button for the full log
- Include any additional data provided

## Message Templates

You can customize the message format for each event type in the config:

```lua
Config.Messages = {
    ['player_join'] = '**{player}** has joined the server',
    ['player_leave'] = '**{player}** has left the server',
    -- ... other message templates
}
```

Available placeholders vary by event type:
- `{player}` - Player name
- `{admin}` - Admin name (for bans/kicks/warns)
- `{reason}` - Reason for action
- `{message}` - Chat message
- `{command}` - Command used
- `{resource}` - Resource name
- `{action}` - Action performed

## Support

For support, feature requests, or bug reports, please:
1. Check the [GitHub Issues](https://github.com/ByteBrushStudios/pixel_logs/issues)
2. Join our [Discord Server](https://discord.gg/Vv2bdC44Ge)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Credits

- Developed by [Pixelated](https://codemeapixel.dev)
- Maintained by [ByteBrush Studios](https://github.com/ByteBrushStudios) 