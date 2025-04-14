return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
        ft = { 'markdown' },
        config = function()
            require('render-markdown').setup({
                completions = { lsp = { enabled = true } },
                html = {
                    -- Turn on / off all HTML rendering.
                    enabled = true,
                    -- Additional modes to render HTML.
                    render_modes = false,
                    comment = {
                        -- Turn on / off HTML comment concealing.
                        conceal = false,
                        -- Optional text to inline before the concealed comment.
                        text = nil,
                        -- Highlight for the inlined text.
                        highlight = 'RenderMarkdownHtmlComment',
                    },
                },
            })
        end,
    },
}
