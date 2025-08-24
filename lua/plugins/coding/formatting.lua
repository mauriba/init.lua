return {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>gq",
            function()
                require("conform").format({ async = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "gofmt" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            cpp = { "clang-format" },
            c = { "clang-format" },
            json = { "fixjson", "jq", stop_after_first = true }, -- For manual indentation, use ":%!jq --indent 2 ."
        },
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 4000,
            lsp_format = "fallback",
        },
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end
}
