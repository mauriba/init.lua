return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    keys = {
        {
            "az",
            "<cmd>lua require('ufo').foldScope('outer')<CR>",
            mode = { "o", "x" },
            desc = "text-obj: a-fold",
        },
        {
            "iz",
            "<cmd>lua require('ufo').foldScope('inner')<CR>",
            mode = { "o", "x" },
            desc = "text-obj: i-fold",
        },
    },
    config = function()
        -- thanks to https://www.reddit.com/r/neovim/comments/1e7rteu/create_textobject_az_and_iz_for_currentfoldscope/ 
        -- see https://github.com/kevinhwang91/nvim-ufo/blob/1b5f2838099f283857729e820cc05e2b19df7a2c/lua/ufo/main.lua#L134
        local getFoldScope = function()
            local bufnr = vim.api.nvim_get_current_buf()
            local foldRanges = require("ufo.fold").get(bufnr).foldRanges

            local lnum = vim.fn.line(".")
            local curStartLine, curEndLine = 0, 0
            for _, range in ipairs(foldRanges) do
                local sl, el = range.startLine, range.endLine
                if curStartLine < sl and sl < lnum and lnum <= el + 1 then
                    curStartLine, curEndLine = sl, el
                end
            end
            if curStartLine == 0 and curEndLine == 0 then
                return lnum, lnum
            end
            return curStartLine + 1, curEndLine + 1
        end

        -- see https://github.com/chrisgrieser/nvim-various-textobjs/blob/c2fd8bf4c86ec8d85bd0265074711027e640863a/lua/various-textobjs/linewise-textobjs.lua#L16
        local lineWiseSelect = function(startLine, endLine)
            -- save last position in jumplist like vim native textobj
            vim.cmd.normal({ "m`", bang = true })
            vim.api.nvim_win_set_cursor(0, { startLine, 0 })
            if not vim.fn.mode():find("V") then
                vim.cmd.normal({ "V", bang = true })
            end
            -- move cursor to end of visual
            vim.cmd.normal({ "o", bang = true })
            vim.api.nvim_win_set_cursor(0, { endLine, 0 })
        end

        local ufo = require("ufo")

        ufo.foldScope = function(scope)
            local sl, el = getFoldScope()
            vim.cmd(("silent! %d,%d foldopen"):format(sl, el))

            if scope == "inner" then
                local tailFt = { "python" }
                sl = vim.fn.min({ sl + 1, el })
                if not vim.tbl_contains(tailFt, vim.bo.ft) then
                    el = vim.fn.max({ el - 1, sl })
                end
            end

            lineWiseSelect(sl, el)
        end

        ufo.setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end,
        })
    end,
    -- Folding preview, by default h and l keys are used
    -- On first press of h key, when cursor is on a closed fold, the preview will be shown.
    -- On second press the preview will be closed and fold will be opened.
    -- When preview is opened, the l key will close it and open fold. In all other cases these keys will work as usual.
    -- { "anuvyklack/fold-preview.nvim", dependencies = "anuvyklack/keymap-amend.nvim", config = true },
}
