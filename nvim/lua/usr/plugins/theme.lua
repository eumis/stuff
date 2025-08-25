---@param plugin string
---@param opts? {colorscheme: string?, opts: table?}
---@return table
local function theme(plugin, opts)
    return {
        plugin,
        priority = 1000,
        config = function()
            local slash = string.find(plugin, "/", 1, true)
            local dot_nvim = string.find(plugin, ".nvim", 1, true) or 0
            local name = string.sub(plugin, slash + 1, dot_nvim - 1)
            opts = opts or {}
            if opts.opts ~= nil then
                require(name).setup()
            end
            vim.cmd.colorscheme(opts.colorscheme or name)
        end
    }
end

return {
    -- theme("rebelot/kanagawa.nvim", {colorscheme = "kanagawa-dragon", opts = {} }),
    -- theme("rebelot/kanagawa.nvim", {colorscheme = "kanagawa-wave", opts = {} }),
    -- theme("EdenEast/nightfox.nvim", {colorscheme = "nightfox", opts = {} }),
    -- theme("EdenEast/nightfox.nvim", {colorscheme = "terafox", opts = {} }),
    -- theme("EdenEast/nightfox.nvim", {colorscheme = "nordfox", opts = {} }),
    theme("vague2k/vague.nvim", { opts = {} }),
    -- theme("yorumicolors/yorumi.nvim"),
    -- theme("wtfox/jellybeans.nvim"),
    -- theme("wtfox/jellybeans.nvim", {colorscheme = "jellybeans-mono" }),
    -- theme("wtfox/jellybeans.nvim", {colorscheme = "jellybeans-muted" }),
    {
        "kyazdani42/nvim-web-devicons",
        lazy = false,
        opts = {
            override = {
                luamarkdown = {
                    icon = "󰽛",
                    name = "luamarkdown"
                }
            },
            override_by_extension = {
                ["luamd"] = {
                    icon = "󰽛",
                    name = "luamarkdown"
                }
            }
        }
    },
    -- {
    --     "nvimdev/dashboard-nvim",
    --     event = "VimEnter",
    --     config = function()
    --         require("dashboard").setup {
    --             theme = "hyper",
    --             config = {
    --                 week_header = { enable = true },
    --                 project = { enable = false },
    --                 mru = { enable = true, limit = 10, cwd_only = true }
    --             }
    --         }
    --     end,
    --     dependencies = { { "nvim-tree/nvim-web-devicons" } }
    -- },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        opts = {
            -- options = {
            --     theme = "vscode"
            -- },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { { "filename", file_status = true, path = 1 }, function() return require("auto.environment")
                    .current().__name__ end },
                lualine_x = { "require'lsp-status'.status()", "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location", "vim.api.nvim_buf_line_count(0)" }
            }
        }
    }
}
