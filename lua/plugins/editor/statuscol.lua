return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            relculright = true,
            ft_ignore = { "oil", },
            segments = {
                {
                    sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
                    click = "v:lua.ScSa"
                },
                { text = { builtin.lnumfunc },      click = "v:lua.ScLa", },
                { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
            }
        })
    end,
}
