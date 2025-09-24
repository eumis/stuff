local M = {}

---@alias suggestion_provider
---| "copilot"
---| "supermaven"

---@param provider suggestion_provider?
function M.use_suggestions(provider)
    ---@type string?
    if provider == "copilot" then
        require("copilot")
    elseif provider == "supermaven" then
        require("supermaven-nvim")
        local binary = require("supermaven-nvim.binary.binary_handler")
        ---@diagnostic disable-next-line: unused-local, duplicate-set-field
        binary.open_popup = function(self, message, include_free)
            print("free supermaven started")
        end
        local api = require("supermaven-nvim.api")
        api.use_free_version()
    else
        return
    end
    require("usr.statusline").copilot.set_value(provider)
end

---@alias assistant
---| "opencode"

---@param assistant assistant
function M.use_assistant(assistant)
    if assistant == "opencode" then
        print("opencode started")
        local terminal = require "usr.terminal"
        local state = terminal.new_state()
        vim.keymap.set("n", "<space>af", function()
            if vim.api.nvim_buf_is_valid(state.buf) then
                terminal.float_terminal(state)
            else
                terminal.float_terminal(state)
                local channel = vim.bo[state.buf].channel
                vim.fn.chansend(channel, { "opencode", "" })
            end
        end)

        vim.keymap.set("n", "<space>ai", function()
            if vim.api.nvim_buf_is_valid(state.buf) then
                terminal.split_terminal(state)
            else
                terminal.split_terminal(state)
                local channel = vim.bo[state.buf].channel
                vim.fn.chansend(channel, { "opencode", "" })
            end
        end)

        vim.keymap.set("n", "<space>ao", function()
            if vim.api.nvim_buf_is_valid(state.buf) then
                terminal.open_terminal(state)
            else
                terminal.open_terminal(state)
                local channel = vim.bo[state.buf].channel
                vim.fn.chansend(channel, { "opencode", "" })
            end
        end)
    end
end

return M
