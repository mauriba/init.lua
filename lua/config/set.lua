vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = false

function Indent(spaces)
    vim.opt.tabstop = spaces
    vim.opt.softtabstop = spaces
    vim.opt.shiftwidth = spaces
    vim.opt.expandtab = true
end

vim.api.nvim_create_user_command("Indent", function(call)
    vim.notify("Indent set to " .. call.args, vim.log.levels.INFO, { title = "Indent" })
    Indent(tonumber(call.args))
end, { nargs = 1 })
Indent(4) -- Default indentation: 4 spaces

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.cmdheight = 0 -- Set to 0 if using custom status line

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

-- Code folding
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.signcolumn = "yes"

-- Disable the freaking annoying Unneccessary->Comment link
-- that causes unused functions to be rendered like comments
vim.api.nvim_set_hl(0, "LspUnused", { link = nil })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = nil })
