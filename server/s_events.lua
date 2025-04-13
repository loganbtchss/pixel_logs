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
        
        -- Add timestamp field
        table.insert(embed.fields, {
            name = 'Time',
            value = data.time,
            inline = true
        })
        
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
        
        -- Add reason and timestamp fields
        table.insert(embed.fields, {
            name = 'Reason',
            value = data.reason,
            inline = true
        })
        
        table.insert(embed.fields, {
            name = 'Time',
            value = data.time,
            inline = true
        })
        
        Utils.SendEmbedToDiscord(embed)
    end
end)

-- Player Death Event
AddEventHandler('pixel_logs:playerDeath', function(data)
    if not Config.LogTypes['player_death'] then return end
    
    local source = source
    local playerName = GetPlayerNameSafe(source)
    
    local deathData = {
        player = playerName,
        id = source,
        time = os.date('%Y-%m-%d %H:%M:%S'),
        cause = data.cause or 'Unknown',
        weapon = data.weapon or 'Unknown',
        location = data.location or 'Unknown',
        coords = data.coords or 'Unknown',
        killer = data.killer or nil
    }
    
    local message = Utils.FormatMessage('player_death', Config.Messages['player_death'].description, deathData)
    local embed = {
        title = Config.Messages['player_death'].title,
        description = message,
        color = Config.Colors['player_death'],
        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
        footer = {
            text = 'Server Logs'
        },
        fields = {}
    }
    
    -- Add player info fields
    table.insert(embed.fields, {
        name = 'Player Information',
        value = string.format('```\nName: %s\nID: %s\n```', deathData.player, deathData.id),
        inline = false
    })
    
    -- Add death info fields
    table.insert(embed.fields, {
        name = 'Death Cause',
        value = deathData.cause,
        inline = true
    })
    
    table.insert(embed.fields, {
        name = 'Weapon/Method',
        value = deathData.weapon,
        inline = true
    })
    
    -- Add location fields
    table.insert(embed.fields, {
        name = 'Location',
        value = deathData.location,
        inline = true
    })
    
    table.insert(embed.fields, {
        name = 'Coordinates',
        value = deathData.coords,
        inline = true
    })
    
    -- Add killer info if available
    if deathData.killer then
        table.insert(embed.fields, {
            name = 'Killer',
            value = deathData.killer,
            inline = true
        })
    end
    
    -- Add timestamp field
    table.insert(embed.fields, {
        name = 'Time',
        value = deathData.time,
        inline = true
    })
    
    Utils.SendEmbedToDiscord(embed)
end)

-- Command Usage Event
AddEventHandler('pixel_logs:commandUsage', function(data)
    if not Config.LogTypes['player_commands'] then return end
    
    local source = source
    local playerName = GetPlayerNameSafe(source)
    
    local commandData = {
        player = playerName,
        id = source,
        time = os.date('%Y-%m-%d %H:%M:%S'),
        command = data.command or 'Unknown',
        args = data.args or 'None'
    }
    
    local message = Utils.FormatMessage('player_commands', Config.Messages['player_commands'].description, commandData)
    local embed = {
        title = Config.Messages['player_commands'].title,
        description = message,
        color = Config.Colors['player_commands'],
        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
        footer = {
            text = 'Server Logs'
        },
        fields = {}
    }
    
    -- Add player info fields
    table.insert(embed.fields, {
        name = 'Player Information',
        value = string.format('```\nName: %s\nID: %s\n```', commandData.player, commandData.id),
        inline = false
    })
    
    -- Add command info fields
    table.insert(embed.fields, {
        name = 'Command',
        value = commandData.command,
        inline = true
    })
    
    table.insert(embed.fields, {
        name = 'Arguments',
        value = string.format('```\n%s\n```', commandData.args),
        inline = false
    })
    
    -- Add timestamp field
    table.insert(embed.fields, {
        name = 'Time',
        value = commandData.time,
        inline = true
    })
    
    Utils.SendEmbedToDiscord(embed)
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
        local embed = {
            title = Config.Messages['player_resources'].title,
            description = message,
            color = Config.Colors['player_resources'],
            timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
            footer = {
                text = 'Server Logs'
            },
            fields = {}
        }
        
        -- Add resource info fields
        table.insert(embed.fields, {
            name = 'Resource Information',
            value = string.format('```\nName: %s\nAction: %s\n```', data.resource, data.action),
            inline = false
        })
        
        -- Add timestamp field
        table.insert(embed.fields, {
            name = 'Time',
            value = data.time,
            inline = true
        })
        
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
        local embed = {
            title = Config.Messages['player_resources'].title,
            description = message,
            color = Config.Colors['player_resources'],
            timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
            footer = {
                text = 'Server Logs'
            },
            fields = {}
        }
        
        -- Add resource info fields
        table.insert(embed.fields, {
            name = 'Resource Information',
            value = string.format('```\nName: %s\nAction: %s\n```', data.resource, data.action),
            inline = false
        })
        
        -- Add timestamp field
        table.insert(embed.fields, {
            name = 'Time',
            value = data.time,
            inline = true
        })
        
        Utils.SendEmbedToDiscord(embed)
    end
end)

-- Administrative Actions Event
AddEventHandler('pixel_logs:adminAction', function(data)
    if not Config.LogTypes[data.type] then return end
    
    local source = source
    local adminName = GetPlayerNameSafe(source)
    
    local actionData = {
        admin = adminName,
        adminId = source,
        player = data.player or 'Unknown',
        playerId = data.playerId or 'Unknown',
        time = os.date('%Y-%m-%d %H:%M:%S'),
        reason = data.reason or 'No reason provided',
        duration = data.duration or 'Permanent',
        type = data.type or 'Unknown'
    }
    
    local message = Utils.FormatMessage(data.type, Config.Messages[data.type].description, actionData)
    local embed = {
        title = Config.Messages[data.type].title,
        description = message,
        color = Config.Colors[data.type],
        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
        footer = {
            text = 'Server Logs'
        },
        fields = {}
    }
    
    -- Add admin info fields
    table.insert(embed.fields, {
        name = 'Admin Information',
        value = string.format('```\nName: %s\nID: %s\n```', actionData.admin, actionData.adminId),
        inline = false
    })
    
    -- Add player info fields
    table.insert(embed.fields, {
        name = 'Player Information',
        value = string.format('```\nName: %s\nID: %s\n```', actionData.player, actionData.playerId),
        inline = false
    })
    
    -- Add action info fields
    table.insert(embed.fields, {
        name = 'Action Type',
        value = actionData.type:upper(),
        inline = true
    })
    
    if actionData.duration ~= 'Permanent' then
        table.insert(embed.fields, {
            name = 'Duration',
            value = actionData.duration,
            inline = true
        })
    end
    
    table.insert(embed.fields, {
        name = 'Reason',
        value = actionData.reason,
        inline = false
    })
    
    -- Add timestamp field
    table.insert(embed.fields, {
        name = 'Time',
        value = actionData.time,
        inline = true
    })
    
    Utils.SendEmbedToDiscord(embed)
end) 