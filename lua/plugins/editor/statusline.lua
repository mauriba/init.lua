return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "echasnovski/mini.icons" },
    event = "VeryLazy",
    config = function()
        require("lualine").setup({
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff" },
                lualine_c = { function()
                    return vim.fn.expand("%:.")
                end },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { {
                    function()
                        local starts = vim.fn.line("v")
                        local ends = vim.fn.line(".")

                        local nChars = vim.fn.wordcount().visual_chars
                        local nWords = vim.fn.wordcount().visual_words
                        local nLines = starts <= ends and ends - starts + 1 or starts - ends + 1

                        return nChars .. "C " .. nWords .. "W " .. nLines .. "L"
                    end,
                    cond = function()
                        return vim.fn.mode():find("[Vv]") ~= nil
                    end,
                } },
                lualine_z = {
                    "location",
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { function()
                    return vim.fn.expand("%:.")
                end },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            }
        })
    end
}
