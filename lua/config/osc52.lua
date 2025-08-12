-- osc52.lua
--
-- Hardcoded osc52 clipboard provider if no other is specified.
-- OSC52 is a protocol used by many terminals to allow yanking over SSH sessions.

-- Function to check if any clipboard provider is available
local function has_clipboard_provider()
    local providers = { "xclip", "win32yank", "xsel", "pbcopy", "wl-copy" }
    for _, p in ipairs(providers) do
        if vim.fn.executable(p) == 1 then
            return true
        end
    end
    return false
end

if not has_clipboard_provider() then
    -- OSC52 clipboard integration for SSH / headless
    local function copy(lines, _)
        local text = table.concat(lines, "\n")
        local encoded = vim.fn.system("base64", text):gsub("\n", "")
        local osc52 = "\x1b]52;c;" .. encoded .. "\x07"
        io.stdout:write(osc52)
    end

    local function paste()
        return {}, 0
    end

    vim.g.clipboard = {
        name = "osc52",
        copy = { ["+"] = copy, ["*"] = copy },
        paste = { ["+"] = paste, ["*"] = paste },
    }
end
