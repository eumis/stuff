return {
    {
        'zbirenbaum/copilot.lua',
        lazy = true,
        config = function()
            require('copilot').setup({
                panel = { enabled = false },
                suggestion = {
                    enabled = true,
                    auto_trigger = false,
                    hide_during_completion = true,
                    debounce = 75,
                    trigger_on_accept = true,
                    keymap = {
                        accept = "<C-.><C-.>",
                        accept_word = false,
                        accept_line = false,
                        next = "<C-.><C-m>",
                        prev = "<C-.><C-n>",
                        dismiss = "<C-.><C-,>",
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
                },
            })
        end
    },
    {
        "yetone/avante.nvim",
        -- event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        enabled = false,
        lazy = true,
        -- opts = {},
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
            -- "ibhagwan/fzf-lua",      -- for file_selector provider fzf
            "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
            -- "zbirenbaum/copilot.lua", -- for providers='copilot'
            --     {
            --         -- support for image pasting
            --         "HakonHarnes/img-clip.nvim",
            --         event = "VeryLazy",
            --         opts = {
            --             -- recommended settings
            --             default = {
            --                 embed_image_as_base64 = false,
            --                 prompt_for_file_name = false,
            --                 drag_and_drop = {
            --                     insert_mode = true,
            --                 },
            --                 -- required for Windows users
            --                 use_absolute_path = true,
            --             },
            --         },
            --     },
            --     {
            --         -- Make sure to set this up properly if you have lazy=true
            --         'MeanderingProgrammer/render-markdown.nvim',
            --         opts = {
            --             file_types = { "markdown", "Avante" },
            --         },
            --         ft = { "markdown", "Avante" },
            --     },
        },
    }
}
