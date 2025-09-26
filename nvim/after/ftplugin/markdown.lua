local ext = vim.fn.expand("%:e")
local prettier_cmd = ""
if ext == "luamd" then
    prettier_cmd = ":silent !prettier '%' --parser markdown --write<CR>"
else
    prettier_cmd = ":silent !prettier '%' --write<CR>"
end
vim.keymap.set("n", "<space>e", prettier_cmd, { noremap = true, silent = true, buffer = 0 })
