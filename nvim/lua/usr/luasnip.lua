local M = {}

function M.setup()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local r = require("luasnip.extras").rep

    ls.setup()

    require('luasnip.loaders.from_vscode').load()

end

return M
