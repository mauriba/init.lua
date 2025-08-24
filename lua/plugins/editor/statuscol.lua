return {
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    dependencies = {
        {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("gitsigns").setup({
                    attach_to_untracked = true,
                })
            end
        }
    },
    config = function()
        local builtin = require("statuscol.builtin")

        function DiagnosticOrDapClickHandler(minwid, clicks, button, mods)
            local lnum = vim.fn.getmousepos().line
            local bufnr = vim.api.nvim_get_current_buf()

            local diags = vim.diagnostic.get(bufnr, { lnum = lnum - 1 })
            if #diags > 0 then
                -- Show diagnostics float (scheduled to avoid instant
                -- close due to internal mouse movement)
                vim.schedule(function()
                    vim.diagnostic.open_float(bufnr, {
                        lnum = lnum - 1,
                        scope = "line",
                    })
                end)
            else
                require("dap").toggle_breakpoint()
            end
        end

        require("statuscol").setup({
            relculright = true,
            ft_ignore = { "oil", },
            segments = {
                {
                    sign = { name = { ".*" }, text = { ".*" } },
                    maxwidth = 2,
                    colwidth = 1,
                    wrap = false,
                    auto = true,
                    click = "v:lua.DiagnosticOrDapClickHandler",
                },
                {
                    text = { builtin.lnumfunc },
                    auto = true,
                    click = "v:lua.ScLa",
                },
                {
                    sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1, auto = false },
                    auto = true,
                    click = "v:lua.ScSa",
                },
                { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
            },
        })
    end,
}
