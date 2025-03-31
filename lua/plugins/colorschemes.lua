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

-- List of colorschemes
local colorschemes = {
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
                    cmp = true,
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
    }
}

-- Lazy load all themes but the default one
local default_theme = "rose-pine-moon"
for key, value in pairs(colorschemes) do
    if default_theme:sub(1, #value.name) == value.name then
        colorschemes[key].lazy = false
        colorschemes[key].priority = 1000
        local schemeConfig = colorschemes[key].config
        colorschemes[key].config = function()
            schemeConfig()
            vim.cmd.colorscheme(default_theme)
        end
    else
        colorschemes[key].lazy = "true"
    end
end

return colorschemes
