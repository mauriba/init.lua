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
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        -- Autosave toggle
        _G.conform_autosave = true
        vim.keymap.set("n", "<leader>fa", function()
            _G.conform_autosave = not _G.conform_autosave
            if _G.conform_autosave then
                print("Format on save: ON")
            else
                print("Format on save: OFF")
            end
        end, { desc = "Toggle Conform auto-save formatting" })

        -- Autosave functionality
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
                if _G.conform_autosave then
                    require("conform").format({
                        timeout_ms = 4000,
                        lsp_format = "fallback"
                    })
                end
            end,
        })
    end
}
