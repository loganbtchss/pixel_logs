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
    
    Utils.SendEmbedToDiscord(embed)
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
function CatchError(error, source)
    if not Config.Debug.Enabled then return end
    
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
    
    Utils.SendEmbedToDiscord(embed)
end

-- Export debug functions
exports('AddDebugLog', Utils.AddDebugLog)
exports('GetDebugLog', Utils.GetDebugLog)
exports('GetAllDebugLogs', Utils.GetAllDebugLogs)
exports('ClearDebugLogs', Utils.ClearDebugLogs)
exports('CatchError', CatchError) 