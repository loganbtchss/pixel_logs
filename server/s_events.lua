local Utils = exports['pixel_logs']:GetUtils()

-- Player Join Event
RegisterNetEvent('pixel_logs:playerJoin')
AddEventHandler('pixel_logs:playerJoin', function()
    local source = source
    local name = GetPlayerName(source)
    Utils.SendToDiscord('player_join', Utils.FormatMessage('player_join', {player = name}), source)
end)

-- Player Leave Event
RegisterNetEvent('pixel_logs:playerLeave')
AddEventHandler('pixel_logs:playerLeave', function()
    local source = source
    local name = GetPlayerName(source)
    Utils.SendToDiscord('player_leave', Utils.FormatMessage('player_leave', {player = name}), source)
end)

-- Player Death Event
RegisterNetEvent('pixel_logs:playerDeath')
AddEventHandler('pixel_logs:playerDeath', function()
    local source = source
    local name = GetPlayerName(source)
    Utils.SendToDiscord('player_death', Utils.FormatMessage('player_death', {player = name}), source)
end)

-- Command Event
RegisterNetEvent('pixel_logs:playerCommand')
AddEventHandler('pixel_logs:playerCommand', function(command)
    local source = source
    local name = GetPlayerName(source)
    Utils.SendToDiscord('player_commands', Utils.FormatMessage('player_commands', {player = name, command = command}), source)
end)

-- Ban Event
RegisterNetEvent('pixel_logs:playerBan')
AddEventHandler('pixel_logs:playerBan', function(target, reason)
    local source = source
    local admin = GetPlayerName(source)
    local targetName = GetPlayerName(target)
    Utils.SendToDiscord('player_bans', Utils.FormatMessage('player_bans', {player = targetName, admin = admin, reason = reason}), target)
end)

-- Kick Event
RegisterNetEvent('pixel_logs:playerKick')
AddEventHandler('pixel_logs:playerKick', function(target, reason)
    local source = source
    local admin = GetPlayerName(source)
    local targetName = GetPlayerName(target)
    Utils.SendToDiscord('player_kicks', Utils.FormatMessage('player_kicks', {player = targetName, admin = admin, reason = reason}), target)
end)

-- Warn Event
RegisterNetEvent('pixel_logs:playerWarn')
AddEventHandler('pixel_logs:playerWarn', function(target, reason)
    local source = source
    local admin = GetPlayerName(source)
    local targetName = GetPlayerName(target)
    Utils.SendToDiscord('player_warns', Utils.FormatMessage('player_warns', {player = targetName, admin = admin, reason = reason}), target)
end)

-- Resource Start/Stop Logging
AddEventHandler('onResourceStart', function(resourceName)
    Utils.SendToDiscord('player_resources', Utils.FormatMessage('player_resources', {resource = resourceName, action = 'started'}))
end)

AddEventHandler('onResourceStop', function(resourceName)
    Utils.SendToDiscord('player_resources', Utils.FormatMessage('player_resources', {resource = resourceName, action = 'stopped'}))
end) 