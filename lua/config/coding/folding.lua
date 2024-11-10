local M = {}

M._comment_styles = {}
-- Use this function for adding comment styles
-- using ftplugin scripts
function M:addCommentStyle(arg1, arg2)
    if arg1 == nil then return end

    -- Filetype is specified by arg1 if function is called with two arguments,
    -- otherwise use the current buffer's filetype
    local filetype = arg2 and arg1 or vim.bo.filetype
    local style = arg1 and arg2 or arg1

    if not M._comment_styles[filetype] then
        M._comment_styles[filetype] = style
    end
end

function M:getCommentStyle(filetype)
    filetype = filetype or vim.bo.filetype
    return M._comment_styles[filetype] or {}
end

return M
