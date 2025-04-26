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
            -- Set to PowerShell on windows
            if vim.fn.has("win32") == 1 then
                local powershell_options = {
                    shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
                    shellcmdflag =
                    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
                    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
                    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
                    shellquote = "",
                    shellxquote = "",
                }

                for option, value in pairs(powershell_options) do
                    vim.opt[option] = value
                end
            end

            require("toggleterm").setup({
                hide_numbers = false,
                direction = "horizontal",
            })
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
