require("config.coding.folding").addCommentStyle("cmake", {
    block = { open = "#[[", close = "]]" },
    line = "#"
})
require("config.coding.lspconfig").start("neocmake", {
    init_options = {
        format = {
            enable = true
        },
        lint = {
            enable = true
        },
        scan_cmake_in_package = true -- default is true
    }
})
