local terminal = require "usr.terminal"

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
---| "aider"
---| "copilot"

---@type table<assistant, string>
local assistants = {
    opencode = "opencode",
    aider = "aider",
    copilot = "copilot",
}

---@param open_term fun(state: TerminalState)
---@param state TerminalState
---@param command string[]
local function open(open_term, state, command)
    if vim.api.nvim_buf_is_valid(state.buf) then
        open_term(state)
    else
        open_term(state)
        local channel = vim.bo[state.buf].channel
        vim.fn.chansend(channel, command)
    end
end

---@param assistant assistant
---@param cmd_args? string
function M.use_assistant(assistant, cmd_args)
    if assistants[assistant] ~= nil then
        local state = terminal.new_state()
        local cmd = cmd_args ~= nil and assistants[assistant] .. " " .. cmd_args or assistants[assistant]
        local command = { cmd, "" }
        vim.keymap.set("n", "<space>af", function()
            open(terminal.float_terminal, state, command)
        end)

        vim.keymap.set("n", "<space>ai", function()
            open(terminal.split_terminal, state, command)
        end)

        vim.keymap.set("n", "<space>ao", function()
            open(terminal.open_terminal, state, command)
        end)
    end
end

return M
