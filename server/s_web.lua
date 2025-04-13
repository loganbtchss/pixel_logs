local Utils = exports['pixel_logs']:GetUtils()

-- Create HTTP handler for debug logs
CreateThread(function()
    local resourceName = GetCurrentResourceName()
    
    -- Register HTTP handler for debug logs
    AddEventHandler('onResourceStart', function(resource)
        if resource == resourceName then
            -- Set up HTTP handler
            SetHttpHandler(function(req, res)
                -- Check if debug logging is enabled
                if not Config.Debug.Enabled then
                    res.send('Debug logging is not enabled')
                    return
                end
                
                -- Get log index from URL
                local logIndex = tonumber(req.path:match('/debug%-logs/(%d+)'))
                if not logIndex then
                    res.send('Invalid log index')
                    return
                end
                
                -- Get the log
                local log = Utils.GetDebugLog(logIndex)
                if not log then
                    res.send('Log not found')
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
                
                -- Set headers for file download
                res.setHeader('Content-Type', 'text/plain')
                res.setHeader('Content-Disposition', string.format('attachment; filename="debug_log_%d.txt"', logIndex))
                
                -- Send the log file
                res.send(logText)
            end)
        end
    end)
end)

-- Export function to get debug log URL
exports('GetDebugLogUrl', function(logIndex)
    local serverIp = GetConvar('web_baseUrl', 'http://localhost:13172')
    return string.format('%s/debug-logs/%d', serverIp, logIndex)
end) 