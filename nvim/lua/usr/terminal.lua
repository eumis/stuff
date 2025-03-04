local M = {}

local state = {
    buf = -1,
    win = -1
}

local function toggle_terminal_window(win_config)
    if vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_hide(state.win)
        return
    end

    if not vim.api.nvim_buf_is_valid(state.buf) then
        state.buf = vim.api.nvim_create_buf(false, true)
    end

    state.win = vim.api.nvim_open_win(state.buf, true, win_config)

    if vim.bo[state.buf].buftype ~= "terminal" then
        vim.cmd.terminal()
    end
end

function M.float_terminal()
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)
    toggle_terminal_window({
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal", -- No borders or extra UI elements
        border = "rounded",
    })
end

function M.split_terminal()
    toggle_terminal_window({
        split = "right",
        style = "minimal", -- No borders or extra UI elements
    })
end

function M.bottom_terminal()
    toggle_terminal_window({
        split = "bottom",
        style = "minimal", -- No borders or extra UI elements
    })
end

return M
