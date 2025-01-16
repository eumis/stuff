local M = {}

---@type vim.treesitter.Query
M.lua_render_query = vim.treesitter.query.parse('markdown', [[
    (fenced_code_block
      (info_string) @info_string (#eq? @info_string "lua render")
      (code_fence_content) @source
    ) @lua
]])


-- local namespace = vim.api.nvim_create_namespace('test')
-- vim.api.nvim_buf_set_extmark(0, namespace, 3, 0, {
--     virt_text_pos = "overlay",
--     virt_text = {{'some text', ''}},
--
--     end_row = 5,
--     end_col = vim.fn.strchars('some text'),
--     conceal = ""
-- });



return M
