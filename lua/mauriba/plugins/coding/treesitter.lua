return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local default_parsers = {
            "javascript", "html", "css", "lua",
            "python", "cpp", "c", "yaml", "json",
            "vim", "vimdoc", "markdown", "bash", "powershell",
            "query", "gitignore",
        }

        local group = vim.api.nvim_create_augroup("MyTreesitter", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
            group = group,
            callback = function()
                if vim.bo.buftype ~= "" then
                    return
                end

                pcall(vim.treesitter.start, 0)
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            group = group,
            pattern = "VeryLazy",
            once = true,
            callback = function()
                require("nvim-treesitter").install(default_parsers)
            end,
        })

        -- From https://github.com/av223119/config-snippets/blob/main/nvim/plugin/nvim-treesitter.lua
        local ts = require "nvim-treesitter"
        local tsc = require "nvim-treesitter.config"
        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            desc = "Enable treesitter",
            callback = function(event)
                local lang = vim.treesitter.language.get_lang(event.match)
                local buf = event.buf
                local i = 0
                if not lang or vim.tbl_contains(tsc.get_installed(), lang) or not vim.tbl_contains(ts.get_available(), lang) then
                    return
                end

                local timer = vim.uv.new_timer()
                if not timer then
                    return
                end
                ts.install { lang }
                timer:start(0, 1000, vim.schedule_wrap(function()
                    i = i + 1
                    if i > 60 or not vim.api.nvim_buf_is_valid(buf) then
                        timer:close()
                        return
                    end
                    if vim.list_contains(ts.get_installed(), vim.treesitter.language.get_lang(lang)) then
                        timer:close()
                        vim.treesitter.start(buf)
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                        vim.wo.foldmethod = "expr"
                        vim.wo.foldlevel = 99
                    end
                end))
            end,
        })
    end
}
