-- Use this file to add language types for ftplugin

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.tf", "*.tfvars" },
    callback = function ()
        vim.opt.filetype = "terraform"
    end
})
