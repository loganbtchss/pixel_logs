--[[
    Pixel Logs - Event Handlers
    Version: 1.04122025
]]

local Utils = exports['pixel_logs']:GetUtils()

-- Helper function to safely get player name
local function GetPlayerNameSafe(source)
    local success, name = pcall(GetPlayerName, source)
    return success and name or 'Unknown'
end

-- Helper function to get player identifiers
local function GetPlayerIdentifiers(source)
    local identifiers = {}
    local numIds = GetNumPlayerIdentifiers(source)
    
    for i = 0, numIds - 1 do
        local id = GetPlayerIdentifier(source, i)
        if id then
            local type = id:match('^([^:]+):')
            if type then
                identifiers[type] = id
            end
        end
    end
    
    return identifiers
end

-- Helper function to format ban data
local function FormatBanData(source, target, reason, duration)
    local adminName = GetPlayerNameSafe(source)
    local targetName = GetPlayerNameSafe(target)
    local targetIds = GetPlayerIdentifiers(target)
    
    return {
        player = targetName,
        id = target,
        admin = adminName,
        reason = reason or 'No reason provided',
        duration = duration or 'Permanent',
        time = os.date('%Y-%m-%d %H:%M:%S'),
        identifiers = targetIds
    }
end

-- Player Join Event
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local source = source
    local playerName = GetPlayerNameSafe(source)
    
    if Config.LogTypes['player_join'] then
        local data = {
            player = playerName,
            id = source,
            time = os.date('%Y-%m-%d %H:%M:%S')
        }
        
        local message = Utils.FormatMessage('player_join', Config.Messages['player_join'].description, data)
        local embed = {
            title = Config.Messages['player_join'].title,
            description = message,
            color = Config.Colors['player_join'],
            fields = Config.Messages['player_join'].fields
        }
        
        Utils.SendEmbedToDiscord(embed)
    end
end)

-- Player Leave Event
AddEventHandler('playerDropped', function(reason)
    local source = source
    local playerName = GetPlayerNameSafe(source)
    
    if Config.LogTypes['player_leave'] then
        local data = {
            player = playerName,
            id = source,
            time = os.date('%Y-%m-%d %H:%M:%S'),
            reason = reason or 'Unknown'
        }
        
        local message = Utils.FormatMessage('player_leave', Config.Messages['player_leave'].description, data)
        local embed = {
            title = Config.Messages['player_leave'].title,
            description = message,
            color = Config.Colors['player_leave'],
            fields = Config.Messages['player_leave'].fields
        }
        
        Utils.SendEmbedToDiscord(embed)
    end
end)

-- Player Death Event
AddEventHandler('pixel_logs:playerDied', function(data)
    local source = source
    local playerName = GetPlayerNameSafe(source)
    
    if Config.LogTypes['player_death'] then
        local deathData = {
            player = playerName,
            id = source,
            time = os.date('%Y-%m-%d %H:%M:%S'),
            weapon = data.weaponName,
            killer = data.killer and GetPlayerNameSafe(data.killer) or 'Unknown',
            location = data.location,
            cause = data.cause,
            coords = data.coords
        }
        
        -- Format coordinates for display
        local coordsStr = string.format('X: %.2f, Y: %.2f, Z: %.2f', 
            deathData.coords.x, deathData.coords.y, deathData.coords.z)
        
        -- Add additional fields based on death cause
        local additionalFields = {}
        
        if deathData.cause == 'Player Kill' then
            table.insert(additionalFields, {
                name = 'Killer',
                value = deathData.killer,
                inline = true
            })
        end
        
        table.insert(additionalFields, {
            name = 'Death Cause',
            value = deathData.cause,
            inline = true
        })
        
        table.insert(additionalFields, {
            name = 'Location',
            value = deathData.location,
            inline = true
        })
        
        table.insert(additionalFields, {
            name = 'Coordinates',
            value = coordsStr,
            inline = false
        })
        
        -- Create embed with additional fields
        local embed = {
            title = Config.Messages['player_death'].title,
            description = Utils.FormatMessage('player_death', Config.Messages['player_death'].description, deathData),
            color = Config.Colors['player_death'],
            fields = additionalFields
        }
        
        Utils.SendEmbedToDiscord(embed)
    end
end)

-- Command Event
AddEventHandler('pixel_logs:playerCommand', function(command)
    local source = source
    local playerName = GetPlayerNameSafe(source)
    
    if Config.LogTypes['player_commands'] then
        local data = {
            player = playerName,
            id = source,
            time = os.date('%Y-%m-%d %H:%M:%S'),
            command = command
        }
        
        local message = Utils.FormatMessage('player_commands', Config.Messages['player_commands'].description, data)
        local embed = {
            title = Config.Messages['player_commands'].title,
            description = message,
            color = Config.Colors['player_commands'],
            fields = Config.Messages['player_commands'].fields
        }
        
        Utils.SendEmbedToDiscord(embed)
    end
end)

-- Ban Event
AddEventHandler('pixel_logs:playerBan', function(target, reason, duration)
    local source = source
    
    if Config.LogTypes['player_bans'] then
        local banData = FormatBanData(source, target, reason, duration)
        
        local message = Utils.FormatMessage('player_bans', Config.Messages['player_bans'].description, banData)
        local embed = {
            title = Config.Messages['player_bans'].title,
            description = message,
            color = Config.Colors['player_bans'],
            fields = Config.Messages['player_bans'].fields
        }
        
        Utils.SendEmbedToDiscord(embed)
    end
end)

-- Kick Event
AddEventHandler('pixel_logs:playerKick', function(target, reason)
    local source = source
    
    if Config.LogTypes['player_kicks'] then
        local kickData = {
            player = GetPlayerNameSafe(target),
            id = target,
            admin = GetPlayerNameSafe(source),
            reason = reason or 'No reason provided',
            time = os.date('%Y-%m-%d %H:%M:%S')
        }
        
        local message = Utils.FormatMessage('player_kicks', Config.Messages['player_kicks'].description, kickData)
        local embed = {
            title = Config.Messages['player_kicks'].title,
            description = message,
            color = Config.Colors['player_kicks'],
            fields = Config.Messages['player_kicks'].fields
        }
        
        Utils.SendEmbedToDiscord(embed)
    end
end)

-- Warn Event
AddEventHandler('pixel_logs:playerWarn', function(target, reason)
    local source = source
    
    if Config.LogTypes['player_warns'] then
        local warnData = {
            player = GetPlayerNameSafe(target),
            id = target,
            admin = GetPlayerNameSafe(source),
            reason = reason or 'No reason provided',
            time = os.date('%Y-%m-%d %H:%M:%S')
        }
        
        local message = Utils.FormatMessage('player_warns', Config.Messages['player_warns'].description, warnData)
        local embed = {
            title = Config.Messages['player_warns'].title,
            description = message,
            color = Config.Colors['player_warns'],
            fields = Config.Messages['player_warns'].fields
        }
        
        Utils.SendEmbedToDiscord(embed)
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
        
        local message = Utils.FormatMessage('player_resources', Config.Messages['player_resources'].description, data)
        
        -- Format fields with actual values
        local formattedFields = {}
        for _, field in ipairs(Config.Messages['player_resources'].fields) do
            local formattedValue = field.value
            formattedValue = formattedValue:gsub('{resource}', data.resource)
            formattedValue = formattedValue:gsub('{action}', data.action)
            formattedValue = formattedValue:gsub('{time}', data.time)
            
            table.insert(formattedFields, {
                name = field.name,
                value = formattedValue,
                inline = field.inline
            })
        end
        
        local embed = {
            title = Config.Messages['player_resources'].title,
            description = message,
            color = Config.Colors['player_resources'],
            fields = formattedFields
        }
        
        Utils.SendEmbedToDiscord(embed)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    -- Skip logging for pixel_logs itself
    if resourceName == GetCurrentResourceName() then return end
    
    if Config.LogTypes['player_resources'] then
        local data = {
            resource = resourceName,
            action = 'stopped',
            time = os.date('%Y-%m-%d %H:%M:%S')
        }
        
        local message = Utils.FormatMessage('player_resources', Config.Messages['player_resources'].description, data)
        
        -- Format fields with actual values
        local formattedFields = {}
        for _, field in ipairs(Config.Messages['player_resources'].fields) do
            local formattedValue = field.value
            formattedValue = formattedValue:gsub('{resource}', data.resource)
            formattedValue = formattedValue:gsub('{action}', data.action)
            formattedValue = formattedValue:gsub('{time}', data.time)
            
            table.insert(formattedFields, {
                name = field.name,
                value = formattedValue,
                inline = field.inline
            })
        end
        
        local embed = {
            title = Config.Messages['player_resources'].title,
            description = message,
            color = Config.Colors['player_resources'],
            fields = formattedFields
        }
        
        Utils.SendEmbedToDiscord(embed)
    end
end) 