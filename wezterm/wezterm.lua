local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local os_config = {}

if string.find(wezterm.target_triple, "windows") then
    os_config.shells = {
        { key = 'n', args = 'C:\\Program Files\\Git\\usr\\bin\\bash.exe' },
        { key = 'l', args = 'C:\\WINDOWS\\system32\\wsl.exe -d Ubuntu' },
        { key = 'p', args = 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }
    }
    os_config.font_size = 9
else
    os_config.shells = {
        { key = 'n', args = '/usr/bin/fish' },
        { key = 'b', args = '/usr/bin/bash' }
    }
    os_config.font_size = 12
end

config.color_scheme = 'OneHalfDark'
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.background = {
    {
        source = { File = "stuff/wezterm/term_back.png" },
        hsb = {
            brightness = 0.03, -- Set brightness to 50%
            hue = 1.0,         -- No change to hue
            saturation = 1.0,  -- No change to saturation
        },
        vertical_align = "Middle",
        horizontal_align = "Right"
    }
}

config.font = wezterm.font("CodeNewRoman Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = os_config.font_size

config.default_prog = { os_config.shells[1].args }

config.keys = {
    {
        key = 'd',
        mods = 'ALT',
        action = wezterm.action.CloseCurrentTab { confirm = false }
    },
    {
        key = 'k',
        mods = 'ALT',
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        key = 'j',
        mods = 'ALT',
        action = wezterm.action.ActivateTabRelative(-1)
    },
}

for _, shell in ipairs(os_config.shells) do
    table.insert(config.keys, {
        key = shell.key,
        mods = 'ALT',
        action = wezterm.action.SpawnCommandInNewTab { args = { shell.args } }
    })
end

return config
