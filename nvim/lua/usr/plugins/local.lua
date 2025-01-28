local get_cond = function(plugin)
    return function()
        local Path = require('plenary.path')
        return Path:new(Path.path.home .. '/data/plugins/' .. plugin):exists()
    end
end

local get_config = function(plugin)
    return function()
        require(plugin)
    end
end

return {
    {
        'util',
        event = 'VeryLazy',
        dir = '~/data/plugins/util',
        cond = get_cond('util'),
        config = get_config('util')
    },
    {
        'nvwd',
        event = 'VeryLazy',
        dir = '~/data/plugins/nvwd',
        cond = get_cond('nvwd'),
        config = get_config('nvwd')
    },
    {
        'boil',
        event = 'VeryLazy',
        dir = '~/data/plugins/boil',
        cond = get_cond('boil'),
        config = get_config('boil')
    },
    {
        'luamd',
        event = 'VeryLazy',
        dir = '~/data/plugins/luamd',
        cond = get_cond('luamd'),
        config = function()
            require('luamd').setup()
        end
    },
    {
        'auto',
        event = 'VeryLazy',
        dir = '~/data/plugins/auto',
        cond = get_cond('auto'),
        config = function()
            require('auto').setup()
        end
    },
}
