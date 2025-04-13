--[[
    Pixel Logs - Chat Handler
    Version: 1.04122025
]]

local Utils = exports['pixel_logs']:GetUtils()

-- Helper function to safely get player name
local function GetPlayerNameSafe(source)
    local success, name = pcall(GetPlayerName, source)
    return success and name or 'Unknown'
end

-- Chat Message Event
RegisterNetEvent('pixel_logs:playerChat')
AddEventHandler('pixel_logs:playerChat', function(message, channel, additionalData)
    local source = source
    if not Config.LogTypes['player_chat'] then return end
    
    local data = {
        player = GetPlayerNameSafe(source),
        id = source,
        time = os.date('%Y-%m-%d %H:%M:%S'),
        message = message,
        channel = channel or 'global'
    }
    
    -- Merge additional data if provided
    if additionalData and type(additionalData) == 'table' then
        for k, v in pairs(additionalData) do
            data[k] = v
        end
    end
    
    local message = Utils.FormatMessage('player_chat', Config.Messages['player_chat'].description, data)
    local embed = {
        title = Config.Messages['player_chat'].title,
        description = message,
        color = Config.Colors['player_chat'],
        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
        footer = {
            text = 'Server Logs'
        },
        fields = {}
    }
    
    -- Add player info fields
    table.insert(embed.fields, {
        name = 'Player Information',
        value = string.format('```\nName: %s\nID: %s\n```', data.player, data.id),
        inline = false
    })
    
    -- Add message info fields
    table.insert(embed.fields, {
        name = 'Message',
        value = string.format('```\n%s\n```', data.message),
        inline = false
    })
    
    -- Add channel field
    table.insert(embed.fields, {
        name = 'Channel',
        value = data.channel,
        inline = true
    })
    
    -- Add timestamp field
    table.insert(embed.fields, {
        name = 'Time',
        value = data.time,
        inline = true
    })
    
    Utils.SendEmbedToDiscord(embed)
end) 