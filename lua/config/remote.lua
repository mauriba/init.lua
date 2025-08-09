-- Only enable OSC 52 clipboard if Neovim did not set one already
if not vim.g.clipboard then
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
