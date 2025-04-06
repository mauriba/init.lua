function string:ends_with(suffix)
    return self:sub(- #suffix) == suffix
end

function string:starts_with(prefix)
    return self:sub(0, #prefix) == prefix
end

vim.keymap.set("n", "<leader>gq", "gggqG", { desc = "Format whole document" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Change current directory to the current buffer's path
vim.keymap.set("n", "<leader>cd", function()
    local p = vim.fn.expand('%:p')
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
