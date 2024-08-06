
-- config/lang.lua
--
-- Language-specific configurations

local generalSettingsGroup = vim.api.nvim_create_augroup('General settings', { clear = true })

-- C / C++
vim.api.nvim_create_autocmd('FileType', {
    pattern = { "c", "cpp" },
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.shiftwidth = 2
    end,
    group = generalSettingsGroup,
})