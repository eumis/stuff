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

local copy_file_path_key = vim.api.nvim_replace_termcodes('<C-o>', true, false, true)

M.go_to_file = function()
    if state == nil then return end

    vim.api.nvim_feedkeys(copy_file_path_key, "t", false)
    vim.cmd("q")
    local path = vim.fn.getreg("+")
    print(path)
    if vim.loop.fs_stat(path) then
        terminal.close_terminal(state)
        local bufnr = vim.fn.bufnr(path, true)
        vim.api.nvim_set_current_buf(bufnr)
    end
end

return M
