---@param plugin string
---@param opts? {colorscheme: string?, opts: table?, callback: fun()}
---@return table
local function theme(plugin, opts)
    return {
        plugin,
        priority = 1000,
        config = function()
            local slash = string.find(plugin, "/", 1, true)
            local dot_ext = 0
            for _, ext in ipairs({ ".vim", ".nvim" }) do
                local result = string.find(plugin, ext, 1, true)
                if result ~= nil then
                    dot_ext = result
                    break
                end
            end
            local name = string.sub(plugin, slash + 1, dot_ext - 1)
            opts = opts or {}
            if opts.opts ~= nil then
                require(name).setup(opts.opts)
            end
            local callback = opts.callback or function()
                vim.cmd.colorscheme(opts.colorscheme or name)
            end
            callback()
        end
    }
end

return {
    "kyazdani42/nvim-web-devicons",
    -- theme("rebelot/kanagawa.nvim", {colorscheme = "kanagawa-dragon", opts = {} }),
    -- theme("rebelot/kanagawa.nvim", {colorscheme = "kanagawa-wave", opts = {} }),
    -- theme("EdenEast/nightfox.nvim", {colorscheme = "nightfox", opts = {} }),
    -- theme("EdenEast/nightfox.nvim", {colorscheme = "terafox", opts = {} }),
    -- theme("EdenEast/nightfox.nvim", {colorscheme = "nordfox", opts = {} }),
    -- theme("vague2k/vague.nvim", { opts = {} }),
    -- theme("yorumicolors/yorumi.nvim"),
    -- theme("wtfox/jellybeans.nvim"),
    -- theme("wtfox/jellybeans.nvim", {colorscheme = "jellybeans-mono" }),
    -- theme("wtfox/jellybeans.nvim", {colorscheme = "jellybeans-muted" }),
    -- theme("p00f/alabaster.nvim"),
    -- theme("alligator/accent.vim", {
    --     callback = function()
    --         vim.cmd([[
    --             let g:accent_colour = "yellow"
    --             source ~/.local/share/nvim/lazy/accent.vim/colors/accent.vim
    --         ]])
    --     end
    -- }),
    -- theme("davidosomething/vim-colors-meh", { colorscheme = "meh" }),
    -- theme("axvr/photon.vim"),
    -- theme("kvrohit/rasmus.nvim", {
    --     callback = function()
    --         vim.cmd([[
    --             let g:rasmus_italic_functions = 0
    --             let g:rasmus_bold_functions = 0
    --             colorscheme rasmus
    --         ]])
    --     end
    -- }),
    -- theme("AlexvZyl/nordic.nvim", { callback = function() require("nordic").load() end }),
    -- theme("cocopon/iceberg.vim"),
    -- {
    --     "kyazdani42/nvim-web-devicons",
    --     lazy = false,
    --     opts = {
    --         override = {
    --             luamarkdown = {
    --                 icon = "󰽛",
    --                 name = "luamarkdown"
    --             }
    --         },
    --         override_by_extension = {
    --             ["luamd"] = {
    --                 icon = "󰽛",
    --                 name = "luamarkdown"
    --             }
    --         }
    --     }
    -- },
    -- theme("catppuccin/nvim", {
    --     callback = function()
    --         require "catppuccin".setup()
    --         vim.cmd.colorscheme("catppuccin-macchiato")
    --     end
    -- })
    -- theme("mcauley-penney/techbase.nvim"),
    -- theme("thesimonho/kanagawa-paper.nvim"),
    -- theme("scottmckendry/cyberdream.nvim"),
    theme("Mofiqul/vscode.nvim", {
        opts = { transparent = true },
        callback = function()
            vim.o.background = "dark"
            vim.cmd.colorscheme("vscode")
        end
    })
}
