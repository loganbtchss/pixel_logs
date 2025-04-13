# Integration Guide

This guide explains how to integrate Pixel Logs with other resources and systems.

## Basic Integration

### Server-Side Integration

To log events from your resource, use the server exports:

```lua
-- Log a simple event
exports['pixel_logs']:SendCustomLog('your_event_type', 'Your message', source, 65280)

-- Log a detailed event with custom embed
exports['pixel_logs']:SendCustomEmbed({
    color = 65280,
    title = 'Event Title',
    description = 'Event description',
    fields = {
        {name = 'Field 1', value = 'Value 1', inline = true},
        {name = 'Field 2', value = 'Value 2', inline = true}
    }
})
```

### Client-Side Integration

To log events from the client side:

```lua
-- Log a simple event
exports['pixel_logs']:SendCustomLog('client_event', 'Client-side event', 65280)

-- Log a detailed event with custom embed
exports['pixel_logs']:SendCustomEmbed({
    color = 65280,
    title = 'Client Event',
    description = 'Client-side event description',
    fields = {
        {name = 'Location', value = 'Zone 1', inline = true},
        {name = 'Time', value = os.date(), inline = true}
    }
})
```

## Common Integration Scenarios

### Logging Player Actions

```lua
-- Log when a player completes a mission
RegisterNetEvent('your_resource:missionCompleted')
AddEventHandler('your_resource:missionCompleted', function(missionName, reward)
    local source = source
    local player = GetPlayerName(source)
    
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
end)
```

### Logging Administrative Actions

```lua
-- Log when an admin performs an action
RegisterNetEvent('your_resource:adminAction')
AddEventHandler('your_resource:adminAction', function(target, action, reason)
    local source = source
    local admin = GetPlayerName(source)
    local targetPlayer = GetPlayerName(target)
    
    exports['pixel_logs']:SendCustomEmbed({
        color = 16711680, -- Red
        title = 'Administrative Action',
        description = string.format('**%s** performed action **%s** on **%s**', admin, action, targetPlayer),
        fields = {
            {name = 'Admin', value = admin, inline = true},
            {name = 'Target', value = targetPlayer, inline = true},
            {name = 'Action', value = action, inline = true},
            {name = 'Reason', value = reason, inline = false}
        }
    })
end)
```

### Logging Resource Events

```lua
-- Log when your resource starts or stops
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        exports['pixel_logs']:SendCustomLog('resource_start', 'Your resource has started', -1, 7419530)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        exports['pixel_logs']:SendCustomLog('resource_stop', 'Your resource has stopped', -1, 15158332)
    end
end)
```

## Advanced Integration

### Using the Utils Object

For more advanced integration, you can use the Utils object:

```lua
local Utils = exports['pixel_logs']:GetUtils()

-- Use Utils functions directly
Utils.SendToDiscord('custom_type', 'Custom message', source)
Utils.CreateEmbed('custom_type', 'Custom message', source, 65280)
Utils.SendEmbedToDiscord(embed)
```

### Error Handling

Use the CatchError export to log errors:

```lua
exports['pixel_logs']:CatchError(function()
    -- Your code here
    local result = someFunction()
    return result
end)
```

### Debug Logging

For development and troubleshooting:

```lua
if Config.Debug.Enabled then
    exports['pixel_logs']:AddDebugLog('info', 'Processing payment', {
        amount = 1000,
        player = source
    })
end
```

## Integration with Popular Resources

### ESX Integration

```lua
-- Log when a player's money changes
RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        exports['pixel_logs']:SendCustomEmbed({
            color = 3447003, -- Blue
            title = 'Money Changed',
            description = string.format('**%s**\'s money has changed', xPlayer.getName()),
            fields = {
                {name = 'Player', value = xPlayer.getName(), inline = true},
                {name = 'Account', value = account.name, inline = true},
                {name = 'New Balance', value = string.format('$%s', account.money), inline = true}
            }
        })
    end
end)
```

### QBCore Integration

```lua
-- Log when a player's money changes
RegisterNetEvent('QBCore:Server:OnMoneyChange')
AddEventHandler('QBCore:Server:OnMoneyChange', function(source, changeType, amount, isMinus)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player then
        exports['pixel_logs']:SendCustomEmbed({
            color = 3447003, -- Blue
            title = 'Money Changed',
            description = string.format('**%s**\'s money has changed', Player.PlayerData.name),
            fields = {
                {name = 'Player', value = Player.PlayerData.name, inline = true},
                {name = 'Type', value = changeType, inline = true},
                {name = 'Amount', value = string.format('$%s', amount), inline = true},
                {name = 'Operation', value = isMinus and 'Subtraction' or 'Addition', inline = true}
            }
        })
    end
end)
```

### vRP Integration

```lua
-- Log when a player's money changes
RegisterServerEvent('vrp:updateMoney')
AddEventHandler('vrp:updateMoney', function(source, wallet, bank)
    local user_id = vRP.getUserId(source)
    
    if user_id then
        local player = vRP.getUserIdentity(user_id)
        
        exports['pixel_logs']:SendCustomEmbed({
            color = 3447003, -- Blue
            title = 'Money Changed',
            description = string.format('**%s %s**\'s money has changed', player.name, player.firstname),
            fields = {
                {name = 'Player', value = string.format('%s %s', player.name, player.firstname), inline = true},
                {name = 'Wallet', value = string.format('$%s', wallet), inline = true},
                {name = 'Bank', value = string.format('$%s', bank), inline = true}
            }
        })
    end
end)
```

## Best Practices

1. **Use Consistent Event Types**
   - Create a consistent naming convention for your event types
   - Document your event types for future reference

2. **Include Relevant Information**
   - Always include player identifiers
   - Include timestamps for time-sensitive events
   - Add context to make logs more useful

3. **Use Appropriate Colors**
   - Use consistent colors for similar event types
   - Use red for warnings/errors
   - Use green for successful actions

4. **Optimize Performance**
   - Don't log too frequently for high-volume events
   - Use appropriate log levels (debug vs. regular)
   - Consider using separate webhooks for different log types

5. **Handle Errors Gracefully**
   - Use the CatchError export for error handling
   - Include error details in logs
   - Don't let logging errors break your resource 