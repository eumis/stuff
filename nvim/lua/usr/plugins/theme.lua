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
    -- theme("vague2k/vague.nvim", { opts = {} }),
    theme("yorumicolors/yorumi.nvim"),
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
    }
}
