local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local default_shell = 'C:\\Program Files\\Git\\usr\\bin\\bash.exe'
config.color_scheme = 'OneHalfDark'
config.use_fancy_tab_bar = true
--config.window_background_image = 'C:\\Users\\EugenMisievich\\stuff\\kitty\\term_back.png'
--config.window_background_image_hsb = {
    --brightness = 0.04, -- Set brightness to 50%
    --hue = 1.0,        -- No change to hue
    --saturation = 1.0, -- No change to saturation
--}
--config.window_background_image_scale = "Contain" -- Options: "Contain", "Cover", "Fill", etc.


config.background = {
    {
        source = {File="C:\\Users\\EugenMisievich\\stuff\\kitty\\term_back.png"},
        hsb = {
            brightness = 0.04, -- Set brightness to 50%
            hue = 1.0,        -- No change to hue
            saturation = 1.0, -- No change to saturation
        },
        vertical_align = "Middle"
    }
}

config.font = wezterm.font("CodeNewRoman Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 9

config.default_prog = { default_shell }

config.keys = {
    {
        key = 'n',
        mods = 'ALT',
        action = wezterm.action.SpawnCommandInNewTab { args = { default_shell } }
    },
    {
        key = 'l',
        mods = 'ALT',
        action = wezterm.action.SpawnCommandInNewTab { args = { 'C:\\WINDOWS\\system32\\wsl.exe -d Ubuntu' } }
    },
    {
        key = 'p',
        mods = 'ALT',
        action = wezterm.action.SpawnCommandInNewTab { args = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' } }
    },
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

return config
