return {
    {
        'nvwd',
        event = 'VeryLazy',
        dir = '~/data/plugins/nvwd',
        cond = function()
            local Path = require('plenary.path')
            return Path:new(Path.path.home .. '/data/plugins/nvwd'):exists()
        end,
        config = function()
            require('nvwd')
        end
    },
    {
        'boil',
        event = 'VeryLazy',
        dir = '~/data/plugins/boil',
        cond = function()
            local Path = require('plenary.path')
            return Path:new(Path.path.home .. '/data/plugins/nvwd'):exists()
        end,
        config = function()
            require('nvwd')
        end
    },
}
