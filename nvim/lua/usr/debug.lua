local M = {}

---@class DotnetDebugConfig
---@field name string
---@field program string | fun(): string
---@field cwd string
---@field args string[]

---@param config DotnetDebugConfig | DotnetDebugConfig[]
M.dotnet = function(config)
    config = config[1] == nil and { config } or config

    local dap_configs = require("dap").configurations.cs
    for _, cfg in ipairs(config) do
        if type(cfg.program) == "string" then
            local value = cfg.program
            cfg.program = function() return value --[[@as string]] end
        end
        table.insert(dap_configs, {
            type = "coreclr",
            name = cfg.name,
            request = "launch",
            program = cfg.program,
            cwd = cfg.cwd,
            args = cfg.args,
            env = {
                ["DOTNET_ENVIRONMENT"] = "Development",
            },
        })
    end
end

return M
