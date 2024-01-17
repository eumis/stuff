local M = {}
local keymap = require('usr.keymap')

function M.setup()
    require('copilot').setup({
        panel = {
            enabled = false,
            auto_refresh = false,
            keymap = keymap.get_copilot_panel_keymap(),
            layout = {
                position = "bottom", -- | top | left | right
                ratio = 0.4
            },
        },
        suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
            keymap = keymap.get_copilot_suggestion_keymap(),
        },
        filetypes = {
            yaml = false,
            markdown = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        server_opts_overrides = {},
    })

    --require("copilot_cmp").setup()
end

return M
