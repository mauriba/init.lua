require("config.coding.folding").addCommentStyle("cpp", {
    block = { open = "/*", close = "*/" },
    line = "//"
})
require("config.coding.lspconfig").start("clangd", {
     -- disable for no argument autocomplete: function-arg-placeholders
})

local dap = require("dap")
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    host = "127.0.0.1",
    executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
    },
}
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = false,
    },
}
