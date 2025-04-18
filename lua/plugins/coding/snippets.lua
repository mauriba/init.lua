return {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    -- follow latest release.
    version = "v2.*",     -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    -- build = "make install_jsregexp",

    dependencies = { "rafamadriz/friendly-snippets" },

    config = function()
        local ls = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").load({
            paths = vim.fn.stdpath("config") .. "/snippets",
        })

        ls.filetype_extend("javascript", { "jsdoc" })
        vim.keymap.set({ "i" }, "<C-e>", function() ls.expand() end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(-1) end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<C-E>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, { silent = true })
    end,
}
