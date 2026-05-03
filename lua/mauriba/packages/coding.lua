vim.pack.add({
	"https://github.com/NMAC427/guess-indent.nvim",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/shellRaining/hlchunk.nvim",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

-- Mini coding helpers
require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})

-- Indentation
local function init_indentation()
	require("guess-indent").setup({})

	local function set_indent(size)
		vim.bo.expandtab = true
		vim.bo.tabstop = size
		vim.bo.shiftwidth = size
		vim.bo.softtabstop = size
	end

	vim.api.nvim_create_user_command("Indent", function(opts)
		local size = tonumber(opts.args)

		if not size or size <= 0 then
			print("Usage: :Indent <number>")
			return
		end

		set_indent(size)
		vim.cmd("normal! gg=G")
	end, {
		nargs = 1,
	})

	require("hlchunk").setup({
		chunk = {
			enable = true,
			textobject = "ic",
			delay = 200,
			duration = 100,
		},
		indent = {
			enable = true,
			delay = 200,
		},
	})
end

-- Treesitter
local function init_treesitter()
	local parsers = {
		"lua",
		"vim",
		"vimdoc",
		"query",
		"javascript",
		"typescript",
		"tsx",
		"html",
		"css",
		"json",
		"gitignore",
		"go",
		"cpp",
		"c",
		"python",
		"bash",
		"powershell",
		"vue",
		"rust",
	}

	local group = vim.api.nvim_create_augroup("mauribaTreesitter", { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
		group = group,
		callback = function()
			if vim.bo.buftype ~= "" then
				return
			end

			pcall(vim.treesitter.start, 0)
		end,
	})

	require("nvim-treesitter").install(parsers)
	require("nvim-treesitter-textobjects").setup({
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["il"] = "@loop.outer",
				["al"] = "@loop.inner",
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
			},
		},
	})
end

init_indentation()
init_treesitter()
