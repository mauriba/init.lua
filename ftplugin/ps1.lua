require("config.coding.folding").addCommentStyle("ps1", {
    block = { open = "<#", close = "#>" },
    line = "#"
})
require("config.coding.lspconfig").start("powershell_es", {
    settings = { powershell = { codeFormatting = { Preset = 'OTBS' } } },
    -- "pwsh" is the newer PowerShell and should be selected if available
    bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
    shell = pcall(vim.fn.cmd, "pwsh") and "pwsh" or "powershell"
})

vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.commentstring = '#%s'
