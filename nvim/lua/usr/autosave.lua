local timers = {}
local debounce = 500

local callback = function(args)
    local buf = args.buf
    local bo = vim.bo[buf]
    if bo.buftype == "" and bo.filetype ~= "oil" then
        if timers[buf] ~= nil then
            vim.fn.timer_stop(timers[buf])
        end
        timers[buf] = vim.fn.timer_start(debounce, function()
            vim.cmd("write " .. vim.api.nvim_buf_get_name(buf))
        end)
    end
end

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
    callback = callback
})
