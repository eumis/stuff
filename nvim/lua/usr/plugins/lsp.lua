return {
    {
        "folke/lazydev.nvim",
        event = "BufReadPre",
        ft = "lua",
        opts = {
            library = {}
        }
    },
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        config = function()
            vim.diagnostic.config({
                virtual_text = {
                    severity = {
                        min = vim.diagnostic.severity.WARN
                    }
                },
                update_in_insert = true
            })

            local servers = {
                "html",
                "ts_ls",
                "marksman",
                "bashls",
                "omnisharp",
                "jsonls",
                "lua_ls",
                "basedpyright",
                "lemminx",
                "html"
                -- "roslyn_ls"
            }

            vim.lsp.config("*", {
                flags = {
                    debounce_text_changes = 100,
                },
            })

            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        analysis = {
                            autoSearchPaths = true,
                            --diagnosticMode = "workspace",
                            enableTypeIgnoreComments = true,
                            typeCheckingMode = "standard", -- standard, strict, all, off, basic
                            diagnosticSeverityOverrides = {
                                strictParameterNoneValue = false,
                                autoImportCompletions = true,
                                reportOptionalSubscript = "warning",
                                reportOptionalMemberAccess = "warning",
                                reportOptionalIterable = "warning",
                                reportGeneralTypeIssues = "warning"
                            }
                        },
                    }
                }
            })

            vim.lsp.config("roslyn_ls", {
                cmd = { "/home/em/.local/bin/roslyn/content/LanguageServer/linux-x64/Microsoft.CodeAnalysis.LanguageServer", "--logLevel", "Debug", "--extensionLogDirectory", "/home/em/temp/roslyn_ls/logs", "--stdio" }
            })

            local cmp_lsp = require("cmp_nvim_lsp")
            for _, server in ipairs(servers) do
                local capabilities = cmp_lsp.default_capabilities()
                vim.lsp.config(server, {
                    capabilities = capabilities,
                })
                vim.lsp.enable(server)
            end
        end
    }
}
