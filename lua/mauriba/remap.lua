function string:ends_with(suffix)
	return self:sub(-#suffix) == suffix
end

function string:starts_with(prefix)
	return self:sub(0, #prefix) == prefix
end

local map = vim.keymap.set

map("n", "-", "<CMD>Oil<CR>")
map("n", "<leader>wl", function()
	vim.wo.wrap = not vim.wo.wrap
end)

-- Let capitals also quit
vim.api.nvim_create_user_command("Q", ":q", {})
vim.api.nvim_create_user_command("W", ":w", {})

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "=ap", "ma=ap'a")

map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

map({ "n", "v" }, "<leader>d", '"_d')
map("i", "<C-c>", "<Esc>")

-- Fugitive
map("n", "<leader>gc", "<cmd>silent G commit<cr>")
map("n", "<leader>g+", "<cmd>G push<cr>")
map("n", "<leader>g-", "<cmd>G pull --rebase<cr>")
map("n", "<leader>ga", "<cmd>silent G add -A<cr>")
map("n", "<leader>gC", "<cmd>silent G add -A | G commit<cr>")

-- Todo comments
map("n", "<leader>tdt", "<cmd>TodoTelescope<cr>")

-- Get current buffer's relative path
map("n", "<leader>%", function()
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

SetCWD()
vim.keymap.set("n", "<leader>cd", SetCWD)
