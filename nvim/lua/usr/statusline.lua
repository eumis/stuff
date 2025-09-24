local M = {}

---@class LineItem
---@field name string
---@field get_expression fun():string?
---@field set_value fun(val: any)

local icons = {
    copilot = "",
    supermaven = "",
    lua_ls = "󰢱",
    omnisharp = "󰌛",
    basedpyright = "",
    marksman = "",
    ts_ls = "",
    html = ""
}

---@type LineItem
M.git = {
    name = "git",
    get_expression = function()
        if vim.g.sl_git_branch ~= nil then
            return " %{sl_git_branch}"
        end
    end,
    set_value = function(val)
        vim.g.sl_git_branch = val
        M.build_line()
    end
}

M.env = {
    name = "env",
    get_expression = function()
        if vim.g.sl_runb_env ~= nil then
            return " %{sl_runb_env}"
        end
    end,
    set_value = function(val)
        vim.g.sl_runb_env = val
        M.build_line()
    end
}

M.copilot = {
    name = "copilot",
    get_expression = function()
        if vim.g.sl_copilot_status ~= nil then
            return "%{sl_copilot_status}"
        end
    end,
    set_value = function(val)
        vim.g.sl_copilot_status = icons[val] or val or ""
        M.build_line()
    end
}

function _G.sl_lsp_status()
    local buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = buf })
    if #clients == 0 then return "" end
    local names = {}
    for _, client in ipairs(clients) do
        if client.name ~= "copilot" then -- copilot is not lsp
            table.insert(names, icons[client.name] or client.name)
        end
    end
    return table.concat(names, " ")
end

M.lsp = {
    name = "lsp",
    get_expression = function()
        return "%{v:lua.sl_lsp_status()}"
    end,
    set_value = function(_) error("No setter for the lsp status") end
}

function _G.sl_diagnostic_status()
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

M.diagnostics = {
    name = "diagnostics",
    get_expression = function()
        return "%{v:lua.sl_diagnostic_status()}"
    end,
    set_value = function(_) error("No setter for the diagnostics status") end
}

---@type LineItem[]
local left_items = {
    M.git,
    M.env
}

---@type LineItem[]
local right_items = {
    M.copilot,
    M.lsp,
    M.diagnostics,
}

M.build_line = function()
    local left = " "
    local expression = nil
    for _, item in ipairs(left_items) do
        expression = item.get_expression()
        if expression ~= nil then
            left = left .. expression .. " | "
        end
    end

    local right = " "

    for _, item in ipairs(right_items) do
        expression = item.get_expression()
        if expression ~= nil then
            right = expression .. " " .. right
        end
    end

    left = left .. "%f %h%r %=" .. right .. "| %y %c:%l/%L"
    vim.opt.statusline = left
end

M.build_line()

vim.system({ "git", "branch", "--show-current" }, { text = true }, function(obj)
    if obj.code == 0 then
        vim.schedule(function()
            M.git.set_value(string.sub(obj.stdout, 1, -2))
        end)
    end
end)

vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function()
        vim.cmd("redrawstatus")
    end
})

return M
