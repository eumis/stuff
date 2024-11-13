return {
    {
        'Mofiqul/vscode.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = 'dark'
            local c = require('vscode.colors')
            require('vscode').setup({
                transparent = true,
                italic_comments = false,
                disable_nvimtree_bg = true,
                color_overrides = {},
                group_overrides = {
                    Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
                }
            })
            require('vscode').load()
        end
    },
    {
        'xiyaowong/nvim-transparent',
        lazy = false,
        priority = 999,
        config = function()
            require('transparent').setup({
                extra_groups = {
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
                exclude_groups = {},
            })
        end
    },
    { 'norcalli/nvim-colorizer.lua',  lazy = false },
    { 'kyazdani42/nvim-web-devicons', lazy = false }
}
