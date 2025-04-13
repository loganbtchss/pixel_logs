# Pixel Logs - Convars Configuration

This file contains all the convars used by Pixel Logs. You can include this file in your server.cfg to easily configure all Pixel Logs settings.

## How to Use

1. Copy the `pixel_convars.cfg` file to your server's config directory (usually the same directory as your server.cfg)
2. Edit the file to set your desired values
3. Add the following line to your server.cfg:

```cfg
exec "pixel_convars.cfg"
```

## Required Convars

The following convars are **required** for Pixel Logs to function:

```cfg
set pixel_logs_webhook "YOUR_DISCORD_WEBHOOK_URL"
```

Replace `YOUR_DISCORD_WEBHOOK_URL` with your actual Discord webhook URL.

## Customizing Settings

You can customize any of the settings in the pixel_convars.cfg file to match your server's needs. All settings are documented with comments explaining their purpose.

## Categories

The convars are organized into the following categories:

- **Required Convars**: Essential settings that must be configured
- **Webhook Settings**: Customize the appearance of your Discord webhook
- **Proxy Settings**: Configure proxy support for Discord webhooks
- **Debug Settings**: Control debug logging behavior
- **Log Type Toggles**: Enable/disable specific log types
- **txAdmin Log Type Toggles**: Enable/disable txAdmin-specific log types
- **Identifier Settings**: Control which player identifiers are displayed
- **Avatar Settings**: Configure player avatar display

## Example Configuration

Here's an example of a minimal configuration:

```cfg
# Required
set pixel_logs_webhook "https://discord.com/api/webhooks/your-webhook-url"

# Optional but recommended
set pixel_logs_username "My Server Logs"
set pixel_logs_debug "false"
set pixel_logs_avatars "true"
```

## Troubleshooting

If you encounter issues with Pixel Logs:

1. Make sure the required webhook URL is correctly set
2. Check that the webhook URL is valid and accessible
3. Enable debug logging by setting `pixel_logs_debug` to `true`
4. Check your server console for any error messages 