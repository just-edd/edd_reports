Config = {}

---@type string Command to open report menu
Config.command = 'report'
---@type string | nil If set to nil, then only command will work
Config.keybind = 'F7'

---@class Admin
---@field command string Command to open report admin menu
---@field groups string[] Groups that are allowed to report admin menu

---@type Admin
Config.admin = {
    command = 'reports',
    groups = { 'admin', 'god', 'moderator', 'developer' }
}

---@type number Prevent spamming chat
Config.messageCooldown = 2000