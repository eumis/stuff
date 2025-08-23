local Path = require('plenary.path')
local plugins_root = '~/data/plugins'

---@param name string
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
            return Path:new(vim.fn.expand(options.root), name):exists()
        end,
        config = options.config
    }
end

return {
    custom_plugin('util'),
    -- custom_plugin('luamd', { config = function() require('luamd').setup() end }),
    custom_plugin('pronav')
}
