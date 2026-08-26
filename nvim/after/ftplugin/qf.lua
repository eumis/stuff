vim.keymap.set("n", "<CR>", ":. cc<CR>", { buffer = true, silent = true })
vim.keymap.set("n", "dd", function()
    local winid = vim.api.nvim_get_current_win()
    local info = vim.fn.getwininfo(winid)[1]
    local is_loc = info.loclist == 1
    local list = is_loc and vim.fn.getloclist(0) or vim.fn.getqflist()
    local idx = vim.fn.line(".")
    table.remove(list, idx)
    if is_loc then
        vim.fn.setloclist(0, list, "r")
    else
        vim.fn.setqflist(list, "r")
    end
    -- keep cursor on a sensible line
    local new_idx = math.min(idx, #list)
    if new_idx > 0 then
        vim.cmd(new_idx .. (is_loc and "ll" or "cc"))
    end
    vim.cmd(is_loc and "lopen" or "copen")
end, { buffer = true, silent = true })
