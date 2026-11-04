return {
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        event = "VeryLazy",
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
}
