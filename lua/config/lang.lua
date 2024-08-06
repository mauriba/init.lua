local generalSettingsGroup = vim.api.nvim_create_augroup('General settings', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
    pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
    callback = function()
        print("autocmd")
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.shiftwidth = 2
    end,
    group = generalSettingsGroup,
})
