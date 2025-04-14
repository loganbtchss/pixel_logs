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
    },
    -- txAdmin Event Messages
    ['txadmin_announcement'] = {
        title = "Server Announcement",
        description = "A server announcement has been made",
        fields = {
            {name = "Announcer", value = "%s", inline = true},
            {name = "Message", value = "%s", inline = false},
            {name = "Timestamp", value = "%s", inline = true}
        }
    },
    ['txadmin_shutdown'] = {
        title = "Server Shutdown",
        description = "The server is shutting down",
        fields = {
            {name = "Reason", value = "%s", inline = false},
            {name = "Initiated By", value = "%s", inline = true},
            {name = "Timestamp", value = "%s", inline = true}
        }
    },
    ['txadmin_restart_skipped'] = {
        title = "Scheduled Restart Skipped",
        description = "A scheduled restart was skipped",
        fields = {
            {name = "Skipped By", value = "%s", inline = true},
            {name = "Reason", value = "%s", inline = false},
            {name = "Timestamp", value = "%s", inline = true}
        }
    },
    ['txadmin_direct_message'] = {
        title = "Admin Direct Message",
        description = "An admin has sent a direct message to a player",
        fields = {
            {name = "Admin", value = "%s", inline = true},
            {name = "Player", value = "%s", inline = true},
            {name = "Message", value = "%s", inline = false},
            {name = "Timestamp", value = "%s", inline = true}
        }
    },
    ['txadmin_player_healed'] = {
        title = "Player Healed",
        description = "A player has been healed by an admin",
        fields = {
            {name = "Admin", value = "%s", inline = true},
            {name = "Player", value = "%s", inline = true},
            {name = "Timestamp", value = "%s", inline = true}
        }
    },
    ['txadmin_whitelist_preapproval'] = {
        title = "Whitelist Pre-Approval",
        description = "A whitelist request has been pre-approved",
        fields = {
            {name = "Admin", value = "%s", inline = true},
            {name = "License", value = "%s", inline = true},
            {name = "Discord", value = "%s", inline = true},
            {name = "Timestamp", value = "%s", inline = true}
        }
    },
    ['txadmin_whitelist_request'] = {
        title = "Whitelist Request",
        description = "A new whitelist request has been submitted",
        fields = {
            {name = "License", value = "%s", inline = true},
            {name = "Discord", value = "%s", inline = true},
            {name = "Timestamp", value = "%s", inline = true}
        }
    },
    ['txadmin_action_revoked'] = {
        title = "Admin Action Revoked",
        description = "An admin action has been revoked",
        fields = {
            {name = "Revoked By", value = "%s", inline = true},
            {name = "Action Type", value = "%s", inline = true},
            {name = "Target", value = "%s", inline = true},
            {name = "Reason", value = "%s", inline = false},
            {name = "Timestamp", value = "%s", inline = true}
        }
    },
    ['txadmin_admin_auth'] = {
        title = "Admin Authentication",
        description = "An admin has authenticated",
        fields = {
            {name = "Admin", value = "%s", inline = true},
            {name = "Action", value = "%s", inline = true},
            {name = "Timestamp", value = "%s", inline = true}
        }
    },
    ['txadmin_admins_updated'] = {
        title = "Admin List Updated",
        description = "The admin list has been updated",
        fields = {
            {name = "Updated By", value = "%s", inline = true},
            {name = "Action", value = "%s", inline = true},
            {name = "Timestamp", value = "%s", inline = true}
        }
    },
    ['txadmin_config_changed'] = {
        title = "txAdmin Config Changed",
        description = "The txAdmin configuration has been changed",
        fields = {
            {name = "Changed By", value = "%s", inline = true},
            {name = "Changes", value = "%s", inline = false},
            {name = "Timestamp", value = "%s", inline = true}
        }
    },
    ['txadmin_console_command'] = {
        title = "Console Command",
        description = "A console command has been executed",
        fields = {
            {name = "Admin", value = "%s", inline = true},
            {name = "Command", value = "%s", inline = false},
            {name = "Timestamp", value = "%s", inline = true}
        }
    }
}

-- Set Colors in Config
Config.Colors = {
    ['player_join'] = 5763719, -- Nice blue color
    ['player_leave'] = 15158332, -- Nice red color
    ['player_death'] = 16711680, -- Red
    ['player_chat'] = 16776960, -- Yellow
    ['player_bans'] = 16711680, -- Red
    ['player_kicks'] = 16711680, -- Red
    ['player_warns'] = 16776960, -- Yellow
    ['player_commands'] = 16776960, -- Yellow
    ['player_connections'] = 255, -- Blue
    ['player_resources'] = 16776960 -- Yellow
} 