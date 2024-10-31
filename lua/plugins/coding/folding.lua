-- NOTE: Set folding configs similar to those: https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file

-- Keybinds:
-- zo: open fold under cursor
-- zO: open all folds under cursor recursively
-- zc: close fold under cursor
-- za: toggle fold under cursor
-- zR: open all folds
-- zM: close all folds

-- region test


-- endregion

-- Custom folds added to default treesitter ones
local function get_custom_folds(bufnr)
    local comment_folds = require('ufo').getFolds(bufnr, "treesitter") or {}
    local line_count = vim.api.nvim_buf_line_count(bufnr)

    -- Define custom comment styles for specific languages
    local comment_styles = {
        lua = { line = "--", block = { open = "--[[", close = "]]" } },
        python = { line = "#" },
        powershell = { line = "#", block = { open = "<#", close = "#>" } },
        css = { block = { open = "/*", close = "*/" } },
        html = { block = { open = "<!--", close = "-->" } },
        cpp = { line = "//", block = { open = "/*", close = "*/" } }
        -- Add more languages as needed
    }

    -- Detect current filetype and retrieve comment styles
    local comments = comment_styles[vim.bo.filetype] or { line = vim.bo.commentstring:match("^(.-)%s*%%s") }

    -- region custom_fold_block_detectors
    local function isCommentLine(line)
        return comments.line and line:match("^%s*" .. vim.pesc(comments.line))
    end
    local function isBlockStart(line)
        return comments.block and line:find("%s*" .. vim.pesc(comments.block.open))
    end
    local function isBlockEnd(line)
        return comments.block and line:find("%s*" .. vim.pesc(comments.block.close))
    end
    local function isSectionStart(line)
        return (comments.block and line:find("%s*" .. vim.pesc(comments.block.open) .. "%s*region"))
            or (comments.line and line:find("%s*" .. vim.pesc(comments.line) .. "%s*region"))
            or line:find("#pragma%s*region")
    end
    local function isSectionEnd(line)
        return (comments.block and line:find("%s*" .. vim.pesc(comments.block.open) .. "%s*endregion"))
            or (comments.line and line:find("%s*" .. vim.pesc(comments.line) .. "%s*endregion"))
            or line:find("#pragma%s*endregion")
    end
    -- endregion

    local function getLine(lineno)
        return vim.api.nvim_buf_get_lines(bufnr, lineno, lineno + 1, false)[1] or ""
    end
    local function addFold(startLine, endLine)
        table.insert(comment_folds, {startLine = startLine, endLine = endLine})
    end
    local function isInBuffer(lineno)
        return lineno < line_count
    end

    local iLine = 0
    while isInBuffer(iLine) do
        if isSectionStart(getLine(iLine)) then
            local comment_start = iLine
            repeat
                iLine = iLine + 1
            until isSectionEnd(getLine(iLine)) or not isInBuffer(iLine)
            if isInBuffer(iLine) then
                addFold(comment_start, iLine)
            else
                iLine = comment_start
            end
        end
        if isCommentLine(getLine(iLine)) then
            local comment_start = iLine
            repeat
                iLine = iLine + 1
            until not isCommentLine(getLine(iLine)) or not isInBuffer(iLine)
            if isInBuffer(iLine) and iLine - comment_start > 1 then
                addFold(comment_start, iLine - 1)
            else
                iLine = comment_start
            end
        end
        if isBlockStart(getLine(iLine)) then
            local comment_start = iLine
            repeat
                iLine = iLine + 1
            until isBlockEnd(getLine(iLine)) or not isInBuffer(iLine)
            if isInBuffer(iLine) then
                addFold(comment_start, iLine)
            else
                iLine = comment_start
            end
        end
        iLine = iLine + 1
    end

    return comment_folds
end

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
                return get_custom_folds
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
    -- Folding preview, by default h and l keys are used
    -- On first press of h key, when cursor is on a closed fold, the preview will be shown.
    -- On second press the preview will be closed and fold will be opened.
    -- When preview is opened, the l key will close it and open fold. In all other cases these keys will work as usual.
    -- { "anuvyklack/fold-preview.nvim", dependencies = "anuvyklack/keymap-amend.nvim", config = true },
}
