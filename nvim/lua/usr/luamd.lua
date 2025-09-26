local M = {}
local ns_id = vim.api.nvim_create_namespace("luamd")
local group = vim.api.nvim_create_augroup("luamd", {})
local embedded_lua = vim.treesitter.query.parse("markdown_inline", '((code_span) @code (#lua-match? @code "^`@.*`$"))')

---@param buf integer?
---@return integer
local function get_buf(buf)
    ---@cast buf integer
    return buf == nil and vim.api.nvim_get_current_buf() or buf
end

---@class Doc
---@field buf integer
---@field on boolean
---@field vars table
local Doc = {}
Doc.__index = Doc

---@param buf integer
---@return Doc
Doc.new = function(buf)
    local self = setmetatable({}, Doc)
    self.buf = buf
    self.vars = {}
    self.on = false
    return self
end

---@return fun(value: integer?):integer
function Doc:sum()
    local result = 0
    return function(value)
        if value ~= nil then
            result = result + value
            return value
        end
        return result
    end
end

---@type table<integer, Doc>
M.docs = {}

---@param buf integer
M.get_doc = function(buf)
    if M.docs[buf] == nil then
        M.docs[buf] = Doc.new(buf)
    end
    return M.docs[buf]
end

---@param buf integer?
M.on = function(buf)
    ---@cast buf integer
    buf = get_buf(buf)
    M.get_doc(buf).on = true
    -- vim.cmd("set conceallevel=2")
    local parser = vim.treesitter.get_parser(0, 'markdown_inline', {})
    ---@diagnostic disable-next-line: need-check-nil
    local tree = parser:parse()[1]
    local root = tree:root()
    vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
    for _, node in embedded_lua:iter_captures(root, 0, 0, -1) do
        -- local name = embedded_lua.captures[id]
        local code = vim.treesitter.get_node_text(node, 0)
        local expression = string.sub(code, 3, string.len(code) - 1)
        if #expression > 3 then
            local range = { node:range() }
            local start_row = range[1]
            local start_col = range[2]
            local end_row = range[3]
            local end_col = range[4]
            expression = "local doc = require('usr.luamd').get_doc(" .. tostring(buf) .. ");local _ = doc.vars;"
                .. expression
            local result = ""
            if expression ~= nil and expression ~= "" then
                result = loadstring(expression)()
                result = result ~= nil and tostring(result) or ""
            end
            local node_len = end_col - start_col
            if #result < node_len then
                result = result .. string.rep(" ", node_len - #result)
            end
            vim.api.nvim_buf_set_extmark(buf, ns_id, start_row, start_col, {
                end_row = end_row,
                end_col = end_col,
                virt_text = { { result, "" } },
                virt_text_pos = "overlay"
            })
        end
    end
end

---@param buf integer?
M.off = function(buf)
    buf = get_buf(buf)
    M.get_doc(buf).on = false
    -- vim.cmd("set conceallevel=0")
    vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
end

---@param buf integer?
M.toggle = function(buf)
    print("toggle")
    buf = get_buf(buf)
    local doc = M.get_doc(buf)
    if doc.on then
        M.off()
    else
        M.on(buf)
    end
end

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.luamd",
    group = group,
    callback = function(args)
        if M.docs[args.buf] == nil then
            M.on(args.buf)
        end
    end
})

return M
