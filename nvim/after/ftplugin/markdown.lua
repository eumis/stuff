vim.keymap.set("n", "<space>e", ":silent !prettier '%' --write<CR>", { noremap = true, silent = true, buffer = 0 })
