return {
    {
        'nvwd',
        event = 'VeryLazy',
        dir = '~/stuff_local/plugins/nvwd',
        cond = function()
            local Path = require('plenary.path')
            return Path:new(Path.path.home .. '/stuff_local/plugins/nvwd')
        end,
        config = function()
            require('nvwd')
        end
    }
}
