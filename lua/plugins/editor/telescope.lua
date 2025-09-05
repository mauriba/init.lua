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
            { "<leader>pb",  "<cmd>Telescope buffers<cr>",      desc = "Telescope: Project Buffers" },
            { "<leader>pf",  "<cmd>Telescope find_files<cr>",   desc = "Telescope: Project Files" },
            { "<leader>pgb", "<cmd>Telescope git_branches<cr>", desc = "Telescope: Project Git Branches" },
            {
                "<leader>pgc",
                function()
                    if vim.bo.filetype == "oil" then
                        require("telescope.builtin").git_commits();
                    else
                        require("telescope.builtin").git_bcommits();
                    end
                end,
                desc = "Telescope: Project Git Commits"
            },
            { "<leader>pn", "<cmd>Telescope notify<cr>",      desc = "Telescope: Project Notifications" },
            { "<leader>pc", "<cmd>Telescope colorscheme<cr>", desc = "Telescope: Project Color Themes" },
            { "<leader>ph", "<cmd>Telescope help_tags<cr>",   desc = "Telescope: Help Tags" },
            { "<leader>pk", "<cmd>Telescope keymaps<cr>",     desc = "Telescope: Key Maps" },
            {
                "<leader>ps",
                function()
                    require("config.multigrep").multigrep()
                    -- require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
                end,
                desc = "Telescope: Project Search (Grep)"
            },
            {
                "<leader>pws",
                function()
                    local word = vim.fn.expand("<cword>")
                    require("telescope.builtin").grep_string({ search = word })
                end,
                desc = "Telescope: Project Search under cursor"
            },
            {
                "<leader>pWs",
                function()
                    local word = vim.fn.expand("<cWORD>")
                    require("telescope.builtin").grep_string({ search = word })
                end,
                desc = "Telescope: Project Search around cursor"
            },
        },

        config = function()
            -- 1. Set up native fzf
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
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
        end
    },
}
