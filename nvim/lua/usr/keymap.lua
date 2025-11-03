local M = {}
local silent_opts = { noremap = true, silent = true }

-- source
vim.keymap.set("n", '<C-x><C-x>', '<cmd>.lua<CR>')
vim.keymap.set("n", '<C-x><C-f>', '<cmd>source %<CR>')

vim.keymap.set("n", '<space>/', ':noh<CR>')
vim.keymap.set("n", '<C-q>', '<cmd>:q<cr>')
vim.keymap.set('t', '<C-q>', '<c-\\><c-n><cmd>:q<cr>')
vim.keymap.set("n", '<space>qf', '<cmd>:q!<cr>')
vim.keymap.set("n", '<space>qa', '<cmd>:qa<cr>')
vim.keymap.set("n", '<space>qn', '<cmd>:qa!<cr>')

--tabs
vim.keymap.set("n", "<C-n>", ":tabnext<CR>")
vim.keymap.set("n", "<C-p>", ":tabprevious<CR>")

-- windows
vim.keymap.set("n", '<C-h>', ':wincmd h<CR>')
vim.keymap.set("n", '<C-j>', ':wincmd j<CR>')
vim.keymap.set("n", '<C-k>', ':wincmd k<CR>')
vim.keymap.set("n", '<C-l>', ':wincmd l<CR>')
-- vim.keymap.set("n", '<C-x>', ':wincmd x<CR>')
vim.keymap.set("n", '<space>mh', ':wincmd H<CR>')
vim.keymap.set("n", '<space>mj', ':wincmd J<CR>')
vim.keymap.set("n", '<space>mk', ':wincmd K<CR>')
vim.keymap.set("n", '<space>ml', ':wincmd L<CR>')
vim.keymap.set("n", '<space>wl', ':vertical:resize+10<CR>')
vim.keymap.set("n", '<space>wh', ':vertical:resize-10<CR>')
vim.keymap.set("n", '<space>wk', ':resize+10<CR>')
vim.keymap.set("n", '<space>wj', ':resize-10<CR>')
vim.keymap.set("n", '<space>wo', ':wincmd o<CR>')
vim.keymap.set("n", '<space>ss', ':vsplit<CR>')
vim.keymap.set("n", '<space>sh', ':split<CR>')

-- terminal
-- vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", '<C-t><C-t>', function() require('usr.terminal').float_terminal() end)
vim.keymap.set("t", '<C-t><C-t>', function() require('usr.terminal').float_terminal() end)
vim.keymap.set("n", '<C-t><C-s>', function() require('usr.terminal').split_terminal() end)
vim.keymap.set("n", '<C-t><C-b>', function() require('usr.terminal').bottom_terminal() end)
vim.api.nvim_create_user_command('Term', function() require('usr.terminal').float_terminal() end, {})

-- tasks
vim.keymap.set("n", "<C-t><C-r>", function() require("tasks").toggle_list() end)

-- nvim tree
vim.keymap.set("n", '<C-f><C-f>', ':NvimTreeToggle<CR>')
vim.keymap.set("n", '<C-f><C-s>', ':NvimTreeFindFile<CR>')

-- git
-- vim.keymap.set("n", "<space>gs", function() require("neogit").open() end, silent_opts)
vim.keymap.set("n", "<space>gs", function() require("usr.git").open() end, silent_opts)
-- vim.keymap.set("n", '<space>gs', ':G<CR>')
vim.keymap.set("n", "<space>ga", function() require("gitsigns").blame() end, silent_opts)
vim.keymap.set("n", "<space>gb", function() require("gitsigns").blame_line({ full = true }) end, silent_opts)
vim.keymap.set("n", "<space>gd", function() require("gitsigns").preview_hunk_inline() end, silent_opts)
vim.keymap.set("n", "<space>gg", function() require("gitsigns").preview_hunk() end, silent_opts)
vim.keymap.set("n", "<space>g]", function() require("gitsigns").nav_hunk("next") end, silent_opts)
vim.keymap.set("n", "<space>g[", function() require("gitsigns").nav_hunk("prev") end, silent_opts)

-- notes
vim.keymap.set("n", "<space>nf", function() require("usr.notes").float() end, silent_opts)

function M.get_diffview_keymaps()
    local close_map = { "n", '<C-q>', '<Cmd>DiffviewClose<CR>', { silent = true } }
    return {
        view = {
            close_map
        },
        file_panel = {
            close_map
        }
    }
end

-- marks
local letters = {
    'a', 'b', 'c',
    'd', 'e', 'f',
    'g', 'h', 'i',
    'j', 'k', 'l',
    'm', "n", 'o',
    'p', 'q', 'r',
    's', 't', 'u',
    "v", 'w', 'x',
    'y', 'z'
}
for i = 1, #letters do
    vim.keymap.set("n", "m" .. letters[i], "m" .. string.upper(letters[i]))
    vim.keymap.set("n", "'" .. letters[i], "'" .. string.upper(letters[i]))
end

-- navigation
vim.keymap.set("n", '<space>ff', function() require('telescope.builtin').find_files() end, silent_opts)
vim.keymap.set("n", '<space>fh',
    function() require('telescope.builtin').find_files({ hidden = true, no_ignore = true }) end, silent_opts)
vim.keymap.set("n", '<space>fr', function() require('telescope.builtin').oldfiles({ only_cwd = true }) end, silent_opts)
vim.keymap.set("n", '<space>fs', function() require('telescope.builtin').live_grep() end, silent_opts)
vim.keymap.set("n", '<space>ft', function() require('telescope.builtin').help_tags() end, silent_opts)
vim.keymap.set("n", '<space>fm', function() require('telescope.builtin').marks() end, silent_opts)
vim.keymap.set("n", '<space>fb', function() require('telescope.builtin').buffers() end, silent_opts)
vim.keymap.set("n", '<space>fq',
    function() require('telescope.builtin').quickfix({ fname_width = 200, symbol_width = 60 }) end, silent_opts)

vim.keymap.set("n", '<C-g><C-g>', function() require('harpoon.ui').toggle_quick_menu() end, silent_opts)
vim.keymap.set("n", '<C-g><C-n>', function() require('harpoon.ui').nav_next() end, silent_opts)
vim.keymap.set("n", '<C-g><C-b>', function() require('harpoon.ui').nav_prev() end, silent_opts)
vim.keymap.set("n", '<C-g><C-a>', function() require('harpoon.mark').add_file() end, silent_opts)
-- vim.keymap.set("n", '<C-c>', function() require('harpoon.mark').clear_all() end, silent_opts)

-- snippets
-- vim.keymap.set({ "i", "s" }, "<C-l>", function() require('luasnip').jump(1) end, silent_opts)
-- vim.keymap.set({ "i", "s" }, "<C-h>", function() require('luasnip').jump(-1) end, silent_opts)

-- comments
vim.keymap.set("n", 'CC', function() require('Comment.api').toggle.linewise.current() end, silent_opts)
vim.keymap.set("n", 'CB', function() require('Comment.api').toggle.blockwise.current() end, silent_opts)
local esc = vim.api.nvim_replace_termcodes(
    '<ESC>', true, false, true
)
vim.keymap.set('x', 'CC', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    require('Comment.api').toggle.linewise(vim.fn.visualmode())
end)
vim.keymap.set('x', 'CB', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    require('Comment.api').toggle.blockwise(vim.fn.visualmode())
end)

-- -- coerce
-- function M.get_coerce_prefices()
--     return {
--         normal_mode = "cr",
--         motion_mode = "gcr",
--         visual_mode = "gcr",
--     }
-- end

-- debug
vim.keymap.set("n", '<F5>', function() require('dap').continue() end)
vim.keymap.set("n", '<F4>', function() require('dap').run_last() end)
vim.keymap.set("n", '<F6>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set("n", '<F10>', function() require('dap').step_over() end)
vim.keymap.set("n", '<F11>', function() require('dap').step_into() end)
vim.keymap.set("n", '<F12>', function() require('dap').step_out() end)
vim.keymap.set({ "n", "v" }, '<F7>', function() require('dap.ui.widgets').hover() end)
vim.keymap.set({ "n", "v" }, '<F8>', function() require('dap.ui.widgets').preview() end)
vim.keymap.set("n", '<F9>', function() require('dapui').toggle() end)

-- markdown
local function set_task(char)
    local line = vim.api.nvim_get_current_line()
    line = line:gsub('- *%[.%]', '- [' .. char .. ']')
    vim.api.nvim_set_current_line(line)
end
vim.keymap.set("n", 'tt', function() vim.api.nvim_input('0f-a [ ]<esc>') end)
vim.keymap.set("n", 't<space>', function() set_task(' ') end)
vim.keymap.set("n", 't/', function() set_task('/') end)
vim.keymap.set("n", 'tx', function() set_task('x') end)
vim.keymap.set("n", 't-', function() set_task('-') end)
vim.keymap.set("n", 't?', function() set_task('?') end)
vim.keymap.set("n", 'gx', function() require('usr.url').open_url(vim.fn.expand('<cfile>')) end)
vim.keymap.set("n", "<C-m>", function() require "usr.luamd".toggle() end)

-- ai
-- vim.keymap.set('i', '<C-s>', function()
--     require('copilot.suggestion').next()
-- end, silent_opts)
-- vim.keymap.set('i', '<C-x>', function()
--     require('copilot.suggestion').previous()
-- end, silent_opts)
-- vim.keymap.set('i', '<C-a>', function()
--     require('copilot.suggestion').accept()
-- end, silent_opts)
-- vim.keymap.set('i', '<C-z>', function()
--     require('copilot.suggestion').dismiss()
-- end, silent_opts)

vim.keymap.set("n", "<C-c>", function() require("telescope.builtin").commands() end)

-- runb
vim.keymap.set("n", "<C-a><C-r>", function() require("runb").run() end)
vim.keymap.set("n", "<C-a><C-n>", function() require("runb.view").next_tab() end)
vim.keymap.set("n", "<C-a><C-b>", function() require("runb.view").previous_tab() end)

-- cmp
function M.get_cmp_mapping()
    local cmp = require("cmp")
    return {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-e>"] = cmp.mapping.close(),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            else
                fallback()
            end
        end
    }
end

-- lsp
-- local opts = { noremap = true, silent = true }
vim.keymap.set("n", 'gD', vim.lsp.buf.declaration, silent_opts)
vim.keymap.set("n", 'gd', function() require("telescope.builtin").lsp_definitions({ fname_width = 200 }) end, silent_opts)
vim.keymap.set("n", 'gt', function() require("telescope.builtin").lsp_type_definitions({ fname_width = 200 }) end,
    silent_opts)
vim.keymap.set("n", 'gi', function() require("telescope.builtin").lsp_implementations({ fname_width = 200 }) end,
    silent_opts)
vim.keymap.set("n", 'gr', function() require("telescope.builtin").lsp_references({ fname_width = 200 }) end, silent_opts)
vim.keymap.set("n", 'gc', function() require("telescope.builtin").lsp_incoming_calls({ fname_width = 200 }) end,
    silent_opts)
vim.keymap.set("n", 'go', function() require("telescope.builtin").lsp_outgoing_calls({ fname_width = 200 }) end,
    silent_opts)
vim.keymap.set("n", 'gs',
    function() require("telescope.builtin").lsp_document_symbols({ fname_width = 200, symbol_width = 60 }) end,
    silent_opts)
vim.keymap.set("n", 'gw',
    function() require("telescope.builtin").lsp_dynamic_workspace_symbols({ fname_width = 200, symbol_width = 60 }) end,
    silent_opts)
vim.keymap.set("n", 'ga',
    function() require("telescope.builtin").lsp_workspace_symbols({ fname_width = 200, symbol_width = 60 }) end,
    silent_opts)
vim.keymap.set("n", "ge",
    function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end, silent_opts)
vim.keymap.set("n", 'K', vim.lsp.buf.hover, silent_opts)
vim.keymap.set("n", 'H', vim.lsp.buf.signature_help, silent_opts)
--vim.keymap.set('i', '<C-h>', vim.lsp.buf.hover, opts)
vim.keymap.set("n", '<space>rn', vim.lsp.buf.rename, silent_opts)
vim.keymap.set("n", '<space>rr', vim.lsp.buf.code_action, silent_opts)
vim.keymap.set("v", '<space>rr', function() vim.lsp.buf.range_code_action({}) end, silent_opts)
vim.keymap.set("n", '<space>e', function() vim.lsp.buf.format({ async = true }) end, silent_opts)
vim.keymap.set("v", '<space>e',
    function() vim.lsp.buf.format({ async = true, range = { vim.api.nvim_buf_get_mark(0, "<"), vim.api.nvim_buf_get_mark(0, ">") } }) end,
    silent_opts)

-- diagnostic
vim.keymap.set("n", '<space>fd',
    function() require("telescope.builtin").diagnostics() end, silent_opts)
vim.keymap.set("n", '<space>fe',
    function() require("telescope.builtin").diagnostics({ severity_limit = vim.diagnostic.severity.WARN }) end,
    silent_opts)
vim.keymap.set("n", ']e',
    function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true }) end,
    silent_opts)
vim.keymap.set("n", '[e',
    function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true }) end,
    silent_opts)
vim.keymap.set("n", ']w',
    function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN, float = true }) end, silent_opts)
vim.keymap.set("n", '[w',
    function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN, float = true }) end,
    silent_opts)
vim.keymap.set("n", ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, silent_opts)
vim.keymap.set("n", '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, silent_opts)

return M
