return {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod',                     cmd = { 'DB' },                   lazy = true, },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
        'DBUI', -- Use this to get started
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer', -- Use this to bind sql file to db
    },
    keys = {
        { '<leader>DBt', '<cmd>DBUIToggle<cr>', desc = 'Database UI' },
        { '<leader>DBf', '<cmd>DBUIFindBuffer<cr>', desc = "Database find SQL file" },
    },
    init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
    end,
}
