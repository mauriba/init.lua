return {
    {
        "windwp/nvim-autopairs",
        dependencies = {
            { "hrsh7th/nvim-cmp" },
        },
        event = "InsertEnter",
        opts = {},
        config = function(_, opts)
            local npairs = require("nvim-autopairs")
            local rule = require("nvim-autopairs.rule")
            local cond = require("nvim-autopairs.conds")

            npairs.setup(opts)

            local is_template = require("config.pairs").is_template
            local semicolon = require("config.pairs").struct_class_semicolon

            npairs.add_rules({
                rule("<", ">"):with_pair(cond.none()):with_move(cond.done()):use_key(">"),
                rule("{", "};", { "cpp", "c" }):with_pair(semicolon),
            })

            vim.keymap.set("i", "<", is_template)
        end,
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
