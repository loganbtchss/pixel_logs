--[[
    Pixel Logs - Event Handlers
    Version: 1.04122025
]]

local Utils = exports['pixel_logs']:GetUtils()

-- Player Join Event
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local source = source
    local playerName = GetPlayerName(source)
    
    if Config.LogTypes['player_join'] then
        local data = {
            player = playerName,
            id = source,
            time = os.date('%Y-%m-%d %H:%M:%S')
        }
        
        local message = Utils.FormatMessage('player_join', '**{player}** has joined the server', data)
        Utils.SendToDiscord('player_join', message, source, nil, data)
    end
end)

-- Player Leave Event
AddEventHandler('playerDropped', function(reason)
    local source = source
    local playerName = GetPlayerName(source)
    
    if Config.LogTypes['player_leave'] then
        local data = {
            player = playerName,
            id = source,
            time = os.date('%Y-%m-%d %H:%M:%S'),
            reason = reason or 'Unknown'
        }
        
        local message = Utils.FormatMessage('player_leave', '**{player}** has left the server', data)
        Utils.SendToDiscord('player_leave', message, source, nil, data)
    end
end)

-- Player Death Event
AddEventHandler('playerDied', function(killerType, killerId, weapon)
    local source = source
    local playerName = GetPlayerName(source)
    
    if Config.LogTypes['player_death'] then
        local data = {
            player = playerName,
            id = source,
            location = GetEntityCoords(GetPlayerPed(source)),
            killer = killerId and GetPlayerName(killerId) or 'Unknown',
            weapon = weapon or 'Unknown'
        }
        
        local message = Utils.FormatMessage('player_death', '**{player}** has died', data)
        Utils.SendToDiscord('player_death', message, source, nil, data)
    end
end)

-- Command Event
AddEventHandler('chatMessage', function(source, name, message)
    if message:sub(1, 1) == '/' then
        if Config.LogTypes['player_commands'] then
            local data = {
                player = name,
                id = source,
                command = message:match('^/(%S+)'),
                args = message:match('^/%S+%s+(.+)$') or ''
            }
            
            local message = Utils.FormatMessage('player_commands', '**{player}** used a command', data)
            Utils.SendToDiscord('player_commands', message, source, nil, data)
        end
    end
end)

-- Ban Event
RegisterNetEvent('pixel_logs:ban')
AddEventHandler('pixel_logs:ban', function(target, reason, duration, admin)
    if Config.LogTypes['player_bans'] then
        local data = {
            player = GetPlayerName(target),
            id = target,
            admin = admin,
            duration = duration,
            reason = reason
        }
        
        local message = Utils.FormatMessage('player_bans', '**{player}** has been banned', data)
        Utils.SendToDiscord('player_bans', message, target, nil, data)
    end
end)

-- Kick Event
RegisterNetEvent('pixel_logs:kick')
AddEventHandler('pixel_logs:kick', function(target, reason, admin)
    if Config.LogTypes['player_kicks'] then
        local data = {
            player = GetPlayerName(target),
            id = target,
            admin = admin,
            reason = reason
        }
        
        local message = Utils.FormatMessage('player_kicks', '**{player}** has been kicked', data)
        Utils.SendToDiscord('player_kicks', message, target, nil, data)
    end
end)

-- Warn Event
RegisterNetEvent('pixel_logs:warn')
AddEventHandler('pixel_logs:warn', function(target, reason, admin)
    if Config.LogTypes['player_warns'] then
        local data = {
            player = GetPlayerName(target),
            id = target,
            admin = admin,
            reason = reason
        }
        
        local message = Utils.FormatMessage('player_warns', '**{player}** has been warned', data)
        Utils.SendToDiscord('player_warns', message, target, nil, data)
    end
end)

-- Resource Start/Stop Logging
AddEventHandler('onResourceStart', function(resourceName)
    if Config.LogTypes['player_resources'] then
        local data = {
            resource = resourceName,
            action = 'started',
            time = os.date('%Y-%m-%d %H:%M:%S')
        }
        
        local message = Utils.FormatMessage('player_resources', 'Resource **{resource}** has been {action}', data)
        Utils.SendToDiscord('player_resources', message, nil, nil, data)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if Config.LogTypes['player_resources'] then
        local data = {
            resource = resourceName,
            action = 'stopped',
            time = os.date('%Y-%m-%d %H:%M:%S')
        }
        
        local message = Utils.FormatMessage('player_resources', 'Resource **{resource}** has been {action}', data)
        Utils.SendToDiscord('player_resources', message, nil, nil, data)
    end
end) 