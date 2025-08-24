return {
    {
        'brenoprata10/nvim-highlight-colors',
        ft = {
            "css", "javascript", "html"
        },
        config = function()
            require('nvim-highlight-colors').setup({
                render = "virtual"
            })
        end,
    }
}
