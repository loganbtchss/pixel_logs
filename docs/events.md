# Pixel Logs Events & Exports

This document lists all the events and exports that the Pixel Logs resource makes available for other resources to use.

## Server Exports

### Basic Logging

```lua
-- Send a custom log with a specific type and message
exports['pixel_logs']:SendCustomLog(messageType, message, source, color)
-- Example:
exports['pixel_logs']:SendCustomLog('custom_event', 'Player completed a mission', source, 65280)

-- Send a custom embed with full control over the appearance
exports['pixel_logs']:SendCustomEmbed(embed)
-- Example:
exports['pixel_logs']:SendCustomEmbed({
    color = 16711680,
    title = 'Custom Event',
    description = 'A custom event occurred',
    fields = {
        {name = 'Field 1', value = 'Value 1', inline = true},
        {name = 'Field 2', value = 'Value 2', inline = true}
    }
})
```

### Debug Logging

```lua
-- Add a debug log entry
exports['pixel_logs']:AddDebugLog(type, message, data)
-- Example:
exports['pixel_logs']:AddDebugLog('error', 'Failed to process payment', {
    error = 'Invalid amount',
    player = source,
    amount = 1000
})

-- Get a specific debug log by index
exports['pixel_logs']:GetDebugLog(index)
-- Example:
local log = exports['pixel_logs']:GetDebugLog(1)

-- Get all debug logs
exports['pixel_logs']:GetAllDebugLogs()
-- Example:
local logs = exports['pixel_logs']:GetAllDebugLogs()

-- Clear all debug logs
exports['pixel_logs']:ClearDebugLogs()
-- Example:
exports['pixel_logs']:ClearDebugLogs()

-- Catch and log errors
exports['pixel_logs']:CatchError(error, source, data)
-- Example:
exports['pixel_logs']:CatchError('Failed to process payment', 'PaymentSystem', {
    player = source,
    amount = 1000
})
```

### Utility Functions

```lua
-- Get the Utils object for advanced usage
local Utils = exports['pixel_logs']:GetUtils()
-- Example:
local Utils = exports['pixel_logs']:GetUtils()
Utils.SendToDiscord('custom_type', 'Custom message', source)
```

## Client Exports

### Basic Logging

```lua
-- Send a custom log from the client
exports['pixel_logs']:SendCustomLog(messageType, message, color)
-- Example:
exports['pixel_logs']:SendCustomLog('client_event', 'Player entered a zone', 65280)

-- Send a custom embed from the client
exports['pixel_logs']:SendCustomEmbed(embed)
-- Example:
exports['pixel_logs']:SendCustomEmbed({
    color = 16711680,
    title = 'Client Event',
    description = 'A client-side event occurred',
    fields = {
        {name = 'Location', value = 'Zone 1', inline = true},
        {name = 'Time', value = os.date(), inline = true}
    }
})
```

## Server Events

### Custom Log Events

```lua
-- Listen for custom log events
AddEventHandler('pixel_logs:customLog', function(type, message, color)
    -- Your code here
end)

-- Listen for custom embed events
AddEventHandler('pixel_logs:customEmbed', function(embed)
    -- Your code here
end)
```

### Player Events

```lua
-- Listen for player join events
AddEventHandler('pixel_logs:playerJoin', function()
    -- Your code here
end)

-- Listen for player leave events
AddEventHandler('pixel_logs:playerLeave', function()
    -- Your code here
end)

-- Listen for player death events
AddEventHandler('pixel_logs:playerDeath', function(data)
    -- Your code here
    -- data contains: cause, weapon, killer, location, coords
end)
```

### Resource Events

```lua
-- Listen for resource start events
AddEventHandler('pixel_logs:resourceStarted', function(resourceName)
    -- Your code here
end)

-- Listen for resource stop events
AddEventHandler('pixel_logs:resourceStopped', function(resourceName)
    -- Your code here
end)
```

### Chat Events

```lua
-- Listen for chat message events
AddEventHandler('pixel_logs:chatMessage', function(playerId, message, channel)
    -- Your code here
end)
```

### Command Events

```lua
-- Listen for command usage events
AddEventHandler('pixel_logs:commandUsed', function(playerId, command, args)
    -- Your code here
end)
```

### Administrative Events

```lua
-- Listen for ban events
AddEventHandler('pixel_logs:playerBanned', function(data)
    -- Your code here
    -- data contains: admin, target, reason, duration
end)

-- Listen for kick events
AddEventHandler('pixel_logs:playerKicked', function(data)
    -- Your code here
    -- data contains: admin, target, reason
end)

-- Listen for warning events
AddEventHandler('pixel_logs:playerWarned', function(data)
    -- Your code here
    -- data contains: admin, target, reason
end)
```

### txAdmin Events

```lua
-- Listen for txAdmin announcement events
AddEventHandler('pixel_logs:txAdminAnnouncement', function(data)
    -- Your code here
end)

-- Listen for txAdmin shutdown events
AddEventHandler('pixel_logs:txAdminShutdown', function(data)
    -- Your code here
end)

-- Listen for txAdmin direct message events
AddEventHandler('pixel_logs:txAdminDirectMessage', function(data)
    -- Your code here
end)
```

## Client Events

### Weapon Events

```lua
-- Listen for weapon fired events
AddEventHandler('pixel_logs:weaponFired', function(data)
    -- Your code here
    -- data contains: weapon, ammo, damage, target
end)
```

## Examples

### Server-Side Example

```lua
-- Log a custom event with player information
local function LogMissionCompletion(playerId, missionName, reward)
    local player = GetPlayerName(playerId)
    exports['pixel_logs']:SendCustomEmbed({
        color = 65280, -- Green
        title = 'Mission Completed',
        description = string.format('**%s** completed mission **%s**', player, missionName),
        fields = {
            {name = 'Player', value = player, inline = true},
            {name = 'Mission', value = missionName, inline = true},
            {name = 'Reward', value = string.format('$%s', reward), inline = true}
        }
    })
end
```

### Client-Side Example

```lua
-- Log zone entry with custom data
local function LogZoneEntry(zoneName, zoneType)
    exports['pixel_logs']:SendCustomEmbed({
        color = 3447003, -- Blue
        title = 'Zone Entered',
        description = string.format('Player entered **%s** zone', zoneName),
        fields = {
            {name = 'Zone Name', value = zoneName, inline = true},
            {name = 'Zone Type', value = zoneType, inline = true},
            {name = 'Time', value = os.date(), inline = true}
        }
    })
end
```

# Events Guide

This guide provides detailed information about the events that Pixel Logs listens to and logs to Discord.

## Server Events

> [!IMPORTANT]
> Server events are handled by the `server/s_events.lua` file. These events are triggered on the server side and can be logged to Discord.

### Player Events

#### Player Join

```lua
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    -- Event data
    local playerId = source
    local playerName = GetPlayerName(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog('player_join', 'Player joined the server', playerId, 65280)
end)
```

#### Player Leave

```lua
AddEventHandler('playerDropped', function(reason)
    -- Event data
    local playerId = source
    local playerName = GetPlayerName(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog('player_leave', 'Player left the server', playerId, 16711680)
end)
```

#### Player Death

```lua
RegisterNetEvent('pixel_logs:playerDeath')
AddEventHandler('pixel_logs:playerDeath', function(data)
    -- Event data
    local playerId = source
    local playerName = GetPlayerName(playerId)
    local deathCause = data.cause
    local weapon = data.weapon
    local killer = data.killer
    local location = data.location
    local coords = data.coords
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog('player_death', 'Player died', playerId, 16711680)
end)
```

### Chat Events

#### Chat Message

```lua
AddEventHandler('chatMessage', function(source, name, message)
    -- Event data
    local playerId = source
    local playerName = name
    local chatMessage = message
    local channel = 'global'
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog('chat_message', 'Chat message', playerId, 255)
end)
```

### Command Events

#### Command Used

```lua
AddEventHandler('chatMessage', function(source, name, message)
    -- Check if the message is a command
    if string.sub(message, 1, 1) == '/' then
        -- Event data
        local playerId = source
        local playerName = name
        local command = string.sub(message, 2)
        
        -- Log the event
        exports['pixel_logs']:SendCustomLog('command_used', 'Command used', playerId, 16776960)
    end
end)
```

### Administrative Events

#### Ban Added

```lua
RegisterNetEvent('pixel_logs:banAdded')
AddEventHandler('pixel_logs:banAdded', function(data)
    -- Event data
    local adminId = source
    local adminName = GetPlayerName(adminId)
    local playerId = data.playerId
    local playerName = data.playerName
    local reason = data.reason
    local duration = data.duration
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog('ban_added', 'Player banned', adminId, 16711680)
end)
```

#### Ban Removed

```lua
RegisterNetEvent('pixel_logs:banRemoved')
AddEventHandler('pixel_logs:banRemoved', function(data)
    -- Event data
    local adminId = source
    local adminName = GetPlayerName(adminId)
    local playerId = data.playerId
    local playerName = data.playerName
    local reason = data.reason
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog('ban_removed', 'Player unbanned', adminId, 65280)
end)
```

#### Kick

```lua
RegisterNetEvent('pixel_logs:playerKicked')
AddEventHandler('pixel_logs:playerKicked', function(data)
    -- Event data
    local adminId = source
    local adminName = GetPlayerName(adminId)
    local playerId = data.playerId
    local playerName = data.playerName
    local reason = data.reason
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog('kick', 'Player kicked', adminId, 16711680)
end)
```

#### Warn

```lua
RegisterNetEvent('pixel_logs:playerWarned')
AddEventHandler('pixel_logs:playerWarned', function(data)
    -- Event data
    local adminId = source
    local adminName = GetPlayerName(adminId)
    local playerId = data.playerId
    local playerName = data.playerName
    local reason = data.reason
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog('warn', 'Player warned', adminId, 16776960)
end)
```

### Resource Events

#### Resource Start

```lua
AddEventHandler('onResourceStart', function(resourceName)
    -- Event data
    local resource = resourceName
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog('resource_start', 'Resource started', -1, 65280)
end)
```

#### Resource Stop

```lua
AddEventHandler('onResourceStop', function(resourceName)
    -- Event data
    local resource = resourceName
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog('resource_stop', 'Resource stopped', -1, 16711680)
end)
```

### txAdmin Events

> [!TIP]
> txAdmin events are only logged if txAdmin is installed on your server.

#### Announcement

```lua
RegisterNetEvent('txAdmin:events:announcement')
AddEventHandler('txAdmin:events:announcement', function(data)
    -- Event data
    local message = data.message
    local author = data.author
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog('txadmin_announcement', 'Announcement', -1, 16776960)
end)
```

#### Shutdown

```lua
RegisterNetEvent('txAdmin:events:shutdown')
AddEventHandler('txAdmin:events:shutdown', function(data)
    -- Event data
    local author = data.author
    local reason = data.reason
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog('txadmin_shutdown', 'Server shutdown', -1, 16711680)
end)
```

## Client Events

> [!NOTE]
> Client events are handled by the `client/c_events.lua` file. These events are triggered on the client side and can be logged to Discord.

### Weapon Events

#### Weapon Used

```lua
RegisterNetEvent('pixel_logs:weaponUsed')
AddEventHandler('pixel_logs:weaponUsed', function(data)
    -- Event data
    local playerId = GetPlayerServerId(PlayerId())
    local weapon = data.weapon
    local target = data.target
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog('weapon_used', 'Weapon used', playerId, 16776960)
end)
```

## Custom Events

> [!TIP]
> You can create your own custom events and log them to Discord using the `SendCustomLog` export.

### Server-Side

```lua
-- Trigger a custom event
TriggerEvent('pixel_logs:customEvent', {
    type = 'custom_type',
    message = 'Custom message',
    data = {
        field1 = 'value1',
        field2 = 'value2'
    }
})

-- Handle the custom event
RegisterNetEvent('pixel_logs:customEvent')
AddEventHandler('pixel_logs:customEvent', function(data)
    -- Event data
    local playerId = source
    local playerName = GetPlayerName(playerId)
    local eventType = data.type
    local message = data.message
    local eventData = data.data
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog(eventType, message, playerId, 16776960)
end)
```

### Client-Side

```lua
-- Trigger a custom event
TriggerEvent('pixel_logs:customEvent', {
    type = 'custom_type',
    message = 'Custom message',
    data = {
        field1 = 'value1',
        field2 = 'value2'
    }
})

-- Handle the custom event
RegisterNetEvent('pixel_logs:customEvent')
AddEventHandler('pixel_logs:customEvent', function(data)
    -- Event data
    local playerId = GetPlayerServerId(PlayerId())
    local eventType = data.type
    local message = data.message
    local eventData = data.data
    
    -- Log the event
    exports['pixel_logs']:SendCustomLog(eventType, message, playerId, 16776960)
end)
```

## Event Configuration

> [!IMPORTANT]
> You can configure which events are logged by editing the `Config.LogTypes` table in `configs/config.lua`.

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

## Event Colors

> [!TIP]
> You can customize the colors of your event logs by editing the `Config.Colors` table in `configs/config.lua`.

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

## Related Documentation

- [Customization Guide](customization.md) - Learn how to customize message templates and colors
- [Integration Guide](integration.md) - See examples of integrating events with other resources
- [Debug Guide](debug.md) - Use the debug system to troubleshoot event issues