return {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "Gdiffsplit" },
    keys = {
        { "<leader>gc", "<cmd>G commit<cr>",            desc = "Git commit" },
        { "<leader>g+", "<cmd>G push<cr>",              desc = "Git push" },
        { "<leader>g-", "<cmd>G pull --rebase<cr>",     desc = "Git pull" },
        { "<leader>ga", "<cmd>G add -A<cr>",            desc = "Git add all" },
        { "<leader>gC", "<cmd>G add -A | G commit<cr>", desc = "Git add all & commit" },
    },
    config = function()

    end,
}
