require("config.coding.folding").addCommentStyle("cisco", {
    line = "!"
})

vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.commentstring = '!%s'
