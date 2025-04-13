local Utils = {}

-- Debug Logging
local debugLogs = {}
local maxDebugLogs = Config.Debug.MaxLogs

function Utils.GetPlayerIdentifiers(source)
    local identifiers = {}
    local numIds = GetNumPlayerIdentifiers(source)
    
    for i = 0, numIds - 1 do
        local identifier = GetPlayerIdentifier(source, i)
        if identifier then
            local type = identifier:match('^([^:]+):')
            if type then
                identifiers[type] = identifier
            end
        end
    end
    
    return identifiers
end

function Utils.FormatMessage(type, data)
    local message = Config.Messages[type]
    if not message then return nil end
    
    for k, v in pairs(data) do
        message = message:gsub('{' .. k .. '}', v)
    end
    
    return message
end

function Utils.CreateEmbed(type, message, source, customColor)
    local embed = {
        color = customColor or Config.Colors[type] or 16777215,
        title = message,
        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
        footer = {
            text = 'Server Logs'
        }
    }
    
    if source then
        local identifiers = Utils.GetPlayerIdentifiers(source)
        local fields = {}
        
        for identifierType, enabled in pairs(Config.Identifiers) do
            if enabled and identifiers[identifierType] then
                fields[#fields + 1] = {
                    name = identifierType:upper(),
                    value = identifiers[identifierType],
                    inline = true
                }
            end
        end
        
        if #fields > 0 then
            embed.fields = fields
        end
    end
    
    return embed
end

function Utils.SendToDiscord(type, message, source, customColor)
    if not Config.LogTypes[type] then return end
    
    local embed = Utils.CreateEmbed(type, message, source, customColor)
    if not embed then return end
    
    PerformHttpRequest(Config.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({
        username = Config.DiscordUsername,
        avatar_url = Config.DiscordAvatar,
        embeds = {embed}
    }), { ['Content-Type'] = 'application/json' })
end

-- Debug Logging Functions
function Utils.AddDebugLog(type, message, data)
    if not Config.Debug.Enabled then return end
    
    local log = {
        timestamp = os.date('%Y-%m-%d %H:%M:%S'),
        type = type,
        message = message,
        data = data
    }
    
    table.insert(debugLogs, log)
    local logIndex = #debugLogs
    
    -- Remove oldest log if we exceed the maximum
    if #debugLogs > maxDebugLogs then
        table.remove(debugLogs, 1)
    end
    
    -- Get the debug log URL
    local debugLogUrl = exports['pixel_logs']:GetDebugLogUrl(logIndex)
    
    -- Create debug embed
    local embed = {
        color = 16711680, -- Red color
        title = 'Debug Log',
        description = string.format('**Type:** %s\n**Message:** %s', type, message),
        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
        fields = {
            {
                name = 'Timestamp',
                value = log.timestamp,
                inline = true
            }
        }
    }
    
    -- Add data fields if present
    if data then
        for k, v in pairs(data) do
            table.insert(embed.fields, {
                name = k,
                value = tostring(v),
                inline = true
            })
        end
    end
    
    -- Add download button
    embed.fields[#embed.fields + 1] = {
        name = 'Download Log',
        value = string.format('[Click Here](%s)', debugLogUrl),
        inline = false
    }
    
    -- Use debug webhook if specified, otherwise use default webhook
    local webhook = Config.Debug.Webhook ~= '' and Config.Debug.Webhook or Config.DiscordWebhook
    
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        username = Config.DiscordUsername,
        avatar_url = Config.DiscordAvatar,
        embeds = {embed}
    }), { ['Content-Type'] = 'application/json' })
end

function Utils.GetDebugLog(index)
    return debugLogs[index]
end

function Utils.GetAllDebugLogs()
    return debugLogs
end

-- Export the Utils table
exports('GetUtils', function()
    return Utils
end)

-- Export individual functions
exports('GetPlayerIdentifiers', Utils.GetPlayerIdentifiers)
exports('FormatMessage', Utils.FormatMessage)
exports('CreateEmbed', Utils.CreateEmbed)
exports('SendToDiscord', Utils.SendToDiscord)
exports('AddDebugLog', Utils.AddDebugLog)
exports('GetDebugLog', Utils.GetDebugLog)
exports('GetAllDebugLogs', Utils.GetAllDebugLogs)

return Utils 