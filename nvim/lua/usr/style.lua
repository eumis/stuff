local M = {}

function M.setup()
    vim.o.background = 'dark'
    local c = require('vscode.colors')
    require('vscode').setup({
        -- Enable transparent background
        transparent = true,
        -- Enable italic comment
        italic_comments = false,
        -- Disable nvim-tree background color
        disable_nvimtree_bg = true,
        -- Override colors (see ./lua/vscode/colors.lua)
        color_overrides = {},
        -- Override highlight groups (see ./lua/vscode/theme.lua)
        group_overrides = {
            -- this supports the same val table as vim.api.nvim_set_hl
            -- use colors from this colorscheme by requiring vscode.colors!
            Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
        }
    })
    require('vscode').load()

    if vim.g.neovide == true then
        vim.g.neovide_remember_window_size = true
    else
        require('transparent').setup({
            extra_groups = { -- table/string: additional groups that should be clear
                -- In particular, when you set it to 'all', that means all avaliable groups

                -- example of akinsho/nvim-bufferline.lua
                "BufferLineTabClose",
                "BufferlineBufferSelected",
                "BufferLineFill",
                "BufferLineBackground",
                "BufferLineSeparator",
                "BufferLineIndicatorSelected",
                "NvimTreeRootFolder",
                "NvimTreeEmptyFoldername",
                "NvimTreeTreeFolderName",
                "NvimTreeNormal",
                "NvimTreeEndOfBuffer",
                "NvimTreeOpenedFolderName",
                "NvimTreeVertSplit",
                "VertSplit"
            },
            exclude_groups = {}, -- table: groups you don't want to clear
        })
    end

    vim.opt.list = true
    --vim.opt.listchars:append("eol:↴")
    require("ibl").setup({
        scope = {
            show_start = false,
            show_end = false
        }
    })

    require('colorizer').setup()
end

return M
