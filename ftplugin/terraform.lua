require("config.coding.folding").addCommentStyle("terraform", {
    block = { open = "/*", close = "*/" },
    line = "#"
})
require("plugins.coding.lsp").start("terraformls", {})

vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
