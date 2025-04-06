return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
        ft = { 'markdown' },
        config = function()
            require('render-markdown').setup({
                completions = { lsp = { enabled = true } },
            })
        end,
    },
}
