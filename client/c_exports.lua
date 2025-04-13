-- Client Exports
exports('SendCustomLog', function(type, message, color)
    TriggerServerEvent('pixel_logs:customLog', type, message, color)
end)

exports('SendCustomEmbed', function(embed)
    TriggerServerEvent('pixel_logs:customEmbed', embed)
end) 