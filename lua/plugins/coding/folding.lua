-- NOTE: Set folding configs similar to those: https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file

-- Keybinds:
-- zo: open fold under cursor
-- zc: close fold under cursor
-- za: toggle fold under cursor
-- zR: open all folds
-- zM: close all folds

-- Custom folds added to default treesitter ones
local function get_region_folds(bufnr)
    local region_folds = {}
    local line_count = vim.api.nvim_buf_line_count(bufnr)
    local is_in_region = false
    local region_start = 0

    local function isRegionStart(line)
        return line:match('^%s*' .. vim.o.commentstring:sub(1, 1) .. '+%s*region') or line:match('%s*#pragma%s*region') 
    end
    local function isRegionEnd(line)
        return line:match('^%s*' .. vim.o.commentstring:sub(1, 1) .. '+%s*endregion') or line:match('%s*#pragma%s*endregion') 
    end

    for i = 0, line_count - 1 do
        local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1]
        if not is_in_region and isRegionStart(line) then
            is_in_region = true
            region_start = i
        elseif is_in_region and isRegionEnd(line) then
            is_in_region = false
            table.insert(region_folds, {startLine = region_start, endLine = i})
        end
    end

    if is_in_region then
        table.insert(region_folds, {startLine = region_start, endLine = line_count - 1})
    end

    return region_folds
end

local function get_comment_folds(bufnr)
    local comment_folds = {}
    local line_count = vim.api.nvim_buf_line_count(bufnr)
    local is_in_comment = false
    local comment_start = 0

    local function isCommentLine(line)
        return line:match('^%s*' .. vim.o.commentstring:sub(1, 1))
    end

    for i = 0, line_count - 1 do
        local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1]
        if not is_in_comment and isCommentLine(line) then
            is_in_comment = true
            comment_start = i
        elseif is_in_comment and not isCommentLine(line) then
            is_in_comment = false
            table.insert(comment_folds, {startLine = comment_start, endLine = i - 1})
        end
    end

    if is_in_comment then
        table.insert(comment_folds, {startLine = comment_start, endLine = line_count - 1})
    end

    return comment_folds
end


local function custom_folding(bufnr)
    local region_folds = get_region_folds(bufnr)
    local comment_folds = get_comment_folds(bufnr)
    local treesitter_folds = require('ufo').getFolds(bufnr, "treesitter")
    if treesitter_folds == nil then treesitter_folds = {} end
    for _, fold in ipairs(region_folds) do
        table.insert(treesitter_folds, fold)
    end
    for _, fold in ipairs(comment_folds) do
        table.insert(treesitter_folds, fold)
    end
    return treesitter_folds
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
                return custom_folding
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
