local M = {}

-- Start a lsp server with a specific configuration
-- if it has not started already
function M.start(lsp, config)
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
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local lsp_configs = require("lspconfig.configs")
    if not lsp_configs[lsp] then
        config = vim.tbl_deep_extend(
            "keep",
            config,
            {
                capabilities = capabilities,
                autostart = true, -- Now that the lsp is set up, it may start and attach automatically
            }
        )
        require("lspconfig")[lsp].setup(config)

        -- After setup, there should be a lsp config. If not, the lsp server is not known by lspconfig.
        if lsp_configs[lsp] then
            lsp_configs[lsp].launch()
        end
    end
end

return M
