return {
    { 'windwp/nvim-autopairs', lazy = false },
    { 'numToStr/Comment.nvim', lazy = false },
    { 'karb94/neoscroll.nvim', lazy = false },
    {
        'Pocco81/auto-save.nvim',
        lazy = false,
        opts = {
            enabled = true,
            write_all_buffers = false,
            on_off_commands = true,
            clean_command_line_interval = 0,
            debounce_delay = 500
        }
    }
}
