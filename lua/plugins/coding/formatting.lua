return {
    "stevearc/conform.nvim",
    config = function ()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylelua" },
                python = { "isort", "black" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                cpp = { "clang-format" }, -- NOTE: Requires clang-format to be installed on the system
                c = { "clang-format" },
            }
        })
        conform.formatters.cpp = {
            prepend_args = { "--fallback-style=Google" },
        }
        
        -- Set keybinds
        vim.keymap.set("", "<leader>f", function()
            require("conform").format({ async = true, lsp_fallback = true })
        end)
    end
}
