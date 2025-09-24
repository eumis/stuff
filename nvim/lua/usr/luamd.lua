local M = {
    ---@type {[integer]: view}
    views = {},
    ---@type {[integer]: integer}
    sources = {}
}

---@class Doc
local Doc = {
    lines = {}
}

Doc.__index = Doc

---@param content string
---@param remove_last_line? boolean
---@return any ...
function Doc:raw(content, remove_last_line)
    for line in content:gmatch("([^\n]*)\n?") do
        table.insert(self.lines, line)
    end

    if remove_last_line == nil then
        remove_last_line = true
    end

    if remove_last_line and string.match(self.lines[#self.lines], '^%s*$') then
        table.remove(self.lines)
    end
end

---@param value any
---@param ln integer
---@return string
local function get_cell(value, ln)
    local str_value = tostring(value)
    local space_length = ln - #str_value
    if space_length > 0 then
        str_value = str_value .. string.rep(' ', space_length)
    end
    return ' ' .. str_value .. ' '
end

---@param row any[]
---@param lengths integer[]
function Doc:table_row(row, lengths)
    local str_values = {}
    for i, value in ipairs(row) do
        table.insert(str_values, get_cell(value, lengths[i]))
    end
    self:raw('|' .. table.concat(str_values, '|') .. '|')
end

---@param header string[]
---@param rows any[][]
function Doc:table(header, rows)
    local lengths = {}
    for _, value in ipairs(header) do
        table.insert(lengths, #value)
    end
    for _, row in ipairs(rows) do
        for i, value in ipairs(row) do
            local str_value = tostring(value)
            if #str_value > lengths[i] then
                lengths[i] = #str_value
            end
        end
    end

    self:table_row(header, lengths)

    local split_row = {}
    for _, ln in ipairs(lengths) do
        table.insert(split_row, string.rep('-', ln))
    end
    self:raw('| ' .. table.concat(split_row, ' | ') .. ' |')


    for _, row in ipairs(rows) do
        self:table_row(row, lengths)
    end
end

---@return Doc
function M.new()
    local obj = setmetatable({}, Doc)
    obj.lines = {}
    return obj
end

function M.render_to_file(doc, md_path)
    local content = table.concat(doc.lines, '\n')
    local file = io.open(md_path, 'w+')
    if file ~= nil then
        file:write(content)
        io.close(file)
    end
end

---@alias chunk {lines: string[], start: number, final: number}

---@param luamd_buf number
---@return chunk[]
function M.render_luamd(luamd_buf)
    local embedded_lua = vim.treesitter.query.parse('markdown', [[
        (fenced_code_block
          (info_string) @info_string (#eq? @info_string "lua render")
          (code_fence_content) @source
        ) @lua
    ]])
    local parser = vim.treesitter.get_parser(luamd_buf, 'markdown', {})
    local tree = parser:parse()[1]
    local root = tree:root()
    local content = {}
    local position = 0
    for id, node in embedded_lua:iter_captures(root, luamd_buf, 0, -1) do
        local name = embedded_lua.captures[id]
        if name == 'source' then
            -- { start_row, start_col, end_row, end_col }
            local range = { node:range() }
            local lua_source = vim.treesitter.get_node_text(node, luamd_buf)
            local start = range[1] - 1 -- inclusive
            local final = range[3] + 2 -- exclusive
            if position < start then
                table.insert(content, {
                    lines = vim.api.nvim_buf_get_lines(luamd_buf, position, start, true),
                    start = position,
                    final = start,
                })
            end
            position = final + 1
            local doc = M.new()
            print(lua_source)
            load(lua_source, nil, nil, { doc = doc })()
            table.insert(content, {
                lines = doc.lines,
                start = start,
                final = start + #doc.lines
            })
            start = start + #doc.lines
        end
    end

    return content
end

---@param lua_buf number
---@return chunk
function M.render_lua(lua_buf)
    local source = vim.api.nvim_buf_get_lines(lua_buf, 0, -1, false)
    local doc = loadstring(table.concat(source, '\n'))()
    if doc == nil or getmetatable(doc) ~= Doc then
        error('Can\'t render file. It should return Doc')
    end
    return {
        lines = doc.lines,
        start = 0,
        final = -1
    }
end

---@param source_buf integer
---@param view view
function M.render(source_buf, view)
    local content = nil
    if vim.bo[source_buf].filetype == 'luamarkdown' then
        content = M.render_luamd(source_buf)
    elseif vim.bo[source_buf].filetype == 'lua' then
        content = { M.render_lua(source_buf) }
    else
        print('Markdown rendering is not supported for ' .. vim.bo[source_buf].filetype)
        return
    end
    for _, chunk in ipairs(content) do
        vim.api.nvim_buf_set_lines(view.content_buf, chunk.start, chunk.final, false, chunk.lines)
    end
end

---@alias display
---| '"none"'
---| '"source"'
---| '"content"'
---| '"split"'

---@alias view {content_buf: number, content_win: number, display: display, changed: boolean}

---@param source_buf number
---@return view
function M.get_view(source_buf)
    if M.views[source_buf] == nil then
        M.views[source_buf] = {
            content_buf = -1,
            content_win = -1,
            display = 'none',
            changed = false
        }
    end
    return M.views[source_buf]
end

---@param source_buf number
---@param view view
local function ensure_content_buf(source_buf, view)
    if not vim.api.nvim_buf_is_valid(view.content_buf) then
        view.content_buf = vim.api.nvim_create_buf(false, true)
        vim.bo[view.content_buf].filetype = 'markdown'
        M.sources[view.content_buf] = source_buf
        view.changed = true
    end
    if view.changed == true then
        view.changed = false
        print('ensuring buf')
        M.render(source_buf, view)
    end
end

---@return integer
function M.get_current_source_buf()
    local current_buf = vim.api.nvim_get_current_buf()
    local source_buf = M.sources[current_buf]
    if source_buf ~= nil then
        return source_buf
    else
        return current_buf
    end
end

---@param source_buf? number
function M.toggle_split(source_buf)
    if source_buf == nil then source_buf = M.get_current_source_buf() end
    local view = M.get_view(source_buf)

    if vim.api.nvim_win_is_valid(view.content_win) then
        view.display = 'none'
        vim.api.nvim_win_hide(view.content_win)
    else
        ensure_content_buf(source_buf, view)
        view.display = 'split'
        view.content_win = vim.api.nvim_open_win(view.content_buf, false, { split = "right" })
    end
end

---@param source_buf? number
function M.toggle(source_buf)
    if source_buf == nil then source_buf = M.get_current_source_buf() end
    local view = M.get_view(source_buf)

    if view.display == 'content' then
        view.display = 'source'
        vim.api.nvim_set_current_buf(source_buf)
    else
        ensure_content_buf(source_buf, view)
        view.display = 'content'
        vim.api.nvim_set_current_buf(view.content_buf)
    end
end

function M.setup()
    -- local au_group = vim.api.nvim_create_augroup('luamd_group', { clear = false })

    -- vim.api.nvim_create_autocmd('BufEnter', {
    --     group = au_group,
    --     pattern = '*.luamd',
    --     callback = function(opts)
    --         local content = M.get_view(opts.buf)
    --         if content.display ~= 'source' then
    --             M.toggle(opts.buf)
    --         end
    --     end
    -- })
    --
    -- vim.api.nvim_create_autocmd('BufWritePost', {
    --     group = au_group,
    --     pattern = '*.luamd',
    --     callback = function(opts)
    --         local state = M.state.views[opts.buf]
    --         if state == nil or state.view == 'none' then return end
    --         if state.view == 'source' then
    --             state.changed = true
    --         elseif state.view == 'split' or state.view == 'content' then
    --             M.render(opts.buf, state.content_buf)
    --         end
    --     end
    -- })

    vim.api.nvim_create_user_command('Luamd', function() M.toggle() end, {})
    vim.api.nvim_create_user_command('LuamdSplit', function() M.toggle_split() end, {})
end

return M
