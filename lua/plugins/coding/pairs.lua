return {
    {
        "echasnovski/mini.pairs",
        version = false,
        config = function ()
            require('mini.pairs').setup()
        end
    },
    {
        "windwp/nvim-ts-autotag",
        config = function ()
            require('nvim-ts-autotag').setup({
                opts = {
                    -- Defaults
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = false -- Auto close on trailing </
                },
            })
        end
    },
}
