--[[
    Pixel Logs - Client Events
    Version: 1.04122025
]]

-- Player Join Event
AddEventHandler('playerSpawned', function()
    TriggerServerEvent('pixel_logs:playerJoin')
end)

-- Player Leave Event
AddEventHandler('playerDropped', function(reason)
    TriggerServerEvent('pixel_logs:playerLeave')
end)

-- Helper function to get death cause
local function GetDeathCause(weaponHash, killerType, killerId)
    local cause = 'Unknown'
    local weaponName = 'Unknown'
    
    -- Get weapon name if it's a weapon death
    if weaponHash ~= 0 then
        weaponName = exports['pixel_logs']:GetWeaponName(weaponHash)
    end
    
    -- Determine death cause based on killer type and weapon
    if killerType == 1 then -- Player
        cause = 'Player Kill'
    elseif killerType == 2 then -- Vehicle
        cause = 'Vehicle Accident'
        weaponName = 'Vehicle'
    elseif killerType == 3 then -- Animal
        cause = 'Animal Attack'
        weaponName = 'Animal'
    elseif killerType == 4 then -- Fire
        cause = 'Fire'
        weaponName = 'Fire'
    elseif killerType == 5 then -- Explosion
        cause = 'Explosion'
        weaponName = 'Explosion'
    elseif killerType == 6 then -- Drowning
        cause = 'Drowning'
        weaponName = 'Water'
    elseif killerType == 7 then -- Fall
        cause = 'Fall Damage'
        weaponName = 'Fall'
    elseif killerType == 8 then -- Suicide
        cause = 'Suicide'
    elseif killerType == 9 then -- Environmental
        cause = 'Environmental'
        weaponName = 'Environment'
    end
    
    return cause, weaponName
end

-- Player Death Event
AddEventHandler('baseevents:onPlayerDied', function(killerType, coords, killerId)
    local weaponHash = GetPedCauseOfDeath(PlayerPedId())
    local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
    local cause, weaponName = GetDeathCause(weaponHash, killerType, killerId)
    
    TriggerServerEvent('pixel_logs:playerDied', {
        weaponHash = weaponHash,
        weaponName = weaponName,
        killer = killerId,
        location = location,
        cause = cause,
        coords = coords
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

-- Notification Handler
RegisterNetEvent('pixel_logs:notify')
AddEventHandler('pixel_logs:notify', function(message)
    TriggerEvent('chat:addMessage', {
        color = {255, 0, 0},
        multiline = true,
        args = {'Pixel Logs', message}
    })
end) 