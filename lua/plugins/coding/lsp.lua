-- Lsp plugin specification for LazyVim
-- and useful `start` function for starting
-- lsp servers from ftplugin
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
    },

    config = function()
        local cmp = require('cmp')

        require("fidget").setup({})
        require("mason").setup({})

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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

        -- Autocmd for useful lsp keybinds
        local ts = require("telescope.builtin")
        local lsp_group = vim.api.nvim_create_augroup("lsp", {})
        vim.api.nvim_create_autocmd("LspAttach", {
            group = lsp_group,
            callback = function(e)
                local opts = { buffer = e.buf }
                vim.keymap.set("n", "gd", function() ts.lsp_definitions() end, opts)
                vim.keymap.set("n", "gr", function() ts.lsp_references({include_declaration = false}) end, opts)
                vim.keymap.set("n", "gi", function() ts.lsp_implementations() end, opts)
                vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)     end
        })
    end,

    -- Start a lsp server with a specific configuration
    -- if it has not started already
    start = function(lsp, config)
        if not lsp then
            return false
        end

        config = config or {}

        -- Create default capabilities to request from lsps
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
        )
        capabilities.textDocument.foldingRange = { -- Code folding for UFO lsp support
            dynamicRegistration = false,
            lineFoldingOnly = true
        }

        local lsp_configs = require("lspconfig.configs")
        if not lsp_configs[lsp] then
            config = vim.tbl_deep_extend(
                "keep",
                config,
                {
                    capabilities = capabilities,
                    autostart = true,       -- Now that the lsp is set up, it may start and attach automatically
                }
            )
            require("lspconfig")[lsp].setup(config)
            lsp_configs[lsp].launch()
        end
    end
}
