--[[
    Pixel Logs - Debug System
    Version: 1.04122025
]]

local debugLogs = {}
local maxLogs = Config.Debug.MaxLogs

-- Helper function to safely encode data for debug logs
local function SafeEncode(data)
    if type(data) == 'table' then
        local success, result = pcall(function() return json.encode(data) end)
        return success and result or 'Failed to encode table'
    elseif type(data) == 'string' then
        return data
    else
        return tostring(data)
    end
end

-- Helper function to safely get stack trace
local function GetStackTrace()
    local success, stack = pcall(function()
        return debug.traceback()
    end)
    
    if not success or type(stack) ~= 'string' then
        return 'Failed to get stack trace'
    end
    
    -- Remove the first line (it's just the error message)
    local lines = {}
    for line in stack:gmatch("[^\r\n]+") do
        if not line:match("^stack traceback:") then
            table.insert(lines, line)
        end
    end
    return table.concat(lines, "\n")
end

-- Add a debug log
function AddDebugLog(type, data)
    if not Config.Debug.Enabled then return end
    
    local timestamp = os.date('%Y-%m-%d %H:%M:%S')
    local logIndex = #debugLogs + 1
    
    -- If we've reached the maximum number of logs, remove the oldest one
    if logIndex > maxLogs then
        table.remove(debugLogs, 1)
        logIndex = maxLogs
    end
    
    -- Create the log entry
    local logEntry = {
        index = logIndex,
        timestamp = timestamp,
        type = type,
        data = data
    }
    
    -- Add to logs
    table.insert(debugLogs, logEntry)
    
    -- Send to Discord if webhook is configured
    if Config.Debug.Webhook ~= '' then
        local embed = {
            title = data.title or 'Debug Log',
            description = data.description or 'A debug log has been created',
            color = type == 'error' and 16711680 or 16776960, -- Red for errors, Yellow for others
            fields = data.fields or {
                {
                    name = 'Log Information',
                    value = string.format('```\nType: %s\nIndex: %s\nTime: %s```', type, logIndex, timestamp),
                    inline = false
                }
            },
            footer = {
                text = 'Pixel Logs Debug System'
            },
            timestamp = timestamp
        }
        
        PerformHttpRequest(Config.Debug.Webhook, function(err, text, headers)
            if err ~= 204 then
                print('^1[Pixel Logs] Failed to send debug log to Discord. Error: ' .. tostring(err) .. '^0')
            end
        end, 'POST', json.encode({
            username = 'Debug Logs',
            embeds = {embed}
        }), {['Content-Type'] = 'application/json'})
    end
    
    return logIndex
end

-- Catch and log errors
function CatchError(err, context)
    if not Config.Debug.Enabled then return end
    
    local stackTrace = GetStackTrace()
    local errorData = {
        title = 'Script Error',
        description = 'An error occurred in the script. Please reference this log when requesting support.',
        fields = {
            {
                name = 'Error Details',
                value = string.format('```\nError: %s\nContext: %s\nStack Trace:\n%s```', 
                    tostring(err),
                    context or 'No context provided',
                    stackTrace
                ),
                inline = false
            },
            {
                name = 'Resource Info',
                value = string.format('```\nResource: %s\nVersion: %s\nServer: %s```',
                    GetCurrentResourceName(),
                    GetResourceMetadata(GetCurrentResourceName(), 'version', 0),
                    GetConvar('sv_hostname', 'Unknown')
                ),
                inline = false
            }
        }
    }
    
    return AddDebugLog('error', errorData)
end

-- Get debug log information
function GetDebugLog(index)
    if not Config.Debug.Enabled then return nil end
    return debugLogs[index]
end

-- Get all debug logs
function GetAllDebugLogs()
    if not Config.Debug.Enabled then return {} end
    return debugLogs
end

-- Clear all debug logs
function ClearDebugLogs()
    if not Config.Debug.Enabled then return end
    debugLogs = {}
end

-- Register the exports
exports('AddDebugLog', AddDebugLog)
exports('GetDebugLog', GetDebugLog)
exports('GetAllDebugLogs', GetAllDebugLogs)
exports('ClearDebugLogs', ClearDebugLogs)
exports('CatchError', CatchError) 