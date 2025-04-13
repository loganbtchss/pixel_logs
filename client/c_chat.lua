-- Chat Message Event
AddEventHandler('chat:message', function(data)
    if data.author ~= 0 then -- Only log player messages, not system messages
        TriggerServerEvent('pixel_logs:playerChat', data.message)
    end
end) 