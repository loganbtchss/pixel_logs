-- Set Messages and Colors in Config
Config.Messages = {
    ['player_join'] = {
        title = 'Player Joined',
        description = '**{player}** has joined the server',
        fields = {
            {
                name = 'Player Information',
                value = '```\nName: {player}\nID: {id}\n```',
                inline = false
            },
            {
                name = 'Connection Time',
                value = '{time}',
                inline = true
            }
        }
    },
    ['player_leave'] = {
        title = 'Player Left',
        description = '**{player}** has left the server',
        fields = {
            {
                name = 'Player Information',
                value = '```\nName: {player}\nID: {id}\n```',
                inline = false
            },
            {
                name = 'Play Time',
                value = '{time}',
                inline = true
            },
            {
                name = 'Reason',
                value = '{reason}',
                inline = true
            }
        }
    },
    ['player_death'] = {
        title = 'Player Death',
        description = '**{player}** has died',
        fields = {
            {
                name = 'Player Information',
                value = '```\nName: {player}\nID: {id}\n```',
                inline = false
            },
            {
                name = 'Death Location',
                value = '{location}',
                inline = true
            },
            {
                name = 'Killer',
                value = '{killer}',
                inline = true
            },
            {
                name = 'Weapon',
                value = '{weapon}',
                inline = true
            }
        }
    },
    ['player_chat'] = {
        title = 'Chat Message',
        description = '**{player}**: {message}',
        fields = {
            {
                name = 'Player Information',
                value = '```\nName: {player}\nID: {id}\n```',
                inline = false
            },
            {
                name = 'Channel',
                value = '{channel}',
                inline = true
            }
        }
    },
    ['player_bans'] = {
        title = 'Player Banned',
        description = '**{player}** has been banned',
        fields = {
            {
                name = 'Player Information',
                value = '```\nName: {player}\nID: {id}\n```',
                inline = false
            },
            {
                name = 'Admin',
                value = '{admin}',
                inline = true
            },
            {
                name = 'Duration',
                value = '{duration}',
                inline = true
            },
            {
                name = 'Reason',
                value = '{reason}',
                inline = false
            }
        }
    },
    ['player_kicks'] = {
        title = 'Player Kicked',
        description = '**{player}** has been kicked',
        fields = {
            {
                name = 'Player Information',
                value = '```\nName: {player}\nID: {id}\n```',
                inline = false
            },
            {
                name = 'Admin',
                value = '{admin}',
                inline = true
            },
            {
                name = 'Reason',
                value = '{reason}',
                inline = false
            }
        }
    },
    ['player_warns'] = {
        title = 'Player Warned',
        description = '**{player}** has been warned',
        fields = {
            {
                name = 'Player Information',
                value = '```\nName: {player}\nID: {id}\n```',
                inline = false
            },
            {
                name = 'Admin',
                value = '{admin}',
                inline = true
            },
            {
                name = 'Reason',
                value = '{reason}',
                inline = false
            }
        }
    },
    ['player_commands'] = {
        title = 'Command Used',
        description = '**{player}** used a command',
        fields = {
            {
                name = 'Player Information',
                value = '```\nName: {player}\nID: {id}\n```',
                inline = false
            },
            {
                name = 'Command',
                value = '```\n{command}\n```',
                inline = false
            },
            {
                name = 'Arguments',
                value = '```\n{args}\n```',
                inline = false
            }
        }
    },
    ['player_connections'] = {
        title = 'Connection Event',
        description = '**{player}** {action} the server',
        fields = {
            {
                name = 'Player Information',
                value = '```\nName: {player}\nID: {id}\n```',
                inline = false
            },
            {
                name = 'Time',
                value = '{time}',
                inline = true
            }
        }
    },
    ['player_resources'] = {
        title = 'Resource Event',
        description = 'Resource **{resource}** has been {action}',
        fields = {
            {
                name = 'Resource Information',
                value = '```\nName: {resource}\nAction: {action}\n```',
                inline = false
            },
            {
                name = 'Time',
                value = '{time}',
                inline = true
            }
        }
    },
    ['server_shutdown'] = {
        title = 'Server Shutdown',
        description = 'Server is shutting down',
        fields = {
            {
                name = 'Author',
                value = '{author}',
                inline = true
            },
            {
                name = 'Delay',
                value = '{delay}',
                inline = true
            },
            {
                name = 'Message',
                value = '{message}',
                inline = false
            }
        }
    },
    ['scheduled_restart'] = {
        title = 'Scheduled Restart',
        description = 'Server will restart in {seconds} seconds',
        fields = {
            {
                name = 'Message',
                value = '{message}',
                inline = false
            }
        }
    },
    ['player_banned'] = {
        title = 'Player Banned',
        description = '**{target}** has been banned',
        fields = {
            {
                name = 'Admin',
                value = '{author}',
                inline = true
            },
            {
                name = 'Duration',
                value = '{duration}',
                inline = true
            },
            {
                name = 'Reason',
                value = '{reason}',
                inline = false
            },
            {
                name = 'Identifiers',
                value = '```\n{identifiers}\n```',
                inline = false
            },
            {
                name = 'Hardware IDs',
                value = '```\n{hwids}\n```',
                inline = false
            }
        }
    },
    ['player_kicked'] = {
        title = 'Player Kicked',
        description = '**{target}** has been kicked',
        fields = {
            {
                name = 'Admin',
                value = '{author}',
                inline = true
            },
            {
                name = 'Reason',
                value = '{reason}',
                inline = false
            },
            {
                name = 'Kick Message',
                value = '{message}',
                inline = false
            }
        }
    },
    ['player_warned'] = {
        title = 'Player Warned',
        description = '**{target}** has been warned',
        fields = {
            {
                name = 'Admin',
                value = '{author}',
                inline = true
            },
            {
                name = 'Reason',
                value = '{reason}',
                inline = false
            },
            {
                name = 'Identifiers',
                value = '```\n{identifiers}\n```',
                inline = false
            }
        }
    },
    ['whitelist_update'] = {
        title = 'Whitelist Update',
        description = 'Whitelist status changed for **{player}**',
        fields = {
            {
                name = 'Action',
                value = '{action}',
                inline = true
            },
            {
                name = 'Admin',
                value = '{admin}',
                inline = true
            },
            {
                name = 'License',
                value = '{license}',
                inline = false
            }
        }
    }
}

-- Set Colors in Config
Config.Colors = {
    ['player_join'] = 65280, -- Green
    ['player_leave'] = 16711680, -- Red
    ['player_death'] = 16711680, -- Red
    ['player_chat'] = 16776960, -- Yellow
    ['player_bans'] = 16711680, -- Red
    ['player_kicks'] = 16711680, -- Red
    ['player_warns'] = 16776960, -- Yellow
    ['player_commands'] = 16776960, -- Yellow
    ['player_connections'] = 255, -- Blue
    ['player_resources'] = 16776960 -- Yellow
} 