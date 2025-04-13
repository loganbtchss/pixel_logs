--[[
    Pixel Logs - Server Initialization
    Version: 1.04122025
]]

local versionStatus = '^8Checking...^0'
local versionCheckComplete = false

-- Helper function to count table elements
function table_count(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

-- Helper function to safely get resource metadata
local function GetResourceMetadataSafe(resource, key, index)
    local success, result = pcall(function()
        return GetResourceMetadata(resource, key, index)
    end)
    return success and result or 'Unknown'
end

-- Helper function to safely get convar
local function GetConvarSafe(name, default)
    local success, result = pcall(function()
        return GetConvar(name, default)
    end)
    return success and result or default
end

-- Function to check required convars
local function CheckRequiredConvars()
    local requiredConvars = {
        {name = 'pixel_logs_webhook', description = 'Discord webhook URL'}
    }
    
    local missingConvars = {}
    
    for _, convar in ipairs(requiredConvars) do
        local value = GetConvar(convar.name, '')
        if value == '' then
            table.insert(missingConvars, convar.description)
        end
    end
    
    if #missingConvars > 0 then
        print('^1[pixel_logs] ERROR: Required convars are missing:^7')
        for _, convar in ipairs(missingConvars) do
            print('^1- ' .. convar .. '^7')
        end
        print('^1[pixel_logs] Resource will not start until all required convars are set.^7')
        return false
    end
    
    return true
end

-- Check required convars before starting
if not CheckRequiredConvars() then
    return
end

local function PrintStartupLog()
    print('^0')
    print('^0┌─────────────────────────────────────────────────────────────────────┐')
    print('^0│ ^3██████╗ ██╗██╗  ██╗███████╗██╗      ██████╗  ██████╗ ███████╗^0   │')
    print('^0│ ^3██╔══██╗██║╚██╗██╔╝██╔════╝██║     ██╔═══██╗██╔════╝ ██╔════╝^0   │')
    print('^0│ ^3██████╔╝██║ ╚███╔╝ █████╗  ██║     ██║   ██║██║  ███╗███████╗^0   │')
    print('^0│ ^3██╔═══╝ ██║ ██╔██╗ ██╔══╝  ██║     ██║   ██║██║   ██║╚════██║^0   │')
    print('^0│ ^3██║     ██║██╔╝ ██╗███████╗███████╗╚██████╔╝╚██████╔╝███████║^0   │')
    print('^0│ ^3╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝^0   │')
    print('^0├─────────────────────────────────────────────────────────────────────┤')
    print('^0│ ^7Version: ^2' .. GetResourceMetadataSafe(GetCurrentResourceName(), 'version', 0) .. '^0 │')
    print('^0│ ^7Status: ' .. versionStatus .. '^0                                 │')
    print('^0│ ^7Author: ^2Pixelated ^7(^5codemeapixel.dev^7)^0                    │')
    print('^0│ ^7Repository: ^5https://github.com/ByteBrushStudios/pixel_logs^0    │')
    print('^0├─────────────────────────────────────────────────────────────────────┤')
    
    -- Check webhook configuration
    if Config.DiscordWebhook == '' then
        print('^0│ ^1⚠️  WARNING: ^7No Discord webhook configured!^0 │')
    else
        print('^0│ ^7Discord Webhook: ^2Configured^0 │')
    end
    
    -- Check debug configuration
    if Config.Debug.Enabled then
        print('^0│ ^7Debug Mode: ^2Enabled^0 │')
        if Config.Debug.Webhook == '' then
            print('^0│ ^1⚠️  WARNING: ^7No debug webhook configured!^0 │')
        else
            print('^0│ ^7Debug Webhook: ^2Configured^0 │')
        end
    else
        print('^0│ ^7Debug Mode: ^8Disabled^0 │')
    end
    
    -- Show enabled log types
    local enabledLogs = {}
    for logType, enabled in pairs(Config.LogTypes) do
        if enabled then
            table.insert(enabledLogs, logType)
        end
    end
    
    print('^0│ ^7Enabled Log Types: ^2' .. #enabledLogs .. '^7/^2' .. table_count(Config.LogTypes) .. '^0 │')
    print('^0└─────────────────────────────────────────────────────────────┘')
    print('^0')
end

local function CheckVersion()
    local currentVersion = GetResourceMetadataSafe(GetCurrentResourceName(), 'version', 0)
    local repo = 'https://api.github.com/repos/ByteBrushStudios/pixel_logs/releases/latest'
    
    PerformHttpRequest(repo, function(err, response, headers)
        if err == 200 then
            local success, data = pcall(function() return json.decode(response) end)
            if success and data then
                local latestVersion = data.tag_name:gsub('v', '')
                
                if currentVersion == latestVersion then
                    versionStatus = '^2Up to Date^0'
                else
                    versionStatus = '^1Outdated^0 (Latest: ^2' .. latestVersion .. '^0)'
                end
            else
                versionStatus = '^8API Error^0'
                if Config.Debug.Enabled then
                    exports['pixel_logs']:AddDebugLog('error', {
                        title = 'Version Check Failed',
                        description = 'Failed to parse GitHub API response. Please reference this log when requesting support.',
                        fields = {
                            {
                                name = 'Error Details',
                                value = string.format('```\nError: Failed to parse JSON response\nResponse: %s```', 
                                    response or 'No response'
                                ),
                                inline = false
                            },
                            {
                                name = 'Resource Info',
                                value = string.format('```\nResource: %s\nVersion: %s\nServer: %s```',
                                    GetCurrentResourceName(),
                                    currentVersion,
                                    GetConvarSafe('sv_hostname', 'Unknown')
                                ),
                                inline = false
                            }
                        }
                    })
                end
            end
        else
            versionStatus = '^8API Unavailable^0'
            
            -- Debug logging if enabled
            if Config.Debug.Enabled then
                exports['pixel_logs']:AddDebugLog('error', {
                    title = 'Version Check Failed',
                    description = 'Failed to check for updates. Please reference this log when requesting support.',
                    fields = {
                        {
                            name = 'Error Details',
                            value = string.format('```\nError Code: %s\nResponse: %s\nHeaders: %s```', 
                                err, 
                                response or 'No response',
                                json.encode(headers) or 'No headers'
                            ),
                            inline = false
                        },
                        {
                            name = 'Resource Info',
                            value = string.format('```\nResource: %s\nVersion: %s\nServer: %s```',
                                GetCurrentResourceName(),
                                currentVersion,
                                GetConvarSafe('sv_hostname', 'Unknown')
                            ),
                            inline = false
                        },
                        {
                            name = 'Support Note',
                            value = 'When requesting support, please include this debug log and any relevant error messages you see in the console.',
                            inline = false
                        }
                    }
                })
            end
        end
        
        versionCheckComplete = true
        PrintStartupLog()
    end, 'GET', '', {['User-Agent'] = 'Pixel-Logs'})
end

-- Start version check and wait for completion
CreateThread(function()
    local success, err = pcall(function()
        -- Skip version check if debug_noversion is enabled
        if Config.Debug.NoVersion then
            versionStatus = '^8Skipped (Debug Mode)^0'
            versionCheckComplete = true
            PrintStartupLog()
            return
        end
        
        CheckVersion()
        while not versionCheckComplete do
            Wait(100)
        end
    end)
    
    if not success then
        print('^1[Pixel Logs] Fatal Error: ' .. tostring(err) .. '^0')
        if Config.Debug.Enabled then
            exports['pixel_logs']:AddDebugLog('error', {
                title = 'Fatal Error',
                description = 'A fatal error occurred during initialization. Please reference this log when requesting support.',
                fields = {
                    {
                        name = 'Error Details',
                        value = string.format('```\n%s```', tostring(err)),
                        inline = false
                    },
                    {
                        name = 'Resource Info',
                        value = string.format('```\nResource: %s\nVersion: %s\nServer: %s```',
                            GetCurrentResourceName(),
                            GetResourceMetadataSafe(GetCurrentResourceName(), 'version', 0),
                            GetConvarSafe('sv_hostname', 'Unknown')
                        ),
                        inline = false
                    }
                }
            })
        end
    end
end) 