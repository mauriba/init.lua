return {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
        enabled = false,
        disabled_keys = {
            ["<Up>"] = { "n" },
            ["<Down>"] = { "n" },
            ["<Right>"] = { "n" },
            ["<Left>"] = { "n" },
        }
    },
}
