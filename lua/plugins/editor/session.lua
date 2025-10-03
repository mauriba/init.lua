return {
    "rmagatti/auto-session",
    lazy = false,
    keys = {
        { "<leader>pS", "<cmd>AutoSession search<CR>", desc = "Session search" },
        { "<leader>ss", "<cmd>AutoSession save<CR>",   desc = "Save session" },
        { "<leader>sd", "<cmd>AutoSession delete<CR>", desc = "Delete session" },
        { "<leader>sa", "<cmd>AutpSession toggle<CR>", desc = "Toggle autosave" },
    },
    config = function()
        require("auto-session").setup({
            enabled = true,
            auto_save = true,
            auto_crreate = true,
            purge_after_minutes = 43200, -- 30 days
            cwd_change_handling = true,
            session_control = {
                control_dir = vim.fn.stdpath("data") .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
                control_filename = "session_control.json",                -- File name of the session control file
            },
        })
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end
}
