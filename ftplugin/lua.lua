require("config.coding.folding").addCommentStyle("lua", {
    block = { open = "--[[", close = "--]]" },
    line = "--"
})
require("plugins.coding.lsp").start("lua_ls", {})
