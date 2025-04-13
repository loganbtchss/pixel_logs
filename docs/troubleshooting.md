# Troubleshooting Guide

This guide addresses common issues you might encounter with Pixel Logs and provides solutions.

## Logs Not Appearing in Discord

### Check Webhook Configuration
- Verify that your webhook URL is correctly set in `pixel_convars.cfg`
- Ensure the webhook URL is valid and active
- Check if the webhook has proper permissions in your Discord server

### Check Resource Status
- Verify that the resource is started in your server.cfg
- Check server console for any error messages during startup
- Ensure the resource is loading in the correct order

### Debug Mode
Enable debug mode to get more detailed information:
```cfg
set pixel_logs_debug "true"
```

## Resource Fails to Start

### Missing Required Convars
- Ensure all required convars are set in `pixel_convars.cfg`
- Check that the webhook URL is properly configured

### Version Check Issues
If you're having issues with version checks, you can disable them:
```cfg
set pixel_logs_debug_noversion "true"
```

### Lua Version Compatibility
- Ensure your server is running a compatible Lua version
- Pixel Logs requires Lua 5.4

## Performance Issues

### Too Many Logs
If you're experiencing performance issues due to excessive logging:
- Reduce the number of event types being logged
- Increase the interval between logs for high-frequency events
- Use a separate webhook for different log types

### Memory Usage
If debug logs are consuming too much memory:
- Reduce the maximum number of debug logs:
```cfg
set pixel_logs_debug_maxlogs "50"
```
- Clear debug logs periodically using the `ClearDebugLogs` export

## Proxy Issues

### Connection Problems
If you're using a proxy and experiencing connection issues:
- Verify proxy settings in `pixel_convars.cfg`
- Check if the proxy server is accessible
- Ensure proxy credentials are correct

### Timeout Errors
If you're getting timeout errors:
- Increase the timeout value in the configuration
- Check network connectivity between your server and the proxy

## Custom Log Issues

### Logs Not Showing
If your custom logs aren't appearing:
- Verify that the log type is enabled in the configuration
- Check if the export is being called correctly
- Ensure the message format follows the expected structure

### Embed Formatting
If your custom embeds aren't displaying correctly:
- Verify that all required fields are included
- Check that the color value is a valid integer
- Ensure field values don't exceed Discord's character limits

## txAdmin Integration

### txAdmin Events Not Logging
If txAdmin events aren't being logged:
- Verify that txAdmin is properly installed and running
- Check that txAdmin event logging is enabled in the configuration
- Ensure the txAdmin webhook is correctly configured

## Getting Additional Help

If you're still experiencing issues after trying these solutions:

1. Check the [GitHub Issues](https://github.com/ByteBrushStudios/pixel_logs/issues) for similar problems
2. Join our [Discord Server](https://discord.gg/Vv2bdC44Ge) for direct support
3. Enable debug mode and share the logs with our support team 