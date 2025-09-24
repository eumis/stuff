vim.keymap.set("n", "<space>e", "<cmd>silent !black % && isort %<CR>", { noremap = true, silent = true, buffer = 0 })
