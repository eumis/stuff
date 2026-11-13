vim.diagnostic.config({
    virtual_text = {
        severity = {
            min = vim.diagnostic.severity.WARN
        }
    }
})

vim.lsp.config("*", {
    flags = {
        debounce_text_changes = 100,
    },
})

local servers = {
    -- "superhtml",
    "biome",
    "shuck",
    "rumdl",
    "lua_ls",
    "basedpyright",
    "lemminx",
    "rust_analyzer",
    "gopls",
    "csharp_ls",
    "slint_lsp",
}

local cmp_lsp = require("cmp_nvim_lsp")
for _, server in ipairs(servers) do
    local capabilities = cmp_lsp.default_capabilities()
    vim.lsp.config(server, {
        capabilities = capabilities,
    })
    vim.lsp.enable(server)
end
