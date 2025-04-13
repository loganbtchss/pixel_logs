--[[
    Pixel Logs - Debug Handler
    Version: 1.04122025
]]

local Utils = exports['pixel_logs']:GetUtils()

-- Helper function to safely encode data for debug logs
local function SafeEncode(data)
    local success, result = pcall(json.encode, data)
    return success and result or 'Failed to encode data'
end

-- Helper function to safely decode data for debug logs
local function SafeDecode(data)
    local success, result = pcall(json.decode, data)
    return success and result or nil
end

-- Debug Logging Functions
local debugLogs = {}
local maxLogs = Config.Debug.MaxLogs

function Utils.AddDebugLog(type, message, data)
    if not Config.Debug.Enabled then return end
    
    local log = {
        type = type,
        message = message,
        data = data,
        timestamp = os.date('%Y-%m-%d %H:%M:%S'),
        resource = GetCurrentResourceName()
    }
    
    table.insert(debugLogs, 1, log)
    
    -- Trim logs if exceeding max
    while #debugLogs > maxLogs do
        table.remove(debugLogs)
    end
    
    -- Only create and send embed for errors or when explicitly requested
    if type == 'error' or (data and data.sendEmbed) then
        -- Create embed for Discord
        local embed = {
            title = string.format('%s Debug Log', type:upper()),
            description = message,
            color = type == 'error' and 16711680 or 16776960, -- Red for error, Yellow for others
            timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
            footer = {
                text = 'Server Logs'
            },
            fields = {
                {
                    name = 'Resource',
                    value = log.resource,
                    inline = true
                },
                {
                    name = 'Time',
                    value = log.timestamp,
                    inline = true
                }
            }
        }
        
        -- Add data field if provided
        if data then
            table.insert(embed.fields, {
                name = 'Data',
                value = string.format('```json\n%s\n```', SafeEncode(data)),
                inline = false
            })
        end
        
        -- Use debug webhook if specified, otherwise use default webhook
        local webhook = Config.Debug.Webhook ~= '' and Config.Debug.Webhook or Config.DiscordWebhook
        
        -- Send the embed using the appropriate webhook
        local originalWebhook = Config.DiscordWebhook
        Config.DiscordWebhook = webhook
        Utils.SendEmbedToDiscord(embed)
        Config.DiscordWebhook = originalWebhook
    end
end

function Utils.GetDebugLog(index)
    return debugLogs[index]
end

function Utils.GetAllDebugLogs()
    return debugLogs
end

function Utils.ClearDebugLogs()
    debugLogs = {}
end

-- Error Catching
function CatchError(error, source, data)
    if not Config.Debug.Enabled then return end
    
    -- Check if this is a webhook error to prevent circular references
    if source == 'SendEmbedToDiscord' and error:match('Failed to send webhook') then
        -- Just log to console for webhook errors to prevent loops
        print(string.format('^1[pixel_logs] Webhook Error: %s^0', error))
        return
    end
    
    -- Check if this is a debug log error to prevent circular references
    if source == 'AddDebugLog' then
        -- Just log to console for debug log errors to prevent loops
        print(string.format('^1[pixel_logs] Debug Error: %s^0', error))
        return
    end
    
    -- Check if this is a CatchError error to prevent circular references
    if source == 'CatchError' then
        -- Just log to console for CatchError errors to prevent loops
        print(string.format('^1[pixel_logs] Error Handler Error: %s^0', error))
        return
    end
    
    local embed = {
        title = 'Error Log',
        description = string.format('**Source:** %s\n**Error:** %s', source, error),
        color = 16711680, -- Red
        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
        footer = {
            text = 'Server Logs'
        },
        fields = {
            {
                name = 'Resource',
                value = GetCurrentResourceName(),
                inline = true
            },
            {
                name = 'Time',
                value = os.date('%Y-%m-%d %H:%M:%S'),
                inline = true
            }
        }
    }
    
    -- Add data fields if provided
    if data then
        for k, v in pairs(data) do
            table.insert(embed.fields, {
                name = k,
                value = string.format('```json\n%s\n```', SafeEncode(v)),
                inline = false
            })
        end
    end
    
    -- Use debug webhook if specified, otherwise use default webhook
    local webhook = Config.Debug.Webhook ~= '' and Config.Debug.Webhook or Config.DiscordWebhook
    
    -- Send the embed using the appropriate webhook
    local originalWebhook = Config.DiscordWebhook
    Config.DiscordWebhook = webhook
    Utils.SendEmbedToDiscord(embed)
    Config.DiscordWebhook = originalWebhook
end

-- Export debug functions
exports('GetDebugLog', Utils.GetDebugLog)
exports('GetAllDebugLogs', Utils.GetAllDebugLogs)
exports('ClearDebugLogs', Utils.ClearDebugLogs)
exports('CatchError', CatchError) 