local M = {}

--- @param url string
function M.open_url(url)
    if url:sub(0, 2) == './' or url:sub(0, 3) == '../' then
        local parent = vim.fn.expand("%:p:h")
        url = vim.fn.fnamemodify(parent .. '/' .. url, ":p")
    end

    local _, err = vim.ui.open(url)

    if err then
        print('Failed to open ' .. url)
    end
end

return M
