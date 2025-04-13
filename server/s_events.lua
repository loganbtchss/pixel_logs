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
AddEventHandler('playerDied', function(data)
    if not Config.LogTypes['player_death'] then return end
    
    local source = source
    local playerName = GetPlayerName(source)
    local weaponHash = data.weaponHash
    local weaponName = WeaponNames[tostring(weaponHash)] or 'Unknown'
    local killer = data.killer and GetPlayerName(data.killer) or 'Unknown'
    local location = data.location or 'Unknown'
    local isTxAdmin = Utils.IsTxAdmin(data.killer)

    local message = Utils.FormatMessage('player_death', {
        player = playerName,
        id = source,
        location = location,
        killer = isTxAdmin and 'txAdmin' or killer,
        weapon = weaponName
    })

    Utils.SendToDiscord('player_death', message, source)
end)

-- Command Event
RegisterNetEvent('pixel_logs:playerCommand')
AddEventHandler('pixel_logs:playerCommand', function(command)
    local source = source
    local name = GetPlayerName(source)
    Utils.SendToDiscord('player_commands', Utils.FormatMessage('player_commands', {player = name, command = command}), source)
end)

-- Ban Event
AddEventHandler('playerBanned', function(source, target, reason, duration)
    if not Config.LogTypes['player_bans'] then return end
    
    local adminName = GetPlayerName(source)
    local playerName = GetPlayerName(target)
    local isTxAdmin = Utils.IsTxAdmin(source)

    local message = Utils.FormatMessage('player_bans', {
        player = playerName,
        id = target,
        admin = isTxAdmin and 'txAdmin' or adminName,
        duration = duration,
        reason = reason
    })

    Utils.SendToDiscord('player_bans', message, target)
end)

-- Kick Event
AddEventHandler('playerKicked', function(source, target, reason)
    if not Config.LogTypes['player_kicks'] then return end
    
    local adminName = GetPlayerName(source)
    local playerName = GetPlayerName(target)
    local isTxAdmin = Utils.IsTxAdmin(source)

    local message = Utils.FormatMessage('player_kicks', {
        player = playerName,
        id = target,
        admin = isTxAdmin and 'txAdmin' or adminName,
        reason = reason
    })

    Utils.SendToDiscord('player_kicks', message, target)
end)

-- Warn Event
AddEventHandler('playerWarned', function(source, target, reason)
    if not Config.LogTypes['player_warns'] then return end
    
    local adminName = GetPlayerName(source)
    local playerName = GetPlayerName(target)
    local isTxAdmin = Utils.IsTxAdmin(source)

    local message = Utils.FormatMessage('player_warns', {
        player = playerName,
        id = target,
        admin = isTxAdmin and 'txAdmin' or adminName,
        reason = reason
    })

    Utils.SendToDiscord('player_warns', message, target)
end)

-- Resource Start/Stop Logging
AddEventHandler('onResourceStart', function(resourceName)
    Utils.SendToDiscord('player_resources', Utils.FormatMessage('player_resources', {resource = resourceName, action = 'started'}))
end)

AddEventHandler('onResourceStop', function(resourceName)
    Utils.SendToDiscord('player_resources', Utils.FormatMessage('player_resources', {resource = resourceName, action = 'stopped'}))
end) 