# Installation Guide

This guide provides detailed instructions for installing and setting up Pixel Logs on your FiveM or RedM server.

## Prerequisites

> [!IMPORTANT]
> Before installing Pixel Logs, ensure you have:
> - A FiveM or RedM server
> - A Discord webhook URL
> - Basic knowledge of server configuration

## Installation Steps

### 1. Download the Resource

> [!TIP]
> Always download the latest release from the official GitHub repository to ensure you have the most up-to-date version.

1. Visit the [GitHub repository](https://github.com/ByteBrushStudios/pixel_logs/releases)
2. Download the latest release ZIP file
3. Extract the contents to your server's resources directory

### 2. Configure the Discord Webhook

1. Create a new webhook in your Discord server:
   - Go to Server Settings > Integrations > Webhooks
   - Click "New Webhook"
   - Give it a name (e.g., "Server Logs")
   - Copy the webhook URL

2. Set the webhook URL in your server configuration:
   - Open your `pixel_convars.cfg` file
   - Set the `pixel_logs_webhook` convar to your webhook URL:
     ```cfg
     set pixel_logs_webhook "YOUR_DISCORD_WEBHOOK_URL"
     ```

### 3. Configure Convars

> [!NOTE]
> For a complete list of available convars, see the [Convars Guide](convars.md).

1. Open the `pixel_convars.cfg` file
2. Review and adjust the settings as needed
3. Save the file

### 4. Enable the Resource

1. Open your `server.cfg` file
2. Add the following line:
   ```cfg
   ensure pixel_logs
   ```
3. Add the following line to load your convar settings:
   ```cfg
   exec "pixel_convars.cfg"
   ```

### 5. Restart Your Server

1. Save all changes
2. Restart your server or use the `refresh` and `ensure pixel_logs` commands in the server console

## Verification

> [!TIP]
> After installation, verify that Pixel Logs is working correctly by checking your Discord channel for logs.

1. Check your server console for any error messages
2. Join your server with a test account
3. Verify that join logs appear in your Discord channel
4. Test other logging features (chat, commands, etc.)

## Troubleshooting

> [!CAUTION]
> If you encounter issues during installation, enable debug mode to get more detailed error information.

### Logs Not Appearing

- Verify your webhook URL is correct
- Check your server console for error messages
- Ensure the resource is started (use `ensure pixel_logs` in the console)
- Check your Discord channel permissions

### Resource Not Starting

- Verify all required convars are set
- Check for syntax errors in your configuration files
- Enable debug mode to get more detailed error information

### Debug Mode

To enable debug mode, set the following convar:
```cfg
set pixel_logs_debug "true"
```

This will provide more detailed error information in your server console and Discord logs.

## Configuration

### Basic Configuration

The basic configuration is handled through convars in `pixel_convars.cfg`. See [Configuration](configuration.md) for detailed information.

### Advanced Configuration

For advanced configuration, you can modify the following files:

- `configs/config.lua`: Main configuration file
- `configs/identifiers.lua`: Identifier configuration
- `configs/templates.lua`: Message templates

## Verification

To verify the installation:

1. Start your server
2. Check the server console for the Pixel Logs startup message
3. Join the server and perform some actions
4. Check your Discord channel for logs

## Troubleshooting

If you encounter issues:

1. **No Logs Appearing**
   - Verify your webhook URL is correct
   - Check if the resource is started
   - Ensure the log type is enabled

2. **Resource Not Starting**
   - Check for errors in the server console
   - Verify all dependencies are installed
   - Ensure the resource name is correct in `server.cfg`

3. **Debug Mode**
   - Enable debug mode by setting `pixel_logs_debug` to `true`
   - Check the debug webhook for detailed error information 