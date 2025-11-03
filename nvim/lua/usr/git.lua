local terminal = require "usr.terminal"

local M = {}


---@type TerminalState?
local state = nil

M.open = function()
    if state == nil then
        state = terminal.new_state({ "lazygit", "" })
    end
    terminal.float_terminal(state)
end

return M
