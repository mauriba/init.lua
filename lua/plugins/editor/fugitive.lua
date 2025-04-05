return {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "Gdiffsplit" },
    keys = {
        { "<leader>gc", "<cmd>silent G commit<cr>",            desc = "Git commit" },
        { "<leader>g+", "<cmd>silent G push<cr>",              desc = "Git push" },
        { "<leader>g-", "<cmd>silent G pull --rebase<cr>",     desc = "Git pull" },
        { "<leader>ga", "<cmd>silent G add -A<cr>",            desc = "Git add all" },
        { "<leader>gC", "<cmd>silent G add -A | G commit<cr>", desc = "Git add all & commit" },
    },
    config = function()

    end,
}
