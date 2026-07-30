-- Remove ugly default colorschemes from selection
vim.opt.wildignore:append({
    "blue.vim",
    "darkblue.vim",
    "delek.vim",
    "desert.vim",
    "elflord.vim",
    "evening.vim",
    "industry.vim",
    "koehler.vim",
    "lunaperche.vim",
    "morning.vim",
    "murphy.vim",
    "pablo.vim",
    "peachpuff.vim",
    "quiet.vim",
    "ron.vim",
    "shine.vim",
    "slate.vim",
    "sorbet.vim",
    "retrobox.vim",
    "torte.vim",
    "wildcharm.vim",
    "zaibatsu.vim",
    "zellner.vim",
})

-- Make the tabline and background transparent
function MakeTransparent()
    vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLineSelect", { bg = "none" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

vim.keymap.set("n", "<leader>tb", MakeTransparent, { desc = "Make background transparent" })

-- List of colorschemes
return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                background = {
                    light = "latte",
                    dark = "mocha"
                },
                transparent_background = false,
                default_integrations = true,
                integrations = {
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                }
            })
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = false,
                styles = {
                    italic = false,
                },
            })
        end
    },
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        opts = { style = "moon" },
    },
    {
        "rebelot/kanagawa.nvim",
    },
    { "EdenEast/nightfox.nvim" },
    {
        'raddari/last-color.nvim',
        config = function()
            local theme = require('last-color').recall() or 'rose-pine'
            vim.cmd.colorscheme(theme)
        end
    }
}
