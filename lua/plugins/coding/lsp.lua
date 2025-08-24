-- TODO: Certain LSP installations require special programs
-- like terraform, powershell_es etc.
-- We should consider removing them to avoid constant
-- errors on startup.
--
-- TODO: Better formatting (some smart auto-detect like in vscode)
return {
    "neovim/nvim-lspconfig",
    event = "InsertEnter",
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        { "onsails/lspkind.nvim", config = function() require("lspkind").setup() end },
        "zbirenbaum/copilot-cmp",
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        -- Create default capabilities to request from lsps
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )
        capabilities.textDocument.foldingRange = { -- Code folding for UFO lsp support
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls", "clangd", "powershell_es", "terraformls",
                "texlab", "pyright", "markdown_oxide", "neocmake",
                "jsonls", "yamlls", "ts_ls", "sqlls", "julials",
            },
            automatic_installation = true,
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                markdown_oxide = function()
                    require("lspconfig").markdown_oxide.setup({
                        -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
                        -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
                        capabilities = vim.tbl_deep_extend(
                            "force",
                            capabilities,
                            {
                                workspace = {
                                    didChangeWatchedFiles = {
                                        dynamicRegistration = true,
                                    },
                                },
                            }
                        )
                    })
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,
                lua_ls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })
        require("copilot_cmp").setup({})
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        local sources = {
            {
                name = "nvim_lsp",
                option = {
                    markdown_oxide = {
                        keyword_pattern = [[\(\k\| \|\/\|#\)\+]]
                    }
                }
            },
            { name = "luasnip" }, -- For luasnip users.
            { name = "path" },
            { name = "copilot" },
            { name = "buffer" },
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources(sources),
            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "symbol_text",
                    max_width = 50,
                    symbol_map = { Copilot = "" }
                })
            },
        })

        cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
            sources = vim.list_extend(sources, {
                { name = "vim-dadbod-completion" },
            }),
        })

        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
        vim.diagnostic.config({
            virtual_text = true,
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        -- Autocmd for useful lsp keybinds
        local ts = require("telescope.builtin")
        local lsp_group = vim.api.nvim_create_augroup("lsp", {})
        vim.api.nvim_create_autocmd("LspAttach", {
            group = lsp_group,
            callback = function(e)
                vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end,
                    { buffer = e.buf, desc = "LSP Code Action" })
                vim.keymap.set("n", "gd", function() ts.lsp_definitions() end,
                    { buffer = e.buf, desc = "LSP Goto Definition" })
                vim.keymap.set("n", "gr", function() ts.lsp_references({ include_declaration = false }) end,
                    { buffer = e.buf, desc = "LSP Goto References" })
                vim.keymap.set("n", "gi", function() ts.lsp_implementations() end,
                    { buffer = e.buf, desc = "LSP Goto Implementations" })
                vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, { buffer = e.buf, desc = "LSP Rename" })
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { buffer = e.buf, desc = "LSP Hover" })
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end,
                    { buffer = e.buf, desc = "Open Diagnostics" })
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end,
                    { buffer = e.buf, desc = "Next Diagnostic" })
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end,
                    { buffer = e.buf, desc = "Previous Diagnostic" })
            end
        })

        vim.cmd("LspStart")
    end,
}
