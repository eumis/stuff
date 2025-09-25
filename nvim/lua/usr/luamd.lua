local M = {}
local ns = vim.api.nvim_create_namespace('luamd_dynamic')

local function in_ranges(line, ranges)
  for _, r in ipairs(ranges) do
    if line >= r[1] and line <= r[2] then return true end
  end
  return false
end

function M.eval_and_highlight(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  local parser = vim.treesitter.get_parser(bufnr, 'markdown', {})
  local tree = parser:parse()[1]
  local root = tree:root()
  local skip = {}
  local code_q = vim.treesitter.query.parse('markdown', [[
    (fenced_code_block) @code
  ]])
  for id, node in code_q:iter_captures(root, bufnr, 0, -1) do
    if code_q.captures[id] == 'code' then
      local sr, _, er, _ = node:range()
      table.insert(skip, {sr, er})
    end
  end

  local expr_q = vim.treesitter.query.parse('markdown', [[
    (text) @expr (#match? @expr "@\\{[^}]+\\}")
  ]])
  local matches = {}
  for id, node in expr_q:iter_captures(root, bufnr, 0, -1) do
    if expr_q.captures[id] == 'expr' then
      local sr, sc = node:range()
      local text = vim.treesitter.get_node_text(node, bufnr)
      for s1, e1, exp in text:gmatch("()@{(.-)}()") do
        local start_col = sc + s1 - 1
        local end_col = sc + e1
        table.insert(matches, {ln=sr, sc=start_col, ec=end_col, expr=exp})
      end
    end
  end

  table.sort(matches, function(a,b)
    if a.ln==b.ln then return a.sc>b.sc end
    return a.ln>b.ln
  end)

  for _, m in ipairs(matches) do
    if not in_ranges(m.ln, skip) then
      local fn = load('return '..m.expr)
      local ok, res = fn and pcall(fn) or false, ''
      local out = (ok and tostring(res)) or ''
      vim.api.nvim_buf_set_text(bufnr, m.ln, m.sc, m.ln, m.ec, {out})
      vim.api.nvim_buf_set_extmark(bufnr, ns, m.ln, m.sc, {end_col=m.sc+#out, hl_group='Visual'})
    end
  end
end

function M.setup()
  vim.api.nvim_create_autocmd({'BufEnter','BufWritePost','TextChanged'}, {
    pattern='*.md',
    callback=function(args) M.eval_and_highlight(args.buf) end,
  })
end

return M
