local custom_items = {
    nil, --git
    nil  --environment
}

local function build_line()
    local line = " %f"
    for _, item in ipairs(custom_items) do
        if line ~= nil then
            line = line .. " | " .. item
        end
    end
    line = line .. " %h%r %=%y %c:%l/%L"
    vim.opt.statusline = line
end

local M = {}

---@param index number
---@param expression string
local function ensure_item(index, expression)
    if custom_items[index] == nil then
        custom_items[index] = expression
        build_line()
    end
end

---@param value string
M.git = function(value)
    if value ~= nil then
        vim.g.git_branch = value
        ensure_item(1, " %{git_branch}")
    else
        error("nil value branch")
    end
end

---@param value string
M.env = function(value)
    vim.g.runb_env = value
    ensure_item(2, " %{runb_env}")
end

build_line()

vim.system({ "git", "branch", "--show-current" }, { text = true }, function(obj)
    if obj.code == 0 then
        vim.schedule(function()
            M.git(string.sub(obj.stdout, 1, -2))
        end)
    else
        print("")
    end
end)

return M
