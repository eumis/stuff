local M = {}
local cmp = require('cmp')
local keymap = require('usr.keymap')

function M.setup()
    cmp.setup {
        snippet = { expand = function() end },
        mapping = keymap.get_cmp_mapping(),
        sources = {
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'path' }
        }
    }
end

return M
