require("config.coding.folding").addCommentStyle("cpp", {
    block = { open = "/*", close = "*/" },
    line = "//"
})
require("config.coding.lspconfig").start("clangd", {
})
