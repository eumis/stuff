local M = {}
local telescope = require('telescope')
telescope.load_extension('fzy_native')
telescope.load_extension('lsp_handlers')
local actions = require('telescope.actions')

function M.setup()
    telescope.setup {
        defaults = {
            results_title = false,
            sorting_strategy = "ascending",
            layout_strategy = "center",
            layout_config = {
                preview_cutoff = 1, -- Preview should always show (unless previewer = false)
                anchor = "N",
                width = 0.8,
                height = 0.3,
            },
            border = true,
            borderchars = {
                prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
                results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
                preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            },
            path_display = function(_, path)
                local tail = require("telescope.utils").path_tail(path)
                return string.format("%s (%s)", tail, path)
            end,

            mappings = {
                i = {
                    ['<esc>'] = actions.close,
                    ['<C-c>'] = actions.delete_buffer
                }
            }
        },
        pickers = {
        },
        extensions = {
        }
    }
end

return M
