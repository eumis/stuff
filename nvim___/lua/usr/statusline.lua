require('lualine').setup({
    options = {
        theme = 'vscode'
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', file_status = true, path = 1 } },
        lualine_x = { "require'lsp-status'.status()", 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location', "vim.api.nvim_buf_line_count(0)" }
    }
})
