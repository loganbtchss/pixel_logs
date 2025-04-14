# Customization Guide

This guide explains how to customize the appearance and content of your logs in Pixel Logs.

## Message Templates

Message templates define how different types of logs appear in Discord. You can customize these in `configs/messages.lua`.

### Basic Structure

Each message template follows this structure:

```lua
Config.Messages = {
    ['event_type'] = {
        title = 'Title of the embed',
        description = 'Main description with {placeholders}',
        fields = {
            {
                name = 'Field Name',
                value = 'Field value with {placeholders}',
                inline = true -- or false
            },
            -- More fields...
        }
    }
}
```

### Example: Player Death Template

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

## Available Placeholders

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
| `{cause}` | Death cause | Player Kill |
| `{coords}` | Exact coordinates | X: 123.45, Y: 67.89, Z: 10.0 |
| `{duration}` | Ban duration | 7 days |
| `{channel}` | Chat channel | global |

## Customizing Colors

You can customize the colors of different log types in `configs/config.lua`:

```lua
Config.Colors = {
    ['player_join'] = 65280,      -- Green
    ['player_leave'] = 16711680,  -- Red
    ['player_death'] = 16777215,  -- White
    ['chat_message'] = 3447003,   -- Blue
    ['command_used'] = 10181046,  -- Purple
    ['resource_start'] = 7419530, -- Teal
    ['resource_stop'] = 15158332, -- Orange
    ['player_banned'] = 15158332, -- Orange
    ['player_kicked'] = 16711680, -- Red
    ['player_warned'] = 16776960  -- Yellow
}
```

Color values are integers representing RGB colors. You can use online color pickers to find the right values.

## Discord Webhook Appearance

You can customize the appearance of your Discord webhook in `pixel_convars.cfg`:

```cfg
set pixel_logs_username "Your Server Name"
set pixel_logs_avatar "https://your-avatar-url.png"
```

## Player Avatars

You can customize how player avatars are displayed in logs:

```cfg
set pixel_logs_avatars "true"
set pixel_logs_default_avatar "https://i.imgur.com/example.png"
set pixel_logs_steam_avatar "true"
set pixel_logs_discord_avatar "true"
set pixel_logs_fivem_avatar "true"
```

## Identifier Display

You can customize which player identifiers are displayed in logs:

```cfg
set pixel_logs_steam "true"
set pixel_logs_discord "true"
set pixel_logs_license "true"
set pixel_logs_xbox "true"
set pixel_logs_live "true"
set pixel_logs_fivem "true"
set pixel_logs_ip "false"
```

## Creating Custom Log Types

You can create custom log types by adding them to the `Config.LogTypes` table in `configs/config.lua`:

```lua
Config.LogTypes = {
    ['custom_event'] = {
        enabled = true,
        color = 16777215 -- White
    }
}
```

Then, you can use this custom log type with the `SendCustomLog` export:

```lua
exports['pixel_logs']:SendCustomLog('custom_event', 'Your custom message', source, 16777215)
```

## Advanced Customization

### Custom Embed Formatting

For more advanced customization, you can use the `SendCustomEmbed` export to create fully custom embeds:

```lua
exports['pixel_logs']:SendCustomEmbed({
    color = 16777215,
    title = 'Custom Title',
    description = 'Custom description with **markdown** support',
    fields = {
        {name = 'Field 1', value = 'Value 1', inline = true},
        {name = 'Field 2', value = 'Value 2', inline = true}
    },
    thumbnail = {
        url = 'https://example.com/thumbnail.png'
    },
    image = {
        url = 'https://example.com/image.png'
    },
    footer = {
        text = 'Custom footer text',
        icon_url = 'https://example.com/icon.png'
    }
})
```

### Discord Markdown

You can use Discord's markdown formatting in your messages:

- **Bold**: `**text**`
- *Italic*: `*text*`
- ~~Strikethrough~~: `~~text~~`
- `Code`: `` `text` ``
- Code block: ` ```language\ncode\n``` `
- Underline: `__text__`

### Embed Limitations

Be aware of Discord's embed limitations:

- Title: Maximum 256 characters
- Description: Maximum 2048 characters
- Field name: Maximum 256 characters
- Field value: Maximum 1024 characters
- Total embed size: Maximum 6000 characters
- Maximum 25 fields per embed

## Related Documentation

- [Configuration Guide](configuration.md) - Configure appearance settings
- [Events Guide](events.md) - Learn about events that can be customized
- [Integration Guide](integration.md) - Examples of custom logs in other resources