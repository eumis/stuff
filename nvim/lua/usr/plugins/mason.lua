return {
    {
        "williamboman/mason.nvim",
        lazy = true,
        cmd = "Mason",
        opts = {}
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim"
        },
        opts = {
            ensure_installed = {
                -- lsp
                "lua-language-server",
                "basedpyright",
                "omnisharp",
                -- {"omnisharp", version = 'v1.39.11'},
                "lemminx",
                "json-lsp",
                "marksman",
                "html-lsp",
                "bash-language-server",
                "typescript-language-server",

                -- dap
                "netcoredbg",

                -- tools
                "prettier",
                -- "yapf",
                "black",
                "isort"
            },
            integrations = {
                ["mason-lspconfig"] = false,
                ["mason-null-ls"] = false,
                ["mason-nvim-dap"] = false,
            }
        }
    }
}
