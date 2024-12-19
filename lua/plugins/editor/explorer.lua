return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = {
        { "echasnovski/mini.icons", opts = {} },
        { "SirZenith/oil-vcs-status" },
    },
    config = function()
        local oil = require("oil")
        oil.setup {
            win_options = {
                signcolumn = "yes",
            },
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

        local StatusType = require("oil-vcs-status.constant.status").StatusType
        require("oil-vcs-status").setup({
            status_symbol = {
                [StatusType.Added]               = "",
                [StatusType.Copied]              = "󰆏",
                [StatusType.Deleted]             = "",
                [StatusType.Ignored]             = "",
                [StatusType.Modified]            = "",
                [StatusType.Renamed]             = "",
                [StatusType.TypeChanged]         = "󰉺",
                [StatusType.Unmodified]          = " ",
                [StatusType.Unmerged]            = "",
                [StatusType.Untracked]           = "",
                [StatusType.External]            = "",

                [StatusType.UpstreamAdded]       = "󰈞",
                [StatusType.UpstreamCopied]      = "󰈢",
                [StatusType.UpstreamDeleted]     = "",
                [StatusType.UpstreamIgnored]     = " ",
                [StatusType.UpstreamModified]    = "󰏫",
                [StatusType.UpstreamRenamed]     = "",
                [StatusType.UpstreamTypeChanged] = "󱧶",
                [StatusType.UpstreamUnmodified]  = " ",
                [StatusType.UpstreamUnmerged]    = "",
                [StatusType.UpstreamUntracked]   = " ",
                [StatusType.UpstreamExternal]    = "",
            },
            
            status_hl_group = {
                [StatusType.Added]               = "DiagnosticHint",
                [StatusType.Copied]              = "DiagnosticHint",
                [StatusType.Deleted]             = "DiagnosticError",
                [StatusType.Ignored]             = "Identifier",
                [StatusType.Modified]            = "DiagnosticWarn",
                [StatusType.Renamed]             = "DiagnosticWarn",
                [StatusType.TypeChanged]         = "DiagnosticWarn",
                [StatusType.Unmerged]            = "DiagnosticError",
                [StatusType.Untracked]           = "DiagnosticHint",
                [StatusType.External]            = "DiagnosticWarn",
            }
        })
    end
}
