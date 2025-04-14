--[[
    Pixel Logs - Event Handlers
    Version: 1.04122025
]]

local Utils = exports['pixel_logs']:GetUtils()

-- Ensure Config.LogTypes entries for txAdmin events are present and enabled
if not Config.LogTypes then Config.LogTypes = {} end

Config.LogTypes.txadmin_restart_skipped = Config.LogTypes.txadmin_restart_skipped or true
Config.LogTypes.txadmin_direct_message = Config.LogTypes.txadmin_direct_message or true
Config.LogTypes.txadmin_player_healed = Config.LogTypes.txadmin_player_healed or true
Config.LogTypes.txadmin_whitelist_preapproval = Config.LogTypes.txadmin_whitelist_preapproval or true
Config.LogTypes.txadmin_whitelist_request = Config.LogTypes.txadmin_whitelist_request or true
Config.LogTypes.txadmin_action_revoked = Config.LogTypes.txadmin_action_revoked or true
Config.LogTypes.txadmin_admin_auth = Config.LogTypes.txadmin_admin_auth or true
Config.LogTypes.txadmin_admins_updated = Config.LogTypes.txadmin_admins_updated or true
Config.LogTypes.txadmin_config_changed = Config.LogTypes.txadmin_config_changed or true
Config.LogTypes.txadmin_console_command = Config.LogTypes.txadmin_console_command or true
Config.LogTypes.txadmin_announcement = Config.LogTypes.txadmin_announcement or true
Config.LogTypes.txadmin_shutdown = Config.LogTypes.txadmin_shutdown or true

-- Helper function to safely get player name
local function GetPlayerNameSafe(source)
    local success, name = pcall(GetPlayerName, source)
    if not success then
        exports['pixel_logs']:CatchError('Failed to get player name', 'GetPlayerNameSafe', {
            source = source,
            error = name
        })
        return 'Unknown'
    end
    return name
end

-- Helper function to get player identifiers
local function GetPlayerIdentifiers(source)
    local identifiers = {}
    local success, numIds = pcall(GetNumPlayerIdentifiers, source)
    
    if not success then
        exports['pixel_logs']:CatchError('Failed to get player identifiers count', 'GetPlayerIdentifiers', {
            source = source,
            error = numIds
        })
        return identifiers
    end
    
    for i = 0, numIds - 1 do
        local success, id = pcall(GetPlayerIdentifier, source, i)
        if success and id then
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
        
        -- Use the CreateEmbed function for better formatting
        local embed = Utils.CreateEmbed('player_join', message, source, nil, data)
        
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
        
        -- Use the CreateEmbed function for better formatting
        local embed = Utils.CreateEmbed('player_leave', message, source, nil, data)
        
        -- Add additional fields if needed
        if embed and embed.fields then
            -- Add play time field
            table.insert(embed.fields, {
                name = 'Play Time',
                value = data.time,
                inline = true
            })
            
            -- Add reason field
            table.insert(embed.fields, {
                name = 'Reason',
                value = data.reason,
                inline = true
            })
        end
        
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
    -- Special handling for pixel_logs itself
    if resourceName == GetCurrentResourceName() then
        -- Only send startup embed if we haven't already sent one
        if not _G.pixel_logs_startup_sent then
            _G.pixel_logs_startup_sent = true
            
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
        end
        return
    end
    
    -- Handle other resources
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

-- txAdmin Event Monitoring
AddEventHandler('txAdmin:events:announcement', function(eventData)
    if not Config.LogTypes.txadmin_announcement then return end
    local embed = Utils.CreateEmbed('txadmin_announcement', Config.Messages['txadmin_announcement'].description, nil, Config.Colors['txadmin_announcement'], {
        author = eventData.author or 'txAdmin',
        message = eventData.message or 'No message provided',
        timestamp = os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:serverShuttingDown', function(eventData)
    if not Config.LogTypes.txadmin_shutdown then return end
    local embed = Utils.CreateEmbed('txadmin_shutdown', Config.Messages['txadmin_shutdown'].description, nil, Config.Colors['txadmin_shutdown'], {
        delay = string.format('%d seconds', (eventData.delay or 0) / 1000),
        author = eventData.author or 'txAdmin',
        message = eventData.message or 'No message provided',
        timestamp = os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if not Config.LogTypes.txadmin_restart_skipped then return end
    local embed = Utils.CreateEmbed('scheduled_restart', Config.Messages['scheduled_restart'].description, nil, Config.Colors['scheduled_restart'], {
        seconds = eventData.secondsRemaining or 0,
        message = eventData.translatedMessage or 'No message provided',
        timestamp = os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:scheduledRestartSkipped', function(eventData)
    if not Config.LogTypes.txadmin_restart_skipped then return end
    local embed = Utils.CreateEmbed('txadmin_restart_skipped', Config.Messages['txadmin_restart_skipped'].description, nil, Config.Colors['txadmin_restart_skipped'], {
        secondsRemaining = eventData.secondsRemaining or 0,
        temporary = tostring(eventData.temporary or false),
        author = eventData.author or 'Unknown',
        timestamp = os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:playerDirectMessage', function(eventData)
    if not Config.LogTypes.txadmin_direct_message then return end
    local embed = Utils.CreateEmbed('txadmin_direct_message', Config.Messages['txadmin_direct_message'].description, nil, Config.Colors['txadmin_direct_message'], {
        author = eventData.author or 'Unknown',
        target = eventData.target or 'Unknown',
        message = eventData.message or 'No message provided',
        timestamp = os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:playerHealed', function(eventData)
    if not Config.LogTypes.txadmin_player_healed then return end
    local embed = Utils.CreateEmbed('txadmin_player_healed', Config.Messages['txadmin_player_healed'].description, nil, Config.Colors['txadmin_player_healed'], {
        author = eventData.author or 'Unknown',
        target = eventData.target or 'Entire Server',
        timestamp = os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:playerWarned', function(eventData)
    if not Config.LogTypes.txadmin_player_warned then return end
    local embed = Utils.CreateEmbed('txadmin_player_warned', Config.Messages['txadmin_player_warned'].description, nil, Config.Colors['txadmin_player_warned'], {
        author = eventData.author or 'Unknown',
        reason = eventData.reason or 'No reason provided',
        target = eventData.targetName or 'Unknown',
        identifiers = table.concat(eventData.targetIds or {}, '\n'),
        timestamp = os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:whitelistPlayer', function(eventData)
    if not Config.LogTypes.txadmin_whitelist_player then return end
    local embed = Utils.CreateEmbed('whitelist_update', Config.Messages['whitelist_update'].description, nil, Config.Colors['whitelist_update'], {
        action = eventData.action or 'Unknown',
        player = eventData.playerName or 'Unknown',
        admin = eventData.adminName or 'Unknown',
        license = eventData.license or 'Unknown',
        timestamp = os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:playerBanned', function(eventData)
    if not Config.LogTypes.player_bans then return end
    
    local embed = Utils.CreateEmbed('player_banned', 'Player banned', eventData.targetNetId, 16711680, {
        author = eventData.author,
        reason = eventData.reason,
        duration = eventData.durationTranslated or 'Permanent',
        target = eventData.targetName,
        identifiers = table.concat(eventData.targetIds, '\n'),
        hwids = table.concat(eventData.targetHwids, '\n')
    })
    
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:playerKicked', function(eventData)
    if not Config.LogTypes.player_kicks then return end
    
    local embed = Utils.CreateEmbed('player_kicked', 'Player kicked', eventData.target, 16711680, {
        author = eventData.author,
        reason = eventData.reason,
        message = eventData.dropMessage
    })
    
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:whitelistPreApproval', function(eventData)
    if not Config.LogTypes.txadmin_whitelist_preapproval then return end
    local embed = Utils.CreateEmbed('txadmin_whitelist_preapproval', {
        eventData.admin or 'Unknown',
        eventData.license or 'Unknown',
        eventData.discord or 'Unknown',
        os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:whitelistRequest', function(eventData)
    if not Config.LogTypes.txadmin_whitelist_request then return end
    local embed = Utils.CreateEmbed('txadmin_whitelist_request', {
        eventData.license or 'Unknown',
        eventData.discord or 'Unknown',
        os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:actionRevoked', function(eventData)
    if not Config.LogTypes.txadmin_action_revoked then return end
    local embed = Utils.CreateEmbed('txadmin_action_revoked', {
        eventData.revokedBy or 'Unknown',
        eventData.actionType or 'Unknown',
        eventData.target or 'Unknown',
        eventData.reason or 'No reason provided',
        os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:adminAuth', function(eventData)
    if not Config.LogTypes.txadmin_admin_auth then return end
    local embed = Utils.CreateEmbed('txadmin_admin_auth', {
        eventData.admin or 'Unknown',
        eventData.action or 'Unknown',
        os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:adminsUpdated', function(eventData)
    if not Config.LogTypes.txadmin_admins_updated then return end
    local embed = Utils.CreateEmbed('txadmin_admins_updated', {
        eventData.updatedBy or 'Unknown',
        eventData.action or 'Unknown',
        os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:configChanged', function(eventData)
    if not Config.LogTypes.txadmin_config_changed then return end
    local embed = Utils.CreateEmbed('txadmin_config_changed', {
        eventData.changedBy or 'Unknown',
        eventData.changes or 'No changes details provided',
        os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)

AddEventHandler('txAdmin:events:consoleCommand', function(eventData)
    if not Config.LogTypes.txadmin_console_command then return end
    local embed = Utils.CreateEmbed('txadmin_console_command', {
        eventData.admin or 'Unknown',
        eventData.command or 'Unknown',
        os.date('%Y-%m-%d %H:%M:%S')
    })
    Utils.SendEmbedToDiscord(embed)
end)