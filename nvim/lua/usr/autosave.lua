local timers = {}
local debounce = 200
local exclude = {
    nofile = 1,
    help = 1,
    qf = 1,
    oil = 1
}

local callback = function(args)
    local buf = args.buf
    local bo = vim.bo[buf]
    local fname = vim.api.nvim_buf_get_name(buf)
    if bo.modifiable and bo.buftype == "" and bo.filetype ~= "" and exclude[bo.filetype] == nil and fname ~= "" then
        if timers[buf] ~= nil then
            vim.fn.timer_stop(timers[buf])
        end
        timers[buf] = vim.fn.timer_start(debounce, function()
            if vim.api.nvim_get_option_value("modified", { buf = buf }) then
                vim.api.nvim_buf_call(buf, function() vim.cmd("write") end)
            end
        end)
    end
end

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
    callback = callback
})
