require("config.coding.folding").addCommentStyle("cpp", {
    block = { open = "/*", close = "*/" },
    line = "//"
})
require("config.coding.lspconfig").start("clangd", {
    -- disable for no argument autocomplete: function-arg-placeholders
    cmd = {
        "clangd",
        "--offset-encoding=utf-16",
    },
})

-- region Debugger
local dap = require("dap")

-- Use codelldb from VSCode's C/C++ extension on windows
if vim.fn.has("win32") == 1 then
    dap.adapters.codelldb = {
        id = 'cppdbg',
        type = 'executable',
        command = os.getenv("USERPROFILE") ..
            "\\.vscode\\extensions\\ms-vscode.cpptools-1.22.11-win32-x64\\debugAdapters\\bin\\OpenDebugAD7.exe",
        options = {
            detached = false
        },
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description = 'enable pretty printing',
                ignoreFailures = false
            },
        },
    }
else
    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        host = "127.0.0.1",
        executable = {
            command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
            args = { "--port", "${port}" },
        },
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description = 'enable pretty printing',
                ignoreFailures = false
            },
        },
    }
end

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        runInTerminal = false,
    },
}
-- endregion
