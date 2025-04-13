# Pixel Logs Features

## 📝 Event Logging

Pixel Logs provides comprehensive event logging for your FiveM and RedM server:

- **Player Joins/Leaves**: Track when players connect and disconnect with detailed information
- **Chat Messages**: Log all chat messages with channel tracking
- **Player Deaths**: Record detailed death information including:
  - Death cause (Player Kill, Vehicle Accident, Animal Attack, Fire, Explosion, Drowning, Fall Damage, Suicide, Environmental)
  - Weapon/Death method details
  - Location and coordinates
  - Killer information (if applicable)
- **Command Usage**: Log all command usage with arguments
- **Administrative Actions**: Track bans, kicks, and warns with:
  - Duration support for bans
  - Reason tracking
  - Admin information
  - Player identifiers
- **Resource Events**: Monitor resource start/stop events
- **Custom Events**: Support for custom event logging
- **txAdmin Events**: Integration with txAdmin for server management events

## 🐛 Debug System

> [!IMPORTANT]
> Debug logging requires the `pixel_logs_debug` convar to be set to `true`.

The debug system provides powerful tools for troubleshooting and monitoring:

- **In-Memory Logging**: Store debug logs in memory with configurable retention
- **Separate Webhook**: Use a dedicated webhook for critical errors
- **Detailed Error Tracking**: Capture stack traces and error details
- **Automatic Error Catching**: Automatically catch and report errors
- **Resource Information**: Include resource details in error logs

## ⚙️ Configuration

Pixel Logs offers extensive configuration options:

- **Per-Event Toggling**: Enable or disable specific log types
- **Customizable Templates**: Modify message formats for each event type
- **Identifier Display**: Control which player identifiers are shown
- **Custom Embed Colors**: Set custom colors for different log types
- **Player Avatar Support**: Display player avatars in logs
- **Proxy Support**: Route Discord webhook requests through a proxy

## 💬 Discord Integration

Seamlessly integrate with Discord:

- **Webhook Support**: Send logs directly to Discord channels
- **Rich Embeds**: Use Discord's rich embed format for better readability
- **Custom Username/Avatar**: Set custom webhook username and avatar
- **Multiple Webhooks**: Use different webhooks for different log types
- **Proxy Support**: Route webhook requests through a proxy if needed 