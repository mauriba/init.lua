require("config.coding.folding").addCommentStyle("terraform", {
    block = { open = "/*", close = "*/" },
    line = "#"
})
require("config.coding.lspconfig").start("terraformls", {})
require("conform").formatters_by_ft["terraform"] = { "terraform_fmt" }

vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
