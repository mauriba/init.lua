return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = {
        { "echasnovski/mini.icons", opts = {} },
    },
    config = function()
        local oil = require("oil")
        oil.setup {
            view_options = {
                show_hidden = true
            },
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
            keymaps = {
                ["<C-s>"] = false,
                ["<C-h>"] = false,
                ["<C-t>"] = false,
            },
            lsp_file_methods = {
                -- Time to wait for LSP file operations to complete before skipping
                timeout_ms = 1000,
                -- Set to true to autosave buffers that are updated with LSP willRenameFiles
                -- Set to "unmodified" to only save unmodified buffers
                autosave_changes = "unmodified",
            },
            watch_for_changes = true,
            skip_confirm_for_simple_edits = true,
            prompt_save_on_select_new_entry = false,
        }
        -- Override Ex (explorer) so that Oil gets started instead of netrw
        vim.cmd["Ex"] = vim.cmd["Oil"]
    end
}
