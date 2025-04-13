local Utils = exports['pixel_logs']:GetUtils()

-- Debug Log Download Handler
RegisterNetEvent('pixel_logs:downloadDebugLog')
AddEventHandler('pixel_logs:downloadDebugLog', function(logIndex)
    local source = source
    local log = Utils.GetDebugLog(logIndex)
    
    if not log then
        TriggerClientEvent('pixel_logs:notify', source, 'Invalid log index')
        return
    end
    
    -- Format log data
    local logText = string.format([[
Debug Log #%d
Timestamp: %s
Type: %s
Message: %s
]], logIndex, log.timestamp, log.type, log.message)
    
    -- Add data if present
    if log.data then
        logText = logText .. "\nAdditional Data:\n"
        for k, v in pairs(log.data) do
            logText = logText .. string.format("%s: %s\n", k, tostring(v))
        end
    end
    
    -- Send log to client
    TriggerClientEvent('pixel_logs:receiveDebugLog', source, logText)
end)

-- Export function to add debug logs
exports('AddDebugLog', function(type, message, data)
    Utils.AddDebugLog(type, message, data)
end) 