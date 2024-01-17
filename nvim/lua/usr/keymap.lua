local M = {}

function M.get_copilot_suggestion_keymap()
    return {
        accept = "<C-a>",
        accept_word = false,
        accept_line = false,
        next = "<C-q>",
        prev = "<C-z>",
        dismiss = "<C-x>",
    }
end

function M.get_copilot_panel_keymap()
    return {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>"
    }
end

function M.get_cmp_mapping()
    local cmp = require('cmp')
    return {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    }
end

function M.setup_gitsigns(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    -- Actions
    map('n', '<space>hs', gs.stage_hunk)
    map('n', '<space>hr', gs.reset_hunk)
    map('v', '<space>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    map('v', '<space>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    map('n', '<space>hS', gs.stage_buffer)
    map('n', '<space>hu', gs.undo_stage_hunk)
    map('n', '<space>hR', gs.reset_buffer)
    map('n', '<space>hp', gs.preview_hunk)
    map('n', '<space>hb', function() gs.blame_line { full = true } end)
    map('n', '<space>tb', gs.toggle_current_line_blame)
    map('n', '<space>hd', gs.diffthis)
    map('n', '<space>hD', function() gs.diffthis('~') end)
    map('n', '<space>td', gs.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

function M.setup_lsp_keys(bufnr)
    local telescope_builtin = require('telescope.builtin')
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gt', function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set('n', 'gr', function() telescope_builtin.lsp_references({ show_line = false }) end, opts)
    vim.keymap.set('n', 'gc', function() vim.lsp.buf.incoming_calls() end, opts)
    vim.keymap.set('n', 'go', function() vim.lsp.buf.outgoing_calls() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', 'H', function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('i', 'C-h', function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('n', '<space>rn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('n', '<space>rr', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('v', '<space>rr', function() vim.lsp.buf.range_code_action({}) end, opts)
    vim.keymap.set('n', '<space>e', function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('v', '<space>e', function() vim.lsp.buf.format({ async = true, range = { vim.api.nvim_buf_get_mark(0, "<"), vim.api.nvim_buf_get_mark(0, ">")} }) end, opts)
end

function M.setup_debug_keys()
    local dap = require('dap')
    local dapui = require('dapui')
    local widgets = require('dap.ui.widgets')
    vim.keymap.set('n', '<F5>', function() dap.continue() end)
    vim.keymap.set('n', '<F10>', function() dap.step_over() end)
    vim.keymap.set('n', '<F11>', function() dap.step_into() end)
    vim.keymap.set('n', '<F12>', function() dap.step_out() end)
    vim.keymap.set('n', '<space>db', function() dap.toggle_breakpoint() end)
    vim.keymap.set('n', '<space>ds', function() dap.set_breakpoint() end)
    vim.keymap.set('n', '<space>dp',
        function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<space>dr', function() dap.repl.open() end)
    vim.keymap.set('n', '<space>dl', function() dap.run_last() end)
    vim.keymap.set({ 'n', 'v' }, '<space>dh', function()
        widgets.hover()
    end)
    vim.keymap.set({ 'n', 'v' }, '<space>dp', function()
        widgets.preview()
    end)
    vim.keymap.set('n', '<space>df', function()
        widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set('n', '<space>ds', function()
        widgets.centered_float(widgets.scopes)
    end)

    vim.keymap.set('n', '<space>dt', function() dapui.toggle() end)
end

local setup_windows = function()
    vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
    vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
    vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
    vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')
    vim.keymap.set('n', '<C-x>', ':wincmd x<CR>')
    vim.keymap.set('n', '<space>mh', ':wincmd H<CR>')
    vim.keymap.set('n', '<space>mj', ':wincmd J<CR>')
    vim.keymap.set('n', '<space>mk', ':wincmd K<CR>')
    vim.keymap.set('n', '<space>ml', ':wincmd L<CR>')
    vim.keymap.set('n', '<space>wl', ':vertical:resize+10<CR>')
    vim.keymap.set('n', '<space>wh', ':vertical:resize-10<CR>')
    vim.keymap.set('n', '<space>wk', ':resize+10<CR>')
    vim.keymap.set('n', '<space>wj', ':resize-10<CR>')
    vim.keymap.set('n', '<space>wo', ':wincmd o<CR>')
    vim.keymap.set('n', '<space>ss', ':vsplit<CR>')
    vim.keymap.set('n', '<space>sh', ':split<CR>')
end

local setup_buffers = function()
    vim.keymap.set('n', '<space>bd', ':bdelete<CR>')
    vim.keymap.set('n', '<C-s>', ':w<CR>')
    vim.keymap.set('n', '<C-s>a', ':wa<CR>')
end

local setup_nvim_tree = function()
    vim.keymap.set('n', '<space>tt', ':NvimTreeToggle<CR>')
    vim.keymap.set('n', '<space>ts', ':NvimTreeFindFile<CR>')
    vim.keymap.set('n', '<space>tf', ':NvimTreeFocus<CR>')
end

local setup_git = function()
    vim.keymap.set('n', '<space>gs', ':G<CR>')
    vim.keymap.set('n', '<space>gc', ':Gcommit<CR>')
    vim.keymap.set('n', '<space>gp', ':Gpush<CR>')
    vim.keymap.set('n', '<space>gg', ':Gpull<CR>')
end

local setup_test_keys = function()
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>ur', function() require("neotest").run.run() end, opts)
    vim.keymap.set('n', '<space>uf', function() require("neotest").run.run(vim.fn.expand("%")) end, opts)
    --vim.keymap.set('n', '<space>ud', function() require("neotest").run.run({ strategy = "dap" }) end, opts)

    vim.keymap.set('n', '<space>ut', function() require("neotest").summary.toggle() end, opts)
    vim.keymap.set('n', '<space>uo', function() require("neotest").output.open({ enter = true }) end, opts)
end

local setup_diagnostics = function()
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>ef', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '<space>el', function() vim.diagnostic.setloclist() end, opts)
    vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next() end, opts)

    --testing
end

local setup_files = function()
    local telescope_builtin = require('telescope.builtin')
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>ff', function() telescope_builtin.find_files() end, opts)
    vim.keymap.set('n', '<space>fh', function() telescope_builtin.find_files({ hidden = true }) end, opts)
    vim.keymap.set('n', '<space>fs', function() telescope_builtin.live_grep() end, opts)
    vim.keymap.set('n', '<space>fi', '<cmd>lua require("telescope.builtin").live_grep()<cr>interface ', opts)
    vim.keymap.set('n', '<space>fc', '<cmd>lua require("telescope.builtin").live_grep()<cr>class ')
    vim.keymap.set('n', '<space>fd', '<cmd>lua require("telescope.builtin").live_grep()<cr>def ')
    vim.keymap.set('n', '<space>ft', function() telescope_builtin.help_tags() end, opts)
    vim.keymap.set('n', '<space>fm', function() telescope_builtin.marks() end, opts)
    vim.keymap.set('n', '<space>fb', function() telescope_builtin.buffers() end, opts)
end

local setup_marks = function()
    local letters = {
        'a', 'b', 'c',
        'd', 'e', 'f',
        'g', 'h', 'i',
        'j', 'k', 'l',
        'm', 'n', 'o',
        'p', 'q', 'r',
        's', 't', 'u',
        'v', 'w', 'x',
        'y', 'z'
    }
    for i = 1, #letters do
        vim.keymap.set('n', "m" .. letters[i], "m" .. string.upper(letters[i]))
        vim.keymap.set('n', "'" .. letters[i], "'" .. string.upper(letters[i]))
    end
end

local setup_harpoon = function()
    local opts = { noremap = true, silent = true }
    local harpoon_ui = require("harpoon.ui")
    vim.keymap.set('n', '<C-f>', harpoon_ui.toggle_quick_menu, opts)
    vim.keymap.set('n', '<C-n>', harpoon_ui.nav_next, opts)
    vim.keymap.set('n', '<C-p>', harpoon_ui.nav_prev, opts)

    local harpoon_mark = require("harpoon.mark")
    vim.keymap.set('n', '<C-m>', harpoon_mark.add_file, opts)
    vim.keymap.set('n', '<C-c>', harpoon_mark.clear_all, opts)

end

function M.setup()
    vim.g.mapspace = ' '
    vim.keymap.set('n', '<space>/', ':noh<CR>')
    vim.keymap.set('n', '<space>cc', '<cmd>:LspInfo<cr>')
    vim.keymap.set('n', '<space>qq', '<cmd>:q<cr>')
    vim.keymap.set('n', '<space>qf', '<cmd>:q!<cr>')
    vim.keymap.set('n', '<space>qa', '<cmd>:qa<cr>')
    vim.keymap.set('n', '<space>qn', '<cmd>:qa!<cr>')
    setup_windows()
    setup_buffers()
    setup_nvim_tree()
    setup_git()
    setup_windows()
    setup_test_keys()
    setup_diagnostics()
    setup_files()
    setup_marks()
    setup_harpoon()
end

return M
