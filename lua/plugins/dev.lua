local plugin_path = vim.env.HOME:gsub("\\", "/") .. "/nvim-plugins"

return {
    {
        dir = plugin_path .. "/cpputils.nvim",
        config = function()
            require("cpputils").setup({})
        end,
    },
}
