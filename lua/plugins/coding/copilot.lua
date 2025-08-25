return {
    {
        "zbirenbaum/copilot.lua",
        cmd = { "Copilot" },
        keys = {
            {
                "<leader>ct",
                "<cmd>Copilot toggle<CR>",
                desc = "Toggle Copilot",
                mode = "n",
            },
        },
        config = function()
            require('copilot').setup({
                panel = {
                    enabled = false,
                },
                suggestion = {
                    enabled = false,
                    auto_trigger = false
                },
                filetypes = {
                    ["."] = false,
                    ["*"] = true,
                },
                copilot_node_command = 'node', -- Node.js version must be > 18.x
                server_opts_overrides = {},
            })
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        cmd = { "CopilotChat" },
        build = "make tiktoken",
        opts = {
            -- See Configuration section for options
        },
        keys = {
            { "<leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "Toggle CopilotChat" },
        },
    }
}
