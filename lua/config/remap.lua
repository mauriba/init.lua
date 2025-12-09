function string:ends_with(suffix)
	return self:sub(- #suffix) == suffix
end

function string:starts_with(prefix)
	return self:sub(0, #prefix) == prefix
end

-- Add window focus movements for terminal mode
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left window" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to below window" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to above window" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right window" })

-- Move lines around
vim.api.nvim_set_keymap("v", "<C-J>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move line down" })
vim.api.nvim_set_keymap("v", "<C-K>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move line up" })
vim.api.nvim_set_keymap("v", "<C-H>", "<gv", { noremap = true, silent = true, desc = "Move line left" })
vim.api.nvim_set_keymap("v", "<C-L>", ">gv", { noremap = true, silent = true, desc = "Move line right" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Change current directory to the current buffer's path
function SetCWD()
	local p = vim.fn.expand("%:p")
	if p == nil or p == "" then
		return
	end

	if p:starts_with("oil:///") then
		p = require("oil").get_current_dir()
	elseif not p:ends_with("/") then
		p = p:match("(.*[/\\])")
	end
	vim.cmd("cd " .. p)
	print("New CWD: " .. p)
end

-- Automatically set cwd on startup
SetCWD()

vim.keymap.set("n", "<leader>cd", SetCWD)

-- Let Q also quit neovim
vim.api.nvim_create_user_command("Q", ":q", {})
-- Let W also write file
vim.api.nvim_create_user_command("W", ":w", {})

-- QuickFix navigation
vim.keymap.set(
	"n",
	"<leader>qj",
	"<Cmd>try | cnext | catch | cfirst | catch | endtry<CR>",
	{ desc = "Next QuickFix Item" }
)
vim.keymap.set(
	"n",
	"<leader>qk",
	"<Cmd>try | cprevious | catch | clast | catch | endtry<CR>",
	{ desc = "Previous QuickFix Item" }
)
vim.keymap.set("n", "<leader>qh", "<Cmd>try | colder | catch | endtry<CR>", { desc = "Previous QuickFix List" })
vim.keymap.set("n", "<leader>ql", "<Cmd>try | cnewer | catch | endtry<CR>", { desc = "Next QuickFix list" })

-- Big steps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- Quick diffing
-- Remember: ]c / [c for next/previous conflict
vim.keymap.set("n", "<c", "<cmd>diffget<CR>", { desc = "Get diff from other buffer" })
vim.keymap.set("n", ">c", "<cmd>diffput<CR>", { desc = "Put diff into other buffer" })

-- Get current buffer's relative path
vim.keymap.set("n", "<leader>%", function()
	local rel_path = ""
	if vim.bo.filetype == "oil" then
		local oil = require("oil")
		local dir = oil.get_current_dir()
		local entry = oil.get_cursor_entry().name

		rel_path = vim.fn.fnamemodify(dir .. entry, ":.")
	else
		rel_path = vim.fn.expand("%:.")
	end

	vim.fn.setreg("+", rel_path)
	vim.fn.setreg('"', rel_path)
end, { desc = "Copy relative file path" })
