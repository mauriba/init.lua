local dev_plugins_path = vim.env.HOME:gsub("\\", "/") .. "/nvim-plugins"

-- Helper function to check if the directory of a local plugin exists
local function is_dir(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "directory"
end

local plugins = {
    {
        dir = dev_plugins_path .. "/cpputils.nvim",
        config = function()
            require("cpputils").setup({})
        end,
    },
}

-- Filter: only return plugins whose `dir` exists
local existing_plugins = {}
for _, plugin in ipairs(plugins) do
    if plugin.dir and is_dir(plugin.dir) then
        table.insert(existing_plugins, plugin)
    end
end

return existing_plugins
