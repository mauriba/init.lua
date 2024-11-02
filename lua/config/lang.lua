-- config/lang.lua
--
-- Language-specific configurations

local generalSettingsGroup = vim.api.nvim_create_augroup('General settings', { clear = true })

-- region
vim.api.nvim_create_autocmd('FileType', {
    pattern = { "c", "cpp" },
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.shiftwidth = 2
    end,
    group = generalSettingsGroup,
})
-- endregion

-- region Terraform
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.tf", "*.tfvars" },
    callback = function ()
        vim.opt.filetype = "terraform"
    end
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "terraform", "terraformvars" },
    callback = function ()
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.shiftwidth = 2
    end
})
-- endregion
