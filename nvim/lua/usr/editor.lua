local M = {}

function M.setup()
    require('nvim-autopairs').setup()
    require('Comment').setup()
    require('neoscroll').setup()
    require('auto-save').setup(
        {
            enabled = true,
            write_all_buffers = false,
            on_off_commands = true,
            clean_command_line_interval = 0,
            debounce_delay = 500
        }
    )

    require('harpoon').setup({
        menu = {
            width = vim.api.nvim_win_get_width(0) - 20
        }
    })
end

return M
