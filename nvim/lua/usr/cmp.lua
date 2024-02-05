local M = {}
local cmp = require('cmp')
local keymap = require('usr.keymap')

function M.setup()
    cmp.setup {
        snippet = { expand = function() end },
        mapping = keymap.get_cmp_mapping(),
        sources = {
            { name = 'nvim_lsp' },
            { name = 'copilot' },
            { name = 'path' },
            { name = 'luasnip' }
        }
    }
end

return M
