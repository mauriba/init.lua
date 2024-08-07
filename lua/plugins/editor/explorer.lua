return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = {
        { "echasnovski/mini.icons", opts = {} },
    },
    config = function ()
        local oil = require("oil")
        oil.setup{
            view_options = {
                show_hidden = true
            },
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
        }
        -- Override Ex (explorer) so that Oil gets started instead of netrw
        vim.cmd["Ex"] = vim.cmd["Oil"]
    end
}
