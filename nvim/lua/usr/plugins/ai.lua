return {
    {
        'zbirenbaum/copilot.lua',
        lazy = true,
        config = function()
            require('copilot').setup({
                panel = { enabled = false },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = true,
                    debounce = 75,
                    trigger_on_accept = true,
                    keymap = {
                        accept = "<C-a>",
                        accept_word = false,
                        accept_line = false,
                        next = "<C-s>",
                        prev = "<C-x>",
                        dismiss = "<C-z>",
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
        "supermaven-inc/supermaven-nvim",
        lazy = true,
        config = function()
            require("supermaven-nvim").setup({
                disable_keymaps = false,
                keymaps = {
                    accept_suggestion = "<C-a>",
                    clear_suggestion = "<C-z>",
                    accept_word = "<C-x>",
                },
            })
        end,
    }
}
