-- Player Join Event
AddEventHandler('playerSpawned', function()
    TriggerServerEvent('pixel_logs:playerJoin')
end)

-- Player Leave Event
AddEventHandler('playerDropped', function(reason)
    TriggerServerEvent('pixel_logs:playerLeave')
end)

-- Player Death Event
AddEventHandler('baseevents:onPlayerDied', function(killerType, coords, killerId)
    local weaponHash = GetPedCauseOfDeath(PlayerPedId())
    local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
    
    TriggerServerEvent('playerDied', {
        weaponHash = weaponHash,
        killer = killerId,
        location = location
    })
end)

-- Command Event
RegisterNetEvent('pixel_logs:logCommand')
AddEventHandler('pixel_logs:logCommand', function(command)
    TriggerServerEvent('pixel_logs:playerCommand', command)
end)

-- Ban Event
RegisterNetEvent('pixel_logs:logBan')
AddEventHandler('pixel_logs:logBan', function(target, reason)
    TriggerServerEvent('pixel_logs:playerBan', target, reason)
end)

-- Kick Event
RegisterNetEvent('pixel_logs:logKick')
AddEventHandler('pixel_logs:logKick', function(target, reason)
    TriggerServerEvent('pixel_logs:playerKick', target, reason)
end)

-- Warn Event
RegisterNetEvent('pixel_logs:logWarn')
AddEventHandler('pixel_logs:logWarn', function(target, reason)
    TriggerServerEvent('pixel_logs:playerWarn', target, reason)
end) 