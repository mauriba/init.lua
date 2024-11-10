return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.setup({
            default_format_opts = {
                lsp_format = "fallback",
                timeout_ms = 500
            }
        })
        vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
        vim.keymap.set({"n", "v"}, "<leader>gq", conform.format, {desc = "format whole document"})
    end
}
