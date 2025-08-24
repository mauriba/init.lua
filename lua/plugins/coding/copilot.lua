-- TODO: Better autocomplete
return {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    config = function()
        require('copilot').setup({
            panel = {
                enabled = false,
            },
            suggestion = {
                enabled = false,
            },
            filetypes = {
                ["."] = false,
                ["*"] = true,
            },
            copilot_node_command = 'node', -- Node.js version must be > 18.x
            server_opts_overrides = {},
        })
    end,
}
