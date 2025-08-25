return {
    "rmagatti/auto-session",
    lazy = false,
    keys = {
        { "<leader>pS", "<cmd>SessionSearch<CR>",         desc = "Session search" },
        { "<leader>ss", "<cmd>SessionSave<CR>",           desc = "Save session" },
        { "<leader>sd", "<cmd>SessionDelete<CR>",         desc = "Delete session" },
        { "<leader>sa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
    },
    config = function()
        require("auto-session").setup({
            suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            purge_after_minutes = 43200, -- 30 days
            cwd_change_handling = true,
        })
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end
}
