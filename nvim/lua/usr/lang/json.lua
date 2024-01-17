local M = {}
local lsp = require('usr.lsp')

function M.setup_jsonls()
    require('lspconfig').jsonls.setup({
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach,
        commands = {
            Format = {
                function()
                    vim.lsp.buf.range_formatting({ tabSize = 2 }, { 0, 0 }, { vim.fn.line("$"), 0 })
                end
            }
        }
    })
end

return M
