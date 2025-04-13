-- Chat Message Event
AddEventHandler('chat:message', function(data)
    if not data or not data.author or data.author == 0 then return end -- Skip system messages
    
    local message = data.message
    if not message or type(message) ~= 'string' or message:len() == 0 then return end
    
    -- Handle both FiveM and RedM chat systems
    local channel = data.channel or 'global'
    local author = data.author
    
    -- Additional RedM specific data
    local additionalData = {
        message = message,
        channel = channel,
        author = author,
        type = data.type or 'chat', -- RedM has different message types
        color = data.color or nil, -- RedM supports message colors
        prefix = data.prefix or nil -- RedM supports message prefixes
    }
    
    TriggerServerEvent('pixel_logs:playerChat', additionalData)
end) 