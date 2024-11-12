local M = {}
local lsp = require('usr.lsp')

function M.setup_jsonls()
    local on_attach = function(_, bufnr)
        -- _ variable is client
        lsp.on_attach(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', '<space>e', ":silent !prettier '%' --write<CR>", opts)
    end

    require('lspconfig').jsonls.setup({
        capabilities = lsp.capabilities,
        on_attach = on_attach
    })
end

return M
