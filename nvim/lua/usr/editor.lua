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

    require('coerce').setup({
      keymap_registry = require('coerce.keymap').keymap_registry(),
      -- The notification function used during error conditions.
      notify = function(...) return vim.notify(...) end,
      -- If you don’t like the default cases and modes, you can override them.
      cases = require('coerce').default_cases,
      modes = require('coerce').default_modes
    })
end

return M
