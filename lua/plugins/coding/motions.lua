return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter",
        },
        event = "InsertEnter",
        keys = {
            { "<leader>a", nil, desc = "Swap with next parameter" },
            { "<leader>A", nil, desc = "Swap with previous parameter" }
        },
        config = function ()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup {
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["il"] = "@loop.outer",
                            ["al"] = "@loop.inner",
                            ["ai"] = "@conditional.outer",
                            ["ii"] = "@conditional.inner",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                },
            }
        end,
    },
    {
        "echasnovski/mini.surround",
        version = false,
        config = function ()
            require('mini.surround').setup{
                highlight_duration = 500,
                mappings = {
                    add = 'sa',
                    delete = 'sd',
                    find = 'sf',
                    find_left = 'sF',
                    highlight = 'sh',
                    replace = 'sr',
                    update_n_lines = 'sn',
                    suffix_last = 'l',
                    suffix_next = 'n',
                },
                n_lines = 20,
                search_method = 'cover',
                silent = false,
            }
        end
    },
}
