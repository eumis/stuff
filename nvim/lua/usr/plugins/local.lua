local Path = require('plenary.path')
local plugins_root = '~/data/plugins'

---@param name
---@param options? {root?: string, config: fun()}
local function custom_plugin(name, options)
    options = options or {}
    options.root = options.root or plugins_root
    options.config = options.config or function() require(name) end
    return {
        name,
        event = 'VeryLazy',
        dir = options.root .. '/' .. name,
        cond = function()
            return Path:new(vim.fn.expand(plugins_root), name):exists()
        end,
        config = function()
            require(name)
        end
    }
end

return {
    custom_plugin('util'),
    custom_plugin('nvwd'),
    custom_plugin('luamd', { config = function() require('auto').setup() end }),
    custom_plugin('auto', { config = function() require('auto').setup() end }),
    custom_plugin('task'),
    custom_plugin('nvim', { root = '~/data' })
}
