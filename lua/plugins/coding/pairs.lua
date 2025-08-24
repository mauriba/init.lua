return {
    {
        "echasnovski/mini.pairs",
        version = false,
        event = "InsertEnter",
        config = function()
            require('mini.pairs').setup()
        end
    },
    {
        "windwp/nvim-ts-autotag",
        ft = { "markdown", "text", "html", "xml", "svg" },
        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    -- Defaults
                    enable_close = true,         -- Auto close tags
                    enable_rename = true,        -- Auto rename pairs of tags
                    enable_close_on_slash = true -- Auto close on trailing </
                },
            })
        end
    },
    -- List completions
    -- Renumber Lists: gN
    -- Toggle Checkbox: <leader>x
    {
        "bullets-vim/bullets.vim",
        ft = { "markdown", "text" },
    }
}
