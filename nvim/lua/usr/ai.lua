local M = {}

---@alias provider
---| "copilot"
---| "claude"
---| "supermaven"

---@param provider provider?
function M.on(provider)
    if provider == "copilot" then
        require("copilot")
    elseif provider == "supermaven" then
        require("supermaven-nvim")
        local api = require("supermaven-nvim.api")
        api.use_free_version()
    end
    -- local avante_options = {
    --     -- add any opts here
    --     -- for example
    --     -- provider = "claude",
    --     claude = {
    --         endpoint = "https://api.anthropic.com",
    --         model = "claude-3-5-sonnet-20241022",
    --         temperature = 0,
    --         max_tokens = 4096,
    --     },
    --     -- openai = {
    --     --     endpoint = "https://api.openai.com/v1",
    --     --     model = "gpt-4o",  -- your desired model (or use gpt-4o, etc.)
    --     --     timeout = 30000,   -- Timeout in milliseconds, increase this for reasoning models
    --     --     temperature = 0,
    --     --     max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
    --     --     --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    --     -- },
    --     mappings = {
    --         --- @class AvanteConflictMappings
    --         diff = {
    --             ours = "co",
    --             theirs = "ct",
    --             all_theirs = "ca",
    --             both = "cb",
    --             cursor = "cc",
    --             next = "]x",
    --             prev = "[x",
    --         },
    --         -- suggestion = {
    --         --     accept = "<C-.><C-.>",
    --         --     next = "<C-.><C-m>",
    --         --     prev = "<C-.><C-n>",
    --         --     dismiss = "<C-.><C-,>",
    --         -- },
    --         jump = {
    --             next = "]]",
    --             prev = "[[",
    --         },
    --         submit = {
    --             normal = "<CR>",
    --             insert = "<C-s>",
    --         },
    --         cancel = {
    --             normal = { "<C-c>", "<Esc>", "q" },
    --             insert = { "<C-c>" },
    --         },
    --         sidebar = {
    --             apply_all = "A",
    --             apply_cursor = "a",
    --             retry_user_request = "r",
    --             edit_user_request = "e",
    --             switch_windows = "<Tab>",
    --             reverse_switch_windows = "<S-Tab>",
    --             remove_file = "d",
    --             add_file = "@",
    --             close = { "<Esc>", "q" },
    --             close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
    --         },
    --     },
    -- }
    -- if provider == nil then provider = "claude" end
    -- avante_options.provider = provider
    -- print('SETTING PROVIDER FOR ' .. provider)
    -- require('avante').setup(avante_options)
end

return M
