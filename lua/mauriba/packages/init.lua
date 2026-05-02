-- Requires all lua files in a given directory
local function require_all(dir)
  local base_path = vim.fn.stdpath("config") .. "/lua/" .. dir:gsub("%.", "/")
  local files = vim.fn.readdir(base_path)

  for _, file in ipairs(files) do
    -- skip this init.lua and non-lua files
    if file ~= "init.lua" and file:sub(-4) == ".lua" then
      local module = dir .. "." .. file:gsub("%.lua$", "")
      pcall(require, module)
    end
  end
end

require_all("mauriba.packages")
