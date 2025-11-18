local wezterm = require 'wezterm'
local config = wezterm.config_builder()


config.color_scheme = 'OneHalfDark'
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.front_end = "WebGpu"

config.font = wezterm.font_with_fallback({
    "CodeNewRoman Nerd Font Mono"
})
config.font_size = 11

local shells = nil
if string.find(wezterm.target_triple, "windows") then
    config.default_domain = "WSL:Ubuntu-24.04"
    shells = {
        { key = 'n', args = 'C:\\Windows\\System32\\wsl.exe -d Ubuntu-24.04' },
        { key = 'g', args = 'C:\\Program Files\\Git\\bin\\bash.exe' },
    }
    config.font_size = 9
    -- config.window_background_gradient = {
    --     orientation = 'Vertical',
    --     colors = {
    --         '#0f0c29',
    --         '#282c34'
    --     },
    --     interpolation = 'Linear',
    --     blend = 'Rgb'
    -- }
else
    shells = {
        { key = 'n', args = '/usr/bin/fish' },
        { key = 'b', args = '/usr/bin/bash' }
    }
    config.background = {
        {
            source = { File = 'stuff/wezterm/term_back.png' },
            hsb = {
                brightness = 0.03, -- Set brightness to 50%
                hue = 1.0,         -- No change to hue
                saturation = 1.0,  -- No change to saturation
            },
            vertical_align = "Middle",
            horizontal_align = "Right"
        }
    }
end
config.default_prog = { shells[1].args }

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

for _, shell in ipairs(shells) do
    table.insert(config.keys, {
        key = shell.key,
        mods = 'ALT',
        action = wezterm.action.SpawnCommandInNewTab { args = { shell.args } }
    })
end

return config
