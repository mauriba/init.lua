local M = {}

M._comment_styles = {}
-- Use this function for adding comment styles
-- using ftplugin scripts
function M:addCommentStyle(style)
    filetype = vim.bo.filetype
    if filetype and not M._comment_styles[vim.bo.filetype] then
        M._comment_styles[vim.bo.filetype] = style
    end
end

function M:getCommentStyle()
    filetype = vim.bo.filetype
    return M._comment_styles[filetype] or {}
end

return M
