local M = {}
local lsp = require('usr.lsp')

function M.setup()
    require('lspconfig').html.setup({
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach
    })
end

return M
