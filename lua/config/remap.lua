function string:ends_with(suffix)
    return self:sub(-#suffix) == suffix
end
function string:starts_with(prefix)
    return self:sub(0, #prefix) == prefix
end

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>tn", function ()
    local directory = require("oil").get_current_dir()
    local Terminal  = require('toggleterm.terminal').Terminal
    local term = Terminal:new({
    })
    term:toggle()
end, {desc = "New terminal in current directory"})

-- Change current directory to the current buffer's path
vim.keymap.set("n", "<leader>cd", function ()
    p = vim.fn.expand('%:p') 
    if p:starts_with("oil:///") then
        p = require("oil").get_current_dir() 
    elseif not p:ends_with("/") then
        p = p:match("(.*[/\\])")
    end
    vim.cmd("cd " .. p)
    print("New CWD: " .. p)
end)

-- Let Q also quit neovim
vim.api.nvim_create_user_command("Q", ":q", {})
