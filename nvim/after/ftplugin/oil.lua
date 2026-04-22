local ext = vim.fn.expand("%:e")
vim.keymap.set("n", "yP", function() require("oil.actions").yank_entry() end)
vim.keymap.set("n", "yp", function()
    local oil = require("oil");
    local entry = oil.get_cursor_entry();
    if entry ~= nil then
        local full_path = oil.get_current_dir() .. entry.name;
        local relative_path = vim.fn.fnamemodify(full_path, ":.");
        vim.fn.setreg("+", relative_path);
    end
end)
