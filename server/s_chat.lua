local Utils = exports['pixel_logs']:GetUtils()

-- Helper function to safely get player name
local function GetPlayerNameSafe(source)
    local success, name = pcall(GetPlayerName, source)
    return success and name or 'Unknown'
end

-- Helper function to format chat message based on game type
local function FormatChatMessage(data)
    local message = data.message
    local prefix = data.prefix or ''
    local color = data.color or nil
    
    if prefix ~= '' then
        message = prefix .. ' ' .. message
    end
    
    return message
end

-- Chat Message Event
RegisterNetEvent('pixel_logs:playerChat')
AddEventHandler('pixel_logs:playerChat', function(data)
    if not data or not data.message then return end
    
    local source = source
    local playerName = GetPlayerNameSafe(source)
    local channel = data.channel or 'global'
    
    if Config.LogTypes['chat'] then
        local chatData = {
            player = playerName,
            id = source,
            time = os.date('%Y-%m-%d %H:%M:%S'),
            message = FormatChatMessage(data),
            channel = channel,
            type = data.type or 'chat',
            color = data.color
        }
        
        local message = Utils.FormatMessage('chat', '**{player}** in {channel}: {message}', chatData)
        Utils.SendToDiscord('chat', message, source, chatData.color, chatData)
    end
end) 