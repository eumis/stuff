local M = {}
local lsp = require('usr.lsp')

function M.setup()
    require('lspconfig').marksman.setup({
        on_attach = lsp.on_attach,
        capabilities = lsp.capabilities
    })
end

return M
