local Utils = exports['pixel_logs']:GetUtils()

-- Chat Message Event
RegisterNetEvent('pixel_logs:playerChat')
AddEventHandler('pixel_logs:playerChat', function(message)
    local source = source
    local name = GetPlayerName(source)
    Utils.SendToDiscord('player_chat', Utils.FormatMessage('player_chat', {player = name, message = message}), source)
end) 