local Utils = exports['pixel_logs']:GetUtils()

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

-- Exports
exports('SendCustomLog', function(type, message, source, color)
    Utils.SendToDiscord(type, message, source, color)
end)

exports('SendCustomEmbed', function(embed)
    Utils.SendEmbedToDiscord(embed)
end) 