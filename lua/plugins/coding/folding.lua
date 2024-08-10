-- NOTE: Set folding configs similar to those: https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file

-- Keybinds:
-- zo: open fold under cursor
-- zc: close fold under cursor
-- za: toggle fold under cursor
-- zR: open all folds
-- zM: close all folds

return {
    -- UFO folding
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require("statuscol.builtin")
                    require("statuscol").setup({
                        relculright = true,
                        segments = {
                            {
                                sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
                                click = "v:lua.ScSa"
                            },
                            { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
                            { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
                        }
                    })
                end,
            },
        },
        event = "BufReadPost",
        opts = {
            provider_selector = function()
                return { "treesitter", "indent" }
            end,
        },

        init = function()
            vim.keymap.set("n", "zR", function()
                require("ufo").openAllFolds()
            end)
            vim.keymap.set("n", "zM", function()
                require("ufo").closeAllFolds()
            end)
        end,
    },
    -- Folding preview, by default h and l keys are used.
    -- On first press of h key, when cursor is on a closed fold, the preview will be shown.
    -- On second press the preview will be closed and fold will be opened.
    -- When preview is opened, the l key will close it and open fold. In all other cases these keys will work as usual.
    -- { "anuvyklack/fold-preview.nvim", dependencies = "anuvyklack/keymap-amend.nvim", config = true },
}
