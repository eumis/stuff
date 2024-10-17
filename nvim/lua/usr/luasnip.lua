local M = {}

function M.setup()
    local ls = require("luasnip")
    -- some shorthands...
    local s = ls.snippet
    local sn = ls.snippet_node
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    local r = ls.restore_node
    local l = require("luasnip.extras").lambda
    local rep = require("luasnip.extras").rep
    local p = require("luasnip.extras").partial
    local m = require("luasnip.extras").match
    local n = require("luasnip.extras").nonempty
    local dl = require("luasnip.extras").dynamic_lambda
    local fmt = require("luasnip.extras.fmt").fmt
    local fmta = require("luasnip.extras.fmt").fmta
    local types = require("luasnip.util.types")
    local conds = require("luasnip.extras.conditions")
    local conds_expand = require("luasnip.extras.conditions.expand")

    ls.setup()
    require('luasnip.loaders.from_vscode').load()

    ls.add_snippets('python', {
        s('pg',
            fmt(
            [[
                @property
                def {name}(self) -> {type}:
                    return self._{value}
            ]], {
                name = i(1, 'name'),
                type = i(2),
                value = i(3)
            })
        ),
        s('ps',
            fmt(
            [[
                @{name}.setter
                def {name1}(self, value: {type}):
                    {setter}
            ]], {
                name = i(1),
                name1 = rep(1),
                type = i(2),
                setter = i(3)
            })
        ),
        s('pgs',
            fmt(
            [[
                @property
                def {name}(self) -> {type}:
                    return {value}

                @{name1}.setter
                def {name2}(self, value: {type1}):
                    {setter}
            ]], {
                name = i(1),
                type = i(2),
                value = i(3),
                name1 = rep(1),
                name2 = rep(1),
                type1 = rep(2),
                setter = i(4)
            })
        )
    })

end

return M
