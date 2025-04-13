# Debug System Guide

The debug system in Pixel Logs provides advanced logging capabilities for development, troubleshooting, and monitoring. This guide explains how to use and configure the debug system.

## Enabling Debug Mode

> [!IMPORTANT]
> Debug logging requires the `pixel_logs_debug` convar to be set to `true`.

To enable the debug system, set the following convar in your `pixel_convars.cfg`:

```cfg
set pixel_logs_debug "true"
```

## Debug Webhook

You can set a separate webhook for debug logs:

```cfg
set pixel_logs_debug_webhook "YOUR_DEBUG_WEBHOOK_URL"
```

If not set, debug logs will be sent to the main webhook.

## Debug Log Retention

Configure how many debug logs to keep in memory:

```cfg
set pixel_logs_debug_maxlogs "100"
```

## Adding Debug Logs

### Server-Side

```lua
-- Add a debug log with level, message, and optional data
exports['pixel_logs']:AddDebugLog(level, message, data)

-- Examples:
exports['pixel_logs']:AddDebugLog('info', 'Player joined the server', {
    player = source,
    name = GetPlayerName(source)
})

exports['pixel_logs']:AddDebugLog('warning', 'Low server performance', {
    fps = GetConvarInt('sv_maxclients', 32),
    players = #GetPlayers()
})

exports['pixel_logs']:AddDebugLog('error', 'Failed to process payment', {
    error = 'Invalid amount',
    player = source,
    amount = 1000
})
```

### Debug Log Levels

The following log levels are available:

- `info`: General information (blue)
- `warning`: Warnings (yellow)
- `error`: Errors (red)
- `debug`: Debug information (gray)

## Retrieving Debug Logs

### Get a Specific Log

```lua
-- Get a debug log by index (1-based)
local log = exports['pixel_logs']:GetDebugLog(1)
```

### Get All Logs

```lua
-- Get all debug logs
local logs = exports['pixel_logs']:GetAllDebugLogs()
```

### Clear Logs

```lua
-- Clear all debug logs
exports['pixel_logs']:ClearDebugLogs()
```

## Error Catching

> [!TIP]
> The CatchError export is a powerful tool for catching and logging errors in your code.

The debug system includes a powerful error catching mechanism:

```lua
-- Catch and log errors in a function
exports['pixel_logs']:CatchError(function()
    -- Your code here
    local result = someFunction()
    return result
end)

-- Catch and log errors with source and data
exports['pixel_logs']:CatchError('Failed to process payment', 'PaymentSystem', {
    player = source,
    amount = 1000
})
```

## Debug Log Format

Debug logs include the following information:

- **Level**: The log level (info, warning, error, debug)
- **Message**: The log message
- **Timestamp**: When the log was created
- **Data**: Additional data associated with the log
- **Resource**: The resource that created the log
- **Stack Trace**: For errors, a stack trace is included

## Using Debug Logs for Development

### Tracking Function Calls

```lua
-- Track function entry
exports['pixel_logs']:AddDebugLog('debug', 'Entering function: ProcessPayment', {
    player = source,
    amount = 1000
})

-- Your function code here

-- Track function exit
exports['pixel_logs']:AddDebugLog('debug', 'Exiting function: ProcessPayment', {
    player = source,
    result = 'success'
})
```

### Monitoring Performance

```lua
-- Start timing
local startTime = os.clock()

-- Your code here

-- End timing and log
local endTime = os.clock()
local duration = endTime - startTime

exports['pixel_logs']:AddDebugLog('info', 'Operation completed', {
    duration = string.format('%.4f seconds', duration),
    operation = 'Database Query'
})
```

### Tracking State Changes

```lua
-- Log state changes
local previousState = playerState
playerState = newState

exports['pixel_logs']:AddDebugLog('info', 'Player state changed', {
    player = source,
    previous = previousState,
    current = playerState,
    reason = reason
})
```

## Using Debug Logs for Troubleshooting

### Identifying Issues

> [!TIP]
> When troubleshooting, enable debug mode and add strategic debug logs at key points in your code.

When troubleshooting, enable debug mode and add strategic debug logs:

```lua
-- Add debug logs at key points in your code
exports['pixel_logs']:AddDebugLog('debug', 'Processing payment request', {
    player = source,
    amount = 1000
})

-- After validation
exports['pixel_logs']:AddDebugLog('debug', 'Payment validation passed', {
    player = source,
    amount = 1000
})

-- Before database operation
exports['pixel_logs']:AddDebugLog('debug', 'Updating database', {
    player = source,
    amount = 1000
})

-- After database operation
exports['pixel_logs']:AddDebugLog('debug', 'Database updated successfully', {
    player = source,
    amount = 1000
})
```

### Error Tracking

Use the CatchError export to catch and log errors:

```lua
exports['pixel_logs']:CatchError(function()
    -- Your code here
    local result = someFunction()
    return result
end)
```

## Best Practices

1. **Use Appropriate Log Levels**
   - Use `info` for general information
   - Use `warning` for potential issues
   - Use `error` for actual errors
   - Use `debug` for detailed debugging information

2. **Include Relevant Data**
   - Always include player IDs when relevant
   - Include timestamps for time-sensitive operations
   - Add context to make logs more useful

3. **Don't Over-log**
   - Only log what's necessary
   - Avoid logging sensitive information
   - Don't log too frequently for high-volume events

4. **Use Structured Data**
   - Use tables for complex data
   - Use consistent field names
   - Format data for readability

5. **Regular Maintenance**
   - Clear debug logs periodically
   - Review and adjust log retention settings
   - Disable debug mode in production when not needed 