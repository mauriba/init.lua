return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
    },
    keys = {
        { "<leader>db", nil, desc = "DAP Toggle Breakpoint" },
        { "<leader>dr", nil, desc = "DAP Continue" },
        { "<leader>dc", nil, desc = "DAP Run to Cursor" },
        { "<leader>dk", nil, desc = "DAP Step Back" },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        require("nvim-dap-virtual-text").setup({})
        dapui.setup({})

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>dr", dap.continue)
        vim.keymap.set("n", "<leader>dc", dap.run_to_cursor)
        vim.keymap.set("n", "<leader>dk", dap.step_back)

        -- Use VSCode's C/C++ extension on windows
        if vim.fn.has("win32") == 1 then
            -- Find debugger installed by VSCode's cpptools extension
            local base = os.getenv("USERPROFILE") .. "\\.vscode\\extensions"
            local matches = vim.fn.glob(base .. "\\ms-vscode.cpptools-*-win32-x64", 0, 1)

            local command = "vscode"
            if #matches > 0 then
                -- pick the latest version by sorting alphabetically
                table.sort(matches)
                local cpptools_dir = matches[#matches]
                command = cpptools_dir .. "\\debugAdapters\\bin\\OpenDebugAD7.exe"
            end

            dap.adapters.vscode = {
                id = 'cppdbg',
                type = 'executable',
                command = command,
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
        end


        local codelldb = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"
        dap.adapters.codelldb = {
            type = 'server',
            port = '${port}',
            executable = {
                command = codelldb,
                args = { '--port', '${port}' },
            },
        }

        dap.configurations.cpp = {
            {
                name = "Launch VSCode's cpptools",
                type = "vscode",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = true,
                runInTerminal = false,
                MIMode = "lldb",
                miDebuggerPath = "lldb"
            },
            {
                name = "Launch codelldb",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                initCommands = {
                    -- "settings set target.process.stop-on-sharedlibrary-loads false",
                    -- "settings set target.process.stop-on-exec false",
                },
            },
        }
    end
}
