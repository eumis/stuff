local Path = require "plenary.path"

local M = {}

---@param name? string
---@param cwd? string
function M.load_package(name, cwd)
    if name == nil then name = "lua" end
    if cwd == nil then cwd = vim.fn.getcwd() end

    local cwd_lua = Path:new(cwd, name, "?.lua"):absolute()
    local cwd_lua_init = Path:new(cwd, name, "?", "init.lua"):absolute()
    package.path = package.path .. ';' .. cwd_lua .. ";" .. cwd_lua_init
end

return M
