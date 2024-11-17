-- Otter enables lsps in embedded code blocks (e.g. markdown)
return {
    'jmbuhr/otter.nvim',
    keys = {
        {
            '<leader>ot',
            function()
                require("otter").activate()
            end,
            desc = 'Otter (LSP for embedded blocks)'
        },
    },
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
}
