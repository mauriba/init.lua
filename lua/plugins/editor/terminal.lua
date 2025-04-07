return {
    {
        'chomosuke/term-edit.nvim',
        event = 'TermOpen',
        version = '1.*',
        config = function()
            require("term-edit").setup({
                -- TODO: Depends on shell
                prompt_end = '%$ ',
            })
        end
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        keys = {
            { "ö", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
        },
        config = function()
            require("toggleterm").setup({

            })
            -- if you only want these mappings for toggle term use term://*toggleterm#* instead
            -- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end
    },
    {
        "da-moon/telescope-toggleterm.nvim",
        dependencies = {
            "akinsho/nvim-toggleterm.lua",
            "nvim-telescope/telescope.nvim",
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>pt", "<cmd>Telescope toggleterm<cr>", desc = "Project terminals" },
        },
        config = function()
            vim.keymap.set("n", "<leader>pt", function()
                require('telescope-toggleterm').open()
            end, { desc = "Project terminals" })
        end,
    }
}
