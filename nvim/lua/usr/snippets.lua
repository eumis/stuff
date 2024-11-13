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
    s('property getter',
        fmt(
        [[
            @property
            def {name}(self) -> {type}:
                return self._{value}
        ]], {
            name = i(1, 'name'),
            type = i(2),
            value = d(3,
                function(args)
                    return sn(nil, {
                        i(1, args[1])
                    })
                end,
                {1}
            )
        })
    ),
    s('property setter',
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
    s('property',
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
    ),
    s('test class',
        fmt(
        [[
            @mark.usefixtures('async_test')
            class {name}Tests:
        ]], {
            name = i(1)
        })
    ),
    s('test method',
        fmt(
        [[
            @mark.parametrize('{parameters}', [
            ])
            {async}def test_{method}(self, {parameters1}):
                """{description}"""
        ]], {
            async = i(1, 'async '),
            parameters = i(2),
            method = i(3),
            parameters1 = rep(2),
            description = i(4)
        })
    ),
    s('next',
        fmt('next({entry} for {entry1} in {collection} if {condition})', {
            entry = i(1),
            entry1 = rep(1),
            collection = i(2),
            condition = i(3)
        })
    ),
    s('next try',
        fmt(
        [[
            try:
                next({entry} for {entry1} in {collection} if {condition})
            except StopIteration:
                pass
        ]], {
            entry = i(1),
            entry1 = rep(1),
            collection = i(2),
            condition = i(3)
        })
    ),
    s('fixture',
        fmt(
        [[
            @fixture
            def {name}_fixture(request, {yield_parameter}):
                {yield_return}
        ]], {
            name = i(1),
            yield_parameter = i(2, '_yield = In'),
            yield_return = i(3, 'yield _yield')
        })
    ),
    s('patched',
        fmt("@patched(f'{{{module}.__name__}}.{target}', '{target1}_mock')", {
            module = i(1),
            target = i(2),
            target1 = rep(2)
        })
    ),
})

ls.add_snippets('cs', {
    s('ms',
        fmt(
        [[
            _mocker
                .Setup<{interface}, Task<{ret_type}>>(_ => _.{method}({parameters}, _ct))
                .ReturnsAsync({ret_value});
        ]], {
            interface = i(1),
            ret_type = i(2),
            method = i(3),
            parameters = i(4),
            ret_value = i(5)
        })
    ),
    s('mv',
        fmt('_mocker.Verify<{interface}>(_ => _.{method}({parameters}, _ct));', {
            interface = i(1),
            method = i(2),
            parameters = i(3)
        })
    ),
    s('tm',
        fmt(
        [[
            [TestMethod]
            public async Task {method}_{when}_{result}()
            {{
                await _service.{method1}({parameters}, _ct);
            }}
        ]], {
            method = i(1),
            when = i(2),
            result = i(3),
            method1 = rep(1),
            parameters = i(4)
        })
    ),
    s('tme',
        fmt(
        [[
            [TestMethod]
            public async Task {method}_{when}_{result}()
            {{
                await Assert.ThrowsExceptionAsync<{exception}>(
                    async () => await _service.{method1}({parameters}, _ct)
                );
            }}
        ]], {
            method = i(1),
            when = i(2),
            result = i(3),
            exception = i(4),
            method1 = rep(1),
            parameters = i(5)
        })
    ),
    s('si',
        fmt('private {interface} _{name} => _serviceProvider.GetService<{interface1}>();', {
            interface = i(1),
            name = i(2),
            interface1 = rep(1)
        })
    ),
    s('dm',
        fmt(
        [[
            public static {to} ToDomain(this {from} model)
                => new()
                    {{{body}}};
        ]], {
            to = i(1),
            from = i(2),
            body = i(3)
        })
    ),
    s('mm',
        fmt(
        [[
            public static {to} ToModel(this {from} {name})
                => new()
                    {{{body}}};
        ]], {
            to = i(1),
            from = i(2),
            name = i(3),
            body = i(4)
        })
    ),
    s('pm',
        fmt(
        [[
            private {ret_type} {name}({parameters})
            {{{body}}}
        ]], {
            ret_type = i(1),
            name = i(2),
            parameters = i(3),
            body = i(4)
        })
    ),
    s('em',
        fmt(
        [[
            public static {ret_type} {name}(this {parameter_type} {parameter})
            {{{body}}}
        ]], {
            ret_type = i(1),
            name = i(2),
            parameter_type = i(3),
            parameter = i(4),
            body = i(5)
        })
    ),
    s('am',
        fmt(
        [[
            public async Task{ret_type} {name}({parameters}, CancellationToken ct)
            {{
                {body}
            }}
        ]], {
            ret_type = i(1),
            name = i(2),
            parameters = i(3),
            body = i(4)
        })
    ),
})
