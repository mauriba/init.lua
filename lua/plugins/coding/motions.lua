return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter",
        },
        event = "InsertEnter",
        keys = {
            { "af", nil, desc = "Select around function" },
            { "if", nil, desc = "Select inside function" },
            { "ac", nil, desc = "Select around class" },
            { "ic", nil, desc = "Select inside class" },
            { "aa", nil, desc = "Select around parameter" },
            { "ia", nil, desc = "Select inside parameter" },
            { "il", nil, desc = "Select inside loop" },
            { "al", nil, desc = "Select around loop" },
            { "ai", nil, desc = "Select around conditional" },
            { "ii", nil, desc = "Select inside conditional" },
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
        keys = {
            { "sa", nil, desc = "Add surrounding" },
            { "sd", nil, desc = "Delete surrounding" },
            { "sf", nil, desc = "Find surrounding to the right" },
            { "sF", nil, desc = "Find surrounding to the left" },
            { "sh", nil, desc = "Highlight surrounding" },
            { "sr", nil, desc = "Replace surrounding" },
            { "sn", nil, desc = "Update surrounding n_lines" }
        },
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
