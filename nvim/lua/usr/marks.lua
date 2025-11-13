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

---@returns {mark: string, path: string}[]
M.get_marks = function()
    local files = {}
    for mark, path in pairs(state.marks) do
        table.insert(files, { mark = mark, path = path })
    end
    return files
end

local generate_new_finder = function()
    return require("telescope.finders").new_table({
        results = M.get_marks(),
        entry_maker = function(entry)
            local line = entry.mark .. " - " .. entry.path
            return {
                value = entry,
                ordinal = line,
                display = line,
                filename = entry.path,
            }
        end,
    })
end

M.list_marks = function()
    require("telescope.pickers").new({}, {
        prompt_title = "Marks",
        finder = generate_new_finder(),
        sorter = require("telescope.config").values.generic_sorter({}),
        previewer = require("telescope.config").values.grep_previewer({}),
    }):find()
end

return M
