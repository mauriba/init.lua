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
    end
}
