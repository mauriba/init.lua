local function find_bounds(line, col, char)
    local left = nil
    for i = col, 1, -1 do
        if line:sub(i, i) == char then
            left = i
            break
        end
    end

    local right = nil
    for i = col + 1, #line do
        if line:sub(i, i) == char then
            right = i
            break
        end
    end

    if not left or not right or right - left <= 1 then
        return nil, nil
    end

    return left, right
end

local function select_inner_underscore()
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col(".")
    local left, right = find_bounds(line, col, "_")

    if not left then return end

    -- inner: skip underscores
    vim.fn.setpos("'<", { 0, vim.fn.line("."), left + 1 })
    vim.fn.setpos("'>", { 0, vim.fn.line("."), right - 1 })
    vim.cmd("normal! gv")
end

local function select_around_underscore()
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col(".")
    local left, right = find_bounds(line, col, "_")

    if not left then return end

    vim.fn.setpos("'<", { 0, vim.fn.line("."), left })
    vim.fn.setpos("'>", { 0, vim.fn.line("."), right })
    vim.cmd("normal! gv")
end

-- Map the textobjects
vim.keymap.set({ "o", "x" }, "i_", select_inner_underscore, { silent = true })
vim.keymap.set({ "o", "x" }, "a_", select_around_underscore, { silent = true })
