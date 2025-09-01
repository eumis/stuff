local custom_items = {
    nil, --git
    nil  --environment
}

function _G.diagnostic_count()
    local counts = { 0, 0, 0, 0 }
    local severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN, vim.diagnostic.severity.INFO, vim
        .diagnostic.severity.HINT }

    for i, sev in ipairs(severity) do
        counts[i] = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[sev] })
    end

    local result = {}
    if counts[1] > 0 then table.insert(result, " " .. counts[1]) end
    if counts[2] > 0 then table.insert(result, " " .. counts[2]) end
    if counts[3] > 0 then table.insert(result, " " .. counts[3]) end
    if counts[4] > 0 then table.insert(result, "󰘥 " .. counts[4]) end

    return table.concat(result, " ")
end

vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function()
        vim.cmd("redrawstatus")
    end
})

local function build_line()
    local line = " %f"
    for _, item in ipairs(custom_items) do
        if line ~= nil then
            line = line .. " | " .. item
        end
    end
    line = line .. " %h%r %=%{v:lua.diagnostic_count()} %y %c:%l/%L"
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
