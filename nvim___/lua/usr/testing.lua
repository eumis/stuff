local M = {adapters = {}}

function M.add_neotest_adapter(adapter)
    table.insert(M.adapters, adapter)
end

function M.setup()
    require("neotest").setup({
        adapters = M.adapters
    })
end

return M
