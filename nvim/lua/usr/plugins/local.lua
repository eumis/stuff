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
}
