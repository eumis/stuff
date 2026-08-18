local M = {}

M.config = {
    indent = "  ",
    sort_keys = false,
    prefix = "",
    trailing_comma = false,
}

local reserved = {
    ["and"] = true,
    ["break"] = true,
    ["do"] = true,
    ["else"] = true,
    ["elseif"] = true,
    ["end"] = true,
    ["false"] = true,
    ["for"] = true,
    ["function"] = true,
    ["goto"] = true,
    ["if"] = true,
    ["in"] = true,
    ["local"] = true,
    ["nil"] = true,
    ["not"] = true,
    ["or"] = true,
    ["repeat"] = true,
    ["return"] = true,
    ["then"] = true,
    ["true"] = true,
    ["until"] = true,
    ["while"] = true,
}

local escapes = {
    ['"'] = '\\"',
    ["\\"] = "\\\\",
    ["\n"] = "\\n",
    ["\r"] = "\\r",
    ["\t"] = "\\t",
    ["\a"] = "\\a",
    ["\b"] = "\\b",
    ["\f"] = "\\f",
    ["\v"] = "\\v",
}

local function quote_string(s)
    local out = s:gsub('[%z\1-\31"\\]', function(c)
        return escapes[c] or string.format("\\%03d", string.byte(c))
    end)
    return '"' .. out .. '"'
end

local function is_array(t)
    local n = 0
    for _ in pairs(t) do
        n = n + 1
    end
    if n == 0 then
        return true
    end
    return n == #t
end

local function format_key(k)
    if type(k) == "string" and k:match("^[%a_][%w_]*$") and not reserved[k] then
        return k
    end
    if type(k) == "number" then
        return "[" .. tostring(k) .. "]"
    end
    return "[" .. quote_string(tostring(k)) .. "]"
end

local serialize

local function serialize_table(t, level)
    if next(t) == nil then
        return "{}"
    end

    local pad = string.rep(M.config.indent, level + 1)
    local close_pad = string.rep(M.config.indent, level)
    local parts = {}

    if is_array(t) then
        for i = 1, #t do
            parts[#parts + 1] = pad .. serialize(t[i], level + 1)
        end
    else
        local keys = {}
        for k in pairs(t) do
            keys[#keys + 1] = k
        end
        if M.config.sort_keys then
            table.sort(keys, function(a, b)
                return tostring(a) < tostring(b)
            end)
        end
        for _, k in ipairs(keys) do
            parts[#parts + 1] = pad .. format_key(k) .. " = " .. serialize(t[k], level + 1)
        end
    end

    local body = table.concat(parts, ",\n")
    if M.config.trailing_comma then
        body = body .. ","
    end
    return "{\n" .. body .. "\n" .. close_pad .. "}"
end

serialize = function(value, level)
    if value == nil or value == vim.NIL then
        return "nil"
    end
    local t = type(value)
    if t == "boolean" then
        return tostring(value)
    end
    if t == "number" then
        if value ~= value then
            return "0/0"
        end
        if value == math.huge then
            return "math.huge"
        end
        if value == -math.huge then
            return "-math.huge"
        end
        return tostring(value)
    end
    if t == "string" then
        return quote_string(value)
    end
    if t == "table" then
        return serialize_table(value, level)
    end
    return quote_string(tostring(value))
end

local function get_visual_range()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    local srow = start_pos[2] - 1
    local scol = start_pos[3] - 1
    local erow = end_pos[2] - 1
    local ecol = end_pos[3] - 1

    local last_line = vim.api.nvim_buf_get_lines(0, erow, erow + 1, true)[1] or ""
    local vmode = vim.fn.visualmode()

    if vmode == "V" then
        scol = 0
        ecol = #last_line
    elseif vim.o.selection == "exclusive" then
        -- ecol already points one past the last selected byte
    else
        if ecol < #last_line then
            local b = string.byte(last_line, ecol + 1)
            local charlen = (b < 0x80) and 1 or (b < 0xE0) and 2 or (b < 0xF0) and 3 or 4
            ecol = ecol + charlen
        else
            ecol = #last_line
        end
    end

    ecol = math.min(ecol, #last_line)
    return srow, scol, erow, ecol
end

function M.convert_selection()
    local srow, scol, erow, ecol = get_visual_range()

    local lines = vim.api.nvim_buf_get_text(0, srow, scol, erow, ecol, {})
    local json_str = table.concat(lines, "\n")

    if vim.trim(json_str) == "" then
        vim.notify("json_to_lua: empty selection", vim.log.levels.WARN)
        return
    end

    local ok, data = pcall(vim.json.decode, json_str)
    if not ok then
        vim.notify("json_to_lua: invalid JSON: " .. tostring(data), vim.log.levels.ERROR)
        return
    end

    local base_indent = (vim.api.nvim_buf_get_lines(0, srow, srow + 1, true)[1] or ""):match("^%s*") or ""
    local rendered = M.config.prefix .. serialize(data, 0)

    local out = vim.split(rendered, "\n", { plain = true })
    for i = 2, #out do
        out[i] = base_indent .. out[i]
    end

    vim.api.nvim_buf_set_text(0, srow, scol, erow, ecol, out)
end

return M
