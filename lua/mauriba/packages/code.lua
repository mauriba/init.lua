vim.pack.add({
    "https://github.com/NMAC427/guess-indent.nvim"
})

-- indentation
require('guess-indent').setup({})

local function set_indent(size)
    vim.bo.expandtab = true
    vim.bo.tabstop = size
    vim.bo.shiftwidth = size
    vim.bo.softtabstop = size
end

vim.api.nvim_create_user_command("Indent", function(opts)
    local size = tonumber(opts.args)

    if not size or size <= 0 then
        print("Usage: :Indent <number>")
        return
    end

    set_indent(size)
    vim.cmd("normal! gg=G")
end, {
    nargs = 1,
})
