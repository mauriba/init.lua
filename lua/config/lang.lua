-- Use this file to add file extension -> language mappings
local langs = {
    -- Add your language mappings here
    -- ["language"] = "file_extensions",
    terraform = { "tf", "tfvars" },
    cisco = { "cisco" },
}

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local ext = vim.fn.expand("%:e")

        for lang, extensions in pairs(langs) do
            for _, extension in ipairs(extensions) do
                if ext == extension then
                    vim.bo.filetype = lang
                    return
                end
            end
        end
    end
})
