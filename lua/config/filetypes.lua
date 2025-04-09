vim.filetype.add({
    extension = {
        tf = "terraform",
        tfvars = "terraform",
    }
})

vim.api.nvim_create_autocmd("Filetype", {
    callback = function ()
        if (vim.bo.filetype == "terraform") then
            vim.bo.commentstring = "# %s"
            Indent(2)
        end
    end
})
