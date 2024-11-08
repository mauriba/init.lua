-- NOTE: Set folding configs similar to those: https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file

-- Keybinds:
-- zo: open fold under cursor
-- zO: open all folds under cursor recursively
-- zc: close fold under cursor
-- za: toggle fold under cursor
-- zR: open all folds
-- zM: close all folds

-- Helper function for custom fold generators
local function getLine(bufnr, lineno)
    return vim.api.nvim_buf_get_lines(bufnr, lineno, lineno + 1, false)[1] or ""
end

-- Fold generator for blocks of comments
local function get_comment_folds(bufnr)
    local comment_folds = {}
    local line_count = vim.api.nvim_buf_line_count(bufnr)

    local comments = require("config.coding.folding").getCommentStyle()
    comments.line = comments.line or vim.bo.commentstring:match("^(.-)%s*%%s")

    -- region comment detection
    local function isCommentLine(line)
        return comments.line and line:match("^%s*" .. vim.pesc(comments.line))
    end
    local function isBlockStart(line)
        return comments.block and line:find("%s*" .. vim.pesc(comments.block.open))
    end
    local function isBlockEnd(line)
        return comments.block and line:find("%s*" .. vim.pesc(comments.block.close))
    end
    -- endregion
    
    local iLine = 0
    while iLine < line_count do
        if isBlockStart(getLine(bufnr, iLine)) then
            local comment_start = iLine
            repeat
               iLine = iLine + 1
            until isBlockEnd(getLine(bufnr, iLine)) or not (iLine < line_count)
            if iLine < line_count then
                table.insert(comment_folds, { startLine = comment_start, endLine = iLine })
            else
                iLine = comment_start
            end
        end

        if isCommentLine(getLine(bufnr, iLine)) then
            local comment_start = iLine
            repeat
               iLine = iLine + 1
            until not isCommentLine(getLine(bufnr, iLine)) or not (iLine < line_count)
            if iLine < line_count then
                table.insert(comment_folds, { startLine = comment_start, endLine = iLine - 1 })
            else
                iLine = comment_start
            end
        end

        iLine = iLine + 1
    end

    return comment_folds
end

-- Fold generator for regions
local function get_region_folds(bufnr)
    local region_folds = {}
    local line_count = vim.api.nvim_buf_line_count(bufnr)

    local comments = require("config.coding.folding").getCommentStyle()
    comments.line = comments.line or vim.bo.commentstring:match("^(.-)%s*%%s")

    local function isRegionStart(line)
        return (comments.block and line:find("%s*" .. vim.pesc(comments.block.open) .. "%s*region"))
            or (comments.line and line:find("%s*" .. vim.pesc(comments.line) .. "%s*region"))
            or line:find("#pragma%s*region")
    end
    local function isRegionEnd(line)
        return (comments.block and line:find("%s*" .. vim.pesc(comments.block.open) .. "%s*endregion"))
            or (comments.line and line:find("%s*" .. vim.pesc(comments.line) .. "%s*endregion"))
            or line:find("#pragma%s*endregion")
    end

    local iLine = 0
    while iLine < line_count do
        if isRegionStart(getLine(bufnr, iLine)) then
            local region_start = iLine
            repeat
               iLine = iLine + 1
            until isRegionEnd(getLine(bufnr, iLine)) or not (iLine < line_count)
            if iLine < line_count then
                table.insert(region_folds, { startLine = region_start, endLine = iLine })
            else
                iLine = comment_start
            end
        end
        iLine = iLine + 1
    end

    return region_folds
end

-- Merges custom folds for comment blocks and regions
-- with treesitter folds. This function is passed to UFO for execution.
local function get_custom_folds(bufnr)
    local folds = require('ufo').getFolds(bufnr, "treesitter") or {}
    local region_folds = get_region_folds(bufnr)
    local comment_folds = get_comment_folds(bufnr)
    for _, fold in ipairs(region_folds) do
        table.insert(folds, fold)
    end
    for _, fold in ipairs(comment_folds) do
        table.insert(folds, fold)
    end
    return folds
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
