# Proxy Support Guide

This guide explains how to use and configure proxy support in Pixel Logs for sending Discord webhook requests through a proxy server.

## What is Proxy Support?

> [!IMPORTANT]
> Proxy support allows Pixel Logs to route Discord webhook requests through a proxy server, which is useful when your server is behind a firewall or when you need to use a specific network route.

Proxy support is particularly useful in the following scenarios:
- Your server is behind a corporate firewall that blocks direct connections to Discord
- You need to route webhook requests through a specific network for security reasons
- You're using a VPN or proxy service for your server
- You need to bypass regional restrictions

## Enabling Proxy Support

To enable proxy support, you need to configure the following convars in your `pixel_convars.cfg` file:

```cfg
# Enable proxy support
set pixel_logs_proxy_enabled "true"

# Set the proxy URL (required if proxy is enabled)
set pixel_logs_proxy_url "http://proxy.example.com:8080"

# Set proxy authentication (optional)
set pixel_logs_proxy_username "proxyuser"
set pixel_logs_proxy_password "proxypass"
```

## Proxy Configuration Options

### Proxy URL

The proxy URL should be in the following format:
- HTTP proxy: `http://proxy.example.com:8080`
- HTTPS proxy: `https://proxy.example.com:8080`
- SOCKS proxy: `socks5://proxy.example.com:1080`

> [!TIP]
> Make sure to use the correct protocol (http, https, socks5) for your proxy server.

### Authentication

If your proxy server requires authentication, you can set the username and password using the following convars:

```cfg
set pixel_logs_proxy_username "your_username"
set pixel_logs_proxy_password "your_password"
```

> [!CAUTION]
> Be careful with storing proxy credentials in your configuration files. Consider using environment variables or a secure credential manager for production environments.

## Testing Proxy Configuration

To test if your proxy configuration is working correctly:

1. Enable debug mode by setting `pixel_logs_debug` to `true`
2. Restart the Pixel Logs resource
3. Check the server console for any proxy-related error messages
4. Verify that logs are appearing in your Discord channel

## Troubleshooting Proxy Issues

### Common Issues

#### Connection Timeout

If you see connection timeout errors:

```
[ERROR] Failed to send webhook: Connection timed out
```

Possible solutions:
- Verify that the proxy server is running and accessible
- Check if the proxy URL is correct
- Ensure that the proxy server allows connections to Discord's webhook endpoints

#### Authentication Failed

If you see authentication errors:

```
[ERROR] Failed to send webhook: Proxy authentication failed
```

Possible solutions:
- Verify that the proxy username and password are correct
- Check if the proxy server requires a different authentication method

#### SSL/TLS Issues

If you see SSL/TLS errors:

```
[ERROR] Failed to send webhook: SSL handshake failed
```

Possible solutions:
- Ensure that your proxy server supports HTTPS connections
- Check if the proxy server has valid SSL certificates
- Try using an HTTP proxy instead of HTTPS if SSL is causing issues

### Debugging Proxy Issues

> [!TIP]
> Enable debug mode to get more detailed error information when troubleshooting proxy issues.

When debug mode is enabled, Pixel Logs will log detailed information about the proxy connection, including:
- The proxy URL being used
- Connection attempts
- Response status codes
- Error messages

## Advanced Proxy Configuration

### Custom Proxy Headers

If your proxy server requires custom headers, you can modify the `server/s_utils.lua` file to add them:

```lua
-- In the SendToDiscord function
local options = {
    url = webhookUrl,
    method = 'POST',
    headers = {
        ['Content-Type'] = 'application/json',
        ['User-Agent'] = 'Pixel Logs/1.0',
        -- Add custom headers here
        ['X-Custom-Header'] = 'Custom Value'
    },
    data = json.encode(data)
}
```

### Multiple Proxy Servers

If you need to use multiple proxy servers for different types of logs, you can create a custom function in your resource:

```lua
-- Example of using different proxies for different log types
local function SendToCustomProxy(logType, message, data)
    local proxyUrl = ""
    
    -- Select proxy based on log type
    if logType == "player_join" or logType == "player_leave" then
        proxyUrl = GetConvar("pixel_logs_proxy_url_players", "")
    elseif logType == "chat_message" or logType == "command_used" then
        proxyUrl = GetConvar("pixel_logs_proxy_url_chat", "")
    else
        proxyUrl = GetConvar("pixel_logs_proxy_url", "")
    end
    
    -- Set proxy URL for this request
    SetConvar("pixel_logs_proxy_url", proxyUrl)
    
    -- Send the log
    exports['pixel_logs']:SendCustomLog(logType, message, data)
    
    -- Reset to default proxy
    SetConvar("pixel_logs_proxy_url", GetConvar("pixel_logs_proxy_url_default", ""))
end
```

## Security Considerations

> [!CAUTION]
> When using a proxy server, be aware of the following security considerations:

1. **Data Privacy**: Ensure that your proxy server is secure and that data transmitted through it is encrypted.
2. **Credential Protection**: Avoid storing proxy credentials in plain text in your configuration files.
3. **Network Security**: Make sure your proxy server is properly configured to prevent unauthorized access.
4. **Logging**: Consider logging proxy connections for security auditing purposes.

## Best Practices

1. **Use HTTPS Proxies**: When possible, use HTTPS proxies to encrypt data transmitted through the proxy.
2. **Regular Testing**: Regularly test your proxy configuration to ensure it's working correctly.
3. **Fallback Mechanism**: Implement a fallback mechanism in case the proxy server is unavailable.
4. **Monitor Performance**: Monitor the performance impact of using a proxy server.
5. **Keep Configuration Updated**: Regularly update your proxy configuration to reflect changes in your network environment.

## Example Configurations

### Basic HTTP Proxy

```cfg
set pixel_logs_proxy_enabled "true"
set pixel_logs_proxy_url "http://proxy.example.com:8080"
```

### Authenticated HTTPS Proxy

```cfg
set pixel_logs_proxy_enabled "true"
set pixel_logs_proxy_url "https://proxy.example.com:8443"
set pixel_logs_proxy_username "proxyuser"
set pixel_logs_proxy_password "proxypass"
```

### SOCKS5 Proxy

```cfg
set pixel_logs_proxy_enabled "true"
set pixel_logs_proxy_url "socks5://proxy.example.com:1080"
``` 