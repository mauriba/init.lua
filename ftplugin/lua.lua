require("config.coding.folding").addCommentStyle("lua", {
    block = { open = "--[[", close = "--]]" },
    line = "--"
})
require("config.coding.lspconfig").start("lua_ls", {})
