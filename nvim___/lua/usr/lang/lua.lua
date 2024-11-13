local M = {}
local lsp = require('usr.lsp')
local runtime_path = vim.split(package.path, ';')


function M.setup()
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    require('lspconfig').lua_ls.setup({
        on_attach = lsp.on_attach,
        capabilities = lsp.capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = runtime_path,
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                }
            }
        }
    })
end

return M
