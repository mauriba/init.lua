return {
    {
        'nmac427/guess-indent.nvim',
        event = "BufReadPost",
        config = function()
            require('guess-indent').setup({
                filetype_exclude = {
                    "netrw",
                    "tutor",
                    "oil",
                }
            })
        end,
    },
    {
        'vidocqh/auto-indent.nvim',
        event = "BufReadPost",
        opts = {
            lightmode = false
        },
    },
}
