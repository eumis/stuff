local ext = vim.fn.expand("%:e")
local prettier_cmd = ""
if ext == "luamd" then
    prettier_cmd = ":silent !prettier '%' --parser markdown --write<CR>"
else
    prettier_cmd = ":silent !prettier '%' --write<CR>"
end
local rumdl_cmd = ":silent !rumdl fmt '%'<CR>"
-- vim.keymap.set("n", "<space>e", prettier_cmd, { noremap = true, silent = true, buffer = 0 })
vim.keymap.set("n", "<space>e", rumdl_cmd, { noremap = true, silent = true, buffer = 0 })
