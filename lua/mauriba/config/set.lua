vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.tex_flavor = "latex"

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = false
vim.opt.numberwidth = 2 -- minimal number of columns to use for line number

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.cmdheight = 1 -- Set to 0 if using custom status line

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.cursorline = true
vim.opt.colorcolumn = "100"

-- Code folding
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.signcolumn = "yes"

-- Disable the freaking annoying Unneccessary->Comment link
-- that causes unused functions to be rendered like comments
vim.api.nvim_set_hl(0, "@lsp.type.unused", {})
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", {})
vim.api.nvim_set_hl(0, "LspDiagnosticsUnused", {})
