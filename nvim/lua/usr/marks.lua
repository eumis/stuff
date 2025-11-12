local M = {}

local state = {
    marks = {}
}

M.set_mark = function(mark)
    local path = vim.fn.expand('%:p')
    state.marks[mark] = path
end

M.open_mark = function(mark)
    if state.marks[mark] ~= nil then
        local bufnr = vim.fn.bufnr(state.marks[mark], true)
        vim.api.nvim_set_current_buf(bufnr)
    end
end

M.list_marks = function()
    local files = {}
    for _, path in pairs(state.marks) do
        table.insert(files, path)
    end
    require("telescope.pickers").new({}, {
        prompt_title = "Marks",
        finder = require("telescope.finders").new_table { results = files },
        sorter = require("telescope.config").values.generic_sorter({}),
        previewer = require("telescope.config").values.grep_previewer({}),
    }):find()
end

return M
