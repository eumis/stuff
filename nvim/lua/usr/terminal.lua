local M = {}

---@class State
---@field buf number
---@field win number

---@return State
function M.new_state()
    return {
        buf = -1,
        win = -1
    }
end

---@type State
M.state = M.new_state()

---@param win_config table
---@param state State
function M.toggle_terminal_window(win_config, state)
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

---@param state? State
function M.float_terminal(state)
    if state == nil then state = M.state end
    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(vim.o.lines * 0.9)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)
    M.toggle_terminal_window({
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal", -- No borders or extra UI elements
        border = "rounded",
    }, state)
end

---@param state? State
function M.split_terminal(state)
    if state == nil then state = M.state end
    M.toggle_terminal_window({
        split = "right",
        style = "minimal", -- No borders or extra UI elements
    }, state)
end

---@param state? State
function M.bottom_terminal(state)
    if state == nil then state = M.state end
    M.toggle_terminal_window({
        split = "bottom",
        style = "minimal", -- No borders or extra UI elements
    }, state)
end

---@param state? State
function M.open_terminal(state)
    if state == nil then state = M.state end

    if not vim.api.nvim_buf_is_valid(state.buf) then
        state.buf = vim.api.nvim_create_buf(false, true)
    end

    state.win = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_buf(state.buf)
    if vim.bo[state.buf].buftype ~= "terminal" then
        vim.cmd.terminal()
    end
end

return M
