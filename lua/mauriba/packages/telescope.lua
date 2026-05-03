local hooks = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
        vim.system({ 'make' }, { cwd = ev.data.path }):wait()
        vim.notify("Building native fzf successful!")
    end
end
vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })

vim.pack.add({
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim'
})

require('telescope').setup {
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
    },
    pickers = {
        colorscheme = {
            enable_preview = true
        }
    }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
if pcall(require, 'fzf_lib') then
    require('telescope').load_extension('fzf')
end

-- Keymaps
local map = vim.keymap.set
local tb = require("telescope.builtin")

map("n", "<leader>pb", tb.buffers, { desc = "Telescope: Project Buffers" })
map("n", "<leader>pf", tb.find_files, { desc = "Telescope: Project Files" })
map("n", "<leader>pl", tb.lsp_document_symbols, { desc = "Telescope: LSP Document symbols" })
map("n", "<leader>pL", tb.lsp_workspace_symbols, { desc = "Telescope: LSP Workspace symbols" })
map("n", "<leader>pgb", tb.git_branches, { desc = "Telescope: Project Git Branches" })

map("n", "<leader>pgc", function()
    if vim.bo.filetype == "oil" then
        tb.git_commits()
    else
        tb.git_bcommits()
    end
end, { desc = "Telescope: Project Git Commits" })

map("n", "<leader>pn", "<CMD>Telescope notify<CR>", { desc = "Telescope: Project Notifications" })
map("n", "<leader>pc", tb.colorscheme, { desc = "Telescope: Project Color Themes" })
map("n", "<leader>ph", tb.help_tags, { desc = "Telescope: Help Tags" })
map("n", "<leader>pk", tb.keymaps, { desc = "Telescope: Key Maps" })

map("n", "<leader>ps", function()
    tb.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Telescope: Project Search (Grep)" })

map("n", "<leader>pws", function()
    local word = vim.fn.expand("<cword>")
    tb.grep_string({ search = word })
end, { desc = "Telescope: Project Search under cursor" })

map("n", "<leader>pWs", function()
    local word = vim.fn.expand("<cWORD>")
    tb.grep_string({ search = word })
end, { desc = "Telescope: Project Search around cursor" })
