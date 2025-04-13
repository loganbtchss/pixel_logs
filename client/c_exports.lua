--[[
    Pixel Logs - Client Exports
    Version: 1.04122025
]]

-- Custom Log Export
exports('SendCustomLog', function(messageType, message, color)
    if not messageType or not message then return end
    
    TriggerServerEvent('pixel_logs:customLog', messageType, message, color)
end)

-- Custom Embed Export
exports('SendCustomEmbed', function(embed)
    if not embed then return end
    
    -- Ensure embed has required fields
    embed.timestamp = embed.timestamp or os.date('!%Y-%m-%dT%H:%M:%SZ')
    embed.footer = embed.footer or {text = 'Server Logs'}
    
    TriggerServerEvent('pixel_logs:customEmbed', embed)
end) 