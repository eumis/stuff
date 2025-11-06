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
---| "vscode"

---@type table<assistant, string>
local assistants = {
    opencode = "opencode",
    aider = "aider",
    copilot = "copilot",
    vscode = "code"
}

---@param assistant assistant
---@param cmd_args? string
function M.use_assistant(assistant, cmd_args)
    if assistants[assistant] ~= nil then
        local cmd = cmd_args ~= nil and assistants[assistant] .. " " .. cmd_args or assistants[assistant]
        local state = terminal.new_state({ cmd, "" })
        vim.keymap.set("n", "<space>af", function()
            terminal.float_terminal(state)
        end)

        vim.keymap.set("n", "<space>ai", function()
            terminal.split_terminal(state)
        end)

        vim.keymap.set("n", "<space>ao", function()
            terminal.open_terminal(state)
        end)
    end
end

return M
