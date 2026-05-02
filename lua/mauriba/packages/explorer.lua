-- Default packages
vim.pack.add({
    "https://github.com/stevearc/oil.nvim"
})

require("oil").setup({
    default_file_explorer = true,
    columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
    },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    lsp_file_methods = {
        enabled = true,
        timeout_ms = 3000,
        autosave_changes = false,
    },
    watch_for_changes = true,
})
