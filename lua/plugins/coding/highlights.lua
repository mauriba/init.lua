return {
    -- INFO: Comes with <a-n> to go to next, <a-p> to go to previous occurence of word. <a-i> selects the occurence
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
            require("illuminate").configure({
                providers = { "treesitter", "regex" },
                delay = 400,
            })
        end,
    },
    {
        'brenoprata10/nvim-highlight-colors',
        event = "VeryLazy",
        config = function()
            require('nvim-highlight-colors').setup({
                render = "virtual"
            })
        end,
    }
}
