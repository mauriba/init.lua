return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -G Ninja -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
            },
        },
        keys = {
            { "<leader>pb", nil, desc = "Telescope: Project Buffers" },
            { "<leader>pf", nil, desc = "Telescope: Project Files" },
            { "<leader>pg", nil, desc = "Telescope: Project Git Files" },
            { "<leader>pc", nil, desc = "Telescope: Project Color Themes" },
            { "<leader>ps", nil, desc = "Telescope: Project Search (Grep)" },
            { "<leader>pws", nil, desc = "Telescope: Project Search under cursor" },
            { "<leader>pWs", nil, desc = "Telescope: Project Search around cursor" },
        },

        config = function()
            -- 1. Set up native fzf
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    },
                },
                pickers = {
                    colorscheme = {
                        enable_preview = true
                    }
                }
            }
            -- To get fzf loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            if pcall(require, 'fzf_lib') then
                require('telescope').load_extension('fzf')
            end

            -- 2. Set up keybinds
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pb', builtin.buffers)
            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
            vim.keymap.set('n', '<leader>pc', builtin.colorscheme, {})
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
            vim.keymap.set('n', '<leader>pws', function()
                local word = vim.fn.expand("<cword>")
                builtin.grep_string({ search = word })
            end)
            vim.keymap.set('n', '<leader>pWs', function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end)
            vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        end
    },
}
