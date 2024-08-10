vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>tn", function ()
    local directory = require("oil").get_current_dir()
    local Terminal  = require('toggleterm.terminal').Terminal
    local term = Terminal:new({
    })
    dir = directory
    term:toggle()
end, {desc = "New terminal in current directory"})

-- Remaps for moving line around (:m) and properly intend it (=)
vim.keymap.set("n", "J", ":m +1<CR>==")
vim.keymap.set("n", "K", ":m -2<CR>==")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")
