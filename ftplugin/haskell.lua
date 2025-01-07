require("config.coding.folding").addCommentStyle("haskell", {
    block = { open = "{-", close = "-}" },
    line = "--"
})
require("config.coding.lspconfig").start("hls", {
    filetypes = { 'haskell', 'lhaskell', 'cabal' }
})

vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.commentstring = '--%s'
