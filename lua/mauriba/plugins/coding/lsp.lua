return {
    {
        "saghen/blink.cmp",
        version = "v0.*", -- Recommended to use release tags
        dependencies = {
            "L3MON4D3/LuaSnip",
            event = "InsertEnter",
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            -- build = "make install_jsregexp",

            dependencies = { "rafamadriz/friendly-snippets" },

            config = function()
                local ls = require("luasnip")

                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip.loaders.from_lua").load({
                    paths = vim.fn.stdpath("config") .. "/snippets",
                })

                ls.filetype_extend("javascript", { "jsdoc" })
                vim.keymap.set({ "i" }, "<C-e>", function() ls.expand() end, { silent = true })

                vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(1) end, { silent = true })
                vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(-1) end, { silent = true })

                vim.keymap.set({ "i", "s" }, "<C-E>", function()
                    if ls.choice_active() then
                        ls.change_choice(1)
                    end
                end, { silent = true })
            end,
        },
        opts = {
            -- Tell blink to use LuaSnip
            snippets = { preset = "luasnip" },

            -- Mimic your previous cmp keymaps
            keymap = {
                preset = "none",
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },
                ["<C-y>"] = { "select_and_accept", "fallback" },
                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            },

            appearance = {},

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },

                -- Dadbod completion for DB plugins
                per_filetype = {
                    sql = { "snippets", "dadbod", "buffer" },
                    mysql = { "snippets", "dadbod", "buffer" },
                    plsql = { "snippets", "dadbod", "buffer" },
                },

                providers = {
                    dadbod = {
                        name = "Dadbod",
                        module = "vim_dadbod_completion.blink",
                    },
                },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- Fetch default capabilities from blink instead of cmp
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            capabilities.textDocument.foldingRange = { -- Code folding for UFO lsp support
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            -- LSPs outside of mason go here
            if vim.fn.executable("sourcekit-lsp") == 1 then
                vim.lsp.enable("sourcekit")
            end

            -- LSPs installed via mason get automatically configured
            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "pyright",
                    "markdown_oxide",
                    "jsonls",
                    "yamlls",
                    "ts_ls",
                },
                handlers = {
                    function(server_name) -- default handler
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,

                    markdown_oxide = function()
                        require("lspconfig").markdown_oxide.setup({
                            capabilities = vim.tbl_deep_extend("force", capabilities, {
                                workspace = {
                                    didChangeWatchedFiles = {
                                        dynamicRegistration = true,
                                    },
                                },
                            }),
                        })
                    end,

                    lua_ls = function()
                        require("lspconfig").lua_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = { version = "Lua 5.1" },
                                    diagnostics = {
                                        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                    },
                                },
                            },
                        })
                    end,
                },
            })

            vim.diagnostic.config({
                virtual_text = false,
                update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "",
                        [vim.diagnostic.severity.INFO] = "",
                    },
                },
            })

            -- Autocmd for useful lsp keybinds
            local ts = require("telescope.builtin")
            local lsp_group = vim.api.nvim_create_augroup("lsp", {})
            vim.api.nvim_create_autocmd("LspAttach", {
                group = lsp_group,
                callback = function(e)
                    vim.keymap.set("n", "ga", function()
                        vim.lsp.buf.code_action()
                    end, { buffer = e.buf, desc = "LSP Code Action" })
                    vim.keymap.set("n", "gd", function()
                        ts.lsp_definitions()
                    end, { buffer = e.buf, desc = "LSP Goto Definition" })
                    vim.keymap.set("n", "gr", function()
                        ts.lsp_references({ include_declaration = false })
                    end, { buffer = e.buf, desc = "LSP Goto References" })
                    vim.keymap.set("n", "gi", function()
                        ts.lsp_implementations()
                    end, { buffer = e.buf, desc = "LSP Goto Implementations" })
                    vim.keymap.set("n", "gR", function()
                        vim.lsp.buf.rename()
                    end, { buffer = e.buf, desc = "LSP Rename" })
                    vim.keymap.set("n", "K", function()
                        vim.lsp.buf.hover()
                    end, { buffer = e.buf, desc = "LSP Hover" })
                    vim.keymap.set("n", "<leader>vd", function()
                        vim.diagnostic.open_float()
                    end, { buffer = e.buf, desc = "Open Diagnostics" })
                    vim.keymap.set("n", "]d", function()
                        vim.diagnostic.goto_next()
                    end, { buffer = e.buf, desc = "Next Diagnostic" })
                    vim.keymap.set("n", "[d", function()
                        vim.diagnostic.goto_prev()
                    end, { buffer = e.buf, desc = "Previous Diagnostic" })
                end,
            })
        end,
    },
    {
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
}
