local M = {}

---@class NotesState
---@field buf number
---@field win number

---@return NotesState
function M.new_state()
    return {
        buf = -1,
        win = -1
    }
end

---@type NotesState
M.state = M.new_state()

---@param win_config table
---@param state NotesState
function M.toggle(win_config, state)
    if vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_hide(state.win)
        return
    end

    if not vim.api.nvim_buf_is_valid(state.buf) then
        state.buf = vim.api.nvim_create_buf(false, true)
        vim.bo[state.buf].filetype = "markdown"
    end
    state.win = vim.api.nvim_open_win(state.buf, true, win_config)
end

---@param state? NotesState
function M.float(state)
    if state == nil then state = M.state end
    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(vim.o.lines * 0.9)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)
    M.toggle({
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal", -- No borders or extra UI elements
        border = "rounded",
    }, state)
end

---@param state? NotesState
function M.split(state)
    if state == nil then state = M.state end
    M.toggle({
        split = "right",
        style = "minimal", -- No borders or extra UI elements
    }, state)
end

---@param state? NotesState
function M.bottom(state)
    if state == nil then state = M.state end
    M.toggle({
        split = "bottom",
        style = "minimal", -- No borders or extra UI elements
    }, state)
end

---@param state? NotesState
function M.open(state)
    if state == nil then state = M.state end

    if not vim.api.nvim_buf_is_valid(state.buf) then
        state.buf = vim.api.nvim_create_buf(false, true)
        vim.bo[state.buf].filetype = "markdown"
    end

    state.win = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_buf(state.buf)
end

return M
