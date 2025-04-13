local Utils = exports['pixel_logs']:GetUtils()

-- Custom Log Events
RegisterNetEvent('pixel_logs:customLog')
AddEventHandler('pixel_logs:customLog', function(type, message, color)
    local source = source
    Utils.SendToDiscord(type, message, source, color)
end)

RegisterNetEvent('pixel_logs:customEmbed')
AddEventHandler('pixel_logs:customEmbed', function(embed)
    PerformHttpRequest(Config.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({
        username = Config.DiscordUsername,
        avatar_url = Config.DiscordAvatar,
        embeds = {embed}
    }), { ['Content-Type'] = 'application/json' })
end)

-- Exports
exports('SendCustomLog', function(type, message, source, color)
    Utils.SendToDiscord(type, message, source, color)
end)

exports('SendCustomEmbed', function(embed)
    PerformHttpRequest(Config.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({
        username = Config.DiscordUsername,
        avatar_url = Config.DiscordAvatar,
        embeds = {embed}
    }), { ['Content-Type'] = 'application/json' })
end) 