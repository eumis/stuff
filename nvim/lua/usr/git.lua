local terminal = require "usr.terminal"

local M = {}

---@type TerminalState?
local state = nil

M.open = function()
    if state == nil then
        state = terminal.new_state({ "lazygit", "" })
    end
    terminal.float_terminal(state)
    vim.cmd("normal! 0")
    vim.cmd("startinsert")
end

local copy_file_path_key = vim.api.nvim_replace_termcodes('<C-o>', true, false, true)

local paste_cmd = { 'xclip', '-selection', 'clipboard', '-o' }
if vim.fn.executable('wl-paste') == 1 then
    paste_cmd = { 'wl-paste' }
end

M.go_to_file = function()
    if state == nil then return end

    vim.api.nvim_feedkeys(copy_file_path_key, "t", false)

    vim.schedule(function()
        local path = vim.fn.system(paste_cmd)
        print("pasted path " .. path)
        if vim.uv.fs_stat(path) then
            terminal.close_terminal(state)
            local bufnr = vim.fn.bufnr(path, true)
            vim.api.nvim_set_current_buf(bufnr)
        end
    end)
end

return M
