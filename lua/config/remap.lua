vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>tn", function ()
    local directory = require("oil").get_current_dir()
    local Terminal  = require('toggleterm.terminal').Terminal
    local term = Terminal:new({
        dir = directory
    })
    term:toggle()
end, {desc = "New terminal in current directory"})
