return {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>tdt", "<cmd>TodoTelescope<cr>", desc = "Todo: Telescope" },
        { "<leader>tdq", "<cmd>TodoQuickFix<cr>", desc = "Todo: Quickfix" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        keywords = {
            FIX = {
                icon = " ", -- icon used for the sign, and in search results
                color = "error", -- can be a hex color, or a named color (see below)
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                -- signs = false, -- configure signs for some keywords individually
            },
            TODO = { icon = " ", color = "info" },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
    }
    -- Useful commands with todo-comments:
    -- :TodoTelescope -> search through all markers project-wide
    -- :TodoQuickFix -> watch all markers project-wide in quickfix
    -- :Trouble todo -> show project-wide todos and notes and fixmes in trouble
}
