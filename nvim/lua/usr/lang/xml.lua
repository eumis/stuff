local M = {}
local lsp = require('usr.lsp')

function M.setup_lemminx()
    require('lspconfig').lemminx.setup({
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach,
        filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg' },
        settings = {
            xml = {
                completion = { autoCloseTags = true },
                validation = { noGrammar = "hint" }
            }
        }
    })
end

return M
