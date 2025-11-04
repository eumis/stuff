local terminal = require "usr.terminal"

local M = {}

---@type TerminalState?
local state = nil

M.open = function()
    if state == nil then
        state = terminal.new_state({ "lazygit", "" })
    end
    terminal.float_terminal(state)
    vim.cmd("startinsert")
end

M.go_to_file = function()
    if state == nil then return end

    local lines = vim.api.nvim_buf_get_lines(state.buf, 1, 2, true)
    local the_line = lines[1]

    local s, e = string.find(the_line, "---git a/")
    if e == nil then return end
    local start = e + 1

    s, e = string.find(the_line, " b/", start)
    local end_ = s - 1

    local path = the_line:sub(start, end_)
    if vim.loop.fs_stat(path) then
        terminal.close_terminal(state)
        local bufnr = vim.fn.bufnr(path, true)
        vim.api.nvim_set_current_buf(bufnr)
    end
end

return M
