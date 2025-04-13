--[[
    Pixel Logs - Server Exports
    Version: 1.04122025
]]

local Utils = exports['pixel_logs']:GetUtils()

-- Custom Log Export
exports('SendCustomLog', function(messageType, message, source, color)
    if not Config.LogTypes[messageType] then return end
    
    local embed = Utils.CreateEmbed(messageType, message, source, color)
    if embed then
        Utils.SendEmbedToDiscord(embed)
    end
end)

-- Custom Embed Export
exports('SendCustomEmbed', function(embed)
    if not embed then return end
    
    -- Ensure embed has required fields
    embed.timestamp = embed.timestamp or os.date('!%Y-%m-%dT%H:%M:%SZ')
    embed.footer = embed.footer or {text = 'Server Logs'}
    
    Utils.SendEmbedToDiscord(embed)
end)

-- Debug Log Export
exports('AddDebugLog', function(type, message, data)
    Utils.AddDebugLog(type, message, data)
end)

-- Custom Log Events
RegisterNetEvent('pixel_logs:customLog')
AddEventHandler('pixel_logs:customLog', function(type, message, color)
    local source = source
    Utils.SendToDiscord(type, message, source, color)
end)

RegisterNetEvent('pixel_logs:customEmbed')
AddEventHandler('pixel_logs:customEmbed', function(embed)
    Utils.SendEmbedToDiscord(embed)
end) 