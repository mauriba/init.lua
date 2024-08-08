-- default callback on lsp attach
local on_lspattach = function(client, bufnr)
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "gd", function()
        builtin.lsp_definitions({
            initial_mode = "normal",
        })
    end, {silent = true, remap = true})
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
    vim.keymap.set("n", "gr", builtin.lsp_references)

    vim.keymap.set("n", "gR", vim.lsp.buf.rename)
end

return {
    "neovim/nvim-lspconfig",
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
        "j-hui/fidget.nvim",
        "nvim-telescope/telescope.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls", "clangd",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_lspattach
                    }
                end,
                clangd = function()
                    require("lspconfig")["clangd"].setup {
                        on_attach = function(client, bufnr)
                            client.server_capabilities.signatureHelpProvider = false
                            on_lspattach(client, bufnr)
                        end,
                        capabilities = capabilities,
                    }
                end,
                lua_ls = function()
                    require("lspconfig").lua_ls.setup {
                        on_init = function(client)
                            local path = client.workspace_folders[1].name
                            if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                                return
                            end
                        end,
                        settings = {
                            Lua = {}
                        }
                    }
                end,
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                    { name = 'buffer' },
                })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
