-- Default packages
vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	-- "https://github.com/rachartier/tiny-cmdline.nvim",
	"https://github.com/luukvbaal/statuscol.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/kevinhwang91/promise-async",
	"https://github.com/kevinhwang91/nvim-ufo",
})

-- file editor
require("oil").setup({
	default_file_explorer = true,
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 3000,
		autosave_changes = false,
	},
	view_options = {
		show_hidden = false,
	},
	watch_for_changes = true,
})

-- Todo comments
require("todo-comments").setup({
	keywords = {
		FIX = {
			icon = " ", -- icon used for the sign, and in search results
			color = "error", -- can be a hex color, or a named color (see below)
			alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
			-- signs = false, -- configure signs for some keywords individually
		},
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
	},
})

-- Statuscol
-- BUG: Currently causing leading tab in command line
-- on first use
local function init_statuscol()
	require("gitsigns").setup({
		-- signs = {
		-- 	add = { text = "\u{2590}" }, -- ▏
		-- 	change = { text = "\u{2590}" }, -- ▐
		-- 	delete = { text = "\u{2590}" }, -- ◦
		-- 	topdelete = { text = "\u{25e6}" }, -- ◦
		-- 	changedelete = { text = "\u{25cf}" }, -- ●
		-- 	untracked = { text = "\u{25cb}" }, -- ○
		-- },
		signcolumn = true,
		current_line_blame = false,
		attach_to_untracked = true,
	})

	local builtin = require("statuscol.builtin")

	function DiagnosticOrDapClickHandler(minwid, clicks, button, mods)
		local lnum = vim.fn.getmousepos().line
		local bufnr = vim.api.nvim_get_current_buf()

		local diags = vim.diagnostic.get(bufnr, { lnum = lnum - 1 })
		if #diags > 0 then
			-- Show diagnostics float (scheduled to avoid instant
			-- close due to internal mouse movement)
			vim.schedule(function()
				vim.diagnostic.open_float(bufnr, {
					lnum = lnum - 1,
					scope = "line",
				})
			end)
		else
			require("dap").toggle_breakpoint()
		end
	end

	require("statuscol").setup({
		relculright = true,
		ft_ignore = { "oil" },
		segments = {
			{
				sign = { name = { ".*" }, text = { ".*" } },
				maxwidth = 2,
				colwidth = 1,
				wrap = false,
				auto = true,
				click = "v:lua.DiagnosticOrDapClickHandler",
			},
			{
				text = { builtin.lnumfunc },
				auto = true,
				click = "v:lua.ScLa",
			},
			{
				sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1, auto = false },
				auto = true,
				click = "v:lua.ScSa",
			},
			{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
		},
	})
end
init_statuscol()

-- Colors
require("nvim-highlight-colors").setup({
	render = "virtual",
})

-- Folding
local function init_folding()
	local get_qf_folds = function(bufnr)
		bufnr = bufnr or vim.api.nvim_get_current_buf()
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local folds = {}

		local last_file = nil
		local start = nil

		for i, line in ipairs(lines) do
			-- Grab filename: everything before first '|' or first ':'
			local filename = line:match("^(.-)[|:]")
			if filename then
				if filename ~= last_file then
					-- close previous fold
					if last_file and start then
						table.insert(folds, { startLine = start - 1, endLine = i - 2 }) -- 0-indexed
					end
					start = i
					last_file = filename
				end
			end
		end

		-- close last fold
		if last_file and start then
			table.insert(folds, { startLine = start - 1, endLine = #lines - 1 })
		end

		return folds
	end

	-- thanks to https://www.reddit.com/r/neovim/comments/1e7rteu/create_textobject_az_and_iz_for_currentfoldscope/
	-- see https://github.com/kevinhwang91/nvim-ufo/blob/1b5f2838099f283857729e820cc05e2b19df7a2c/lua/ufo/main.lua#L134
	local getFoldScope = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local foldRanges = require("ufo.fold").get(bufnr).foldRanges

		local lnum = vim.fn.line(".")
		local curStartLine, curEndLine = 0, 0
		for _, range in ipairs(foldRanges) do
			local sl, el = range.startLine, range.endLine
			if curStartLine < sl and sl < lnum and lnum <= el + 1 then
				curStartLine, curEndLine = sl, el
			end
		end
		if curStartLine == 0 and curEndLine == 0 then
			return lnum, lnum
		end
		return curStartLine + 1, curEndLine + 1
	end

	-- see https://github.com/chrisgrieser/nvim-various-textobjs/blob/c2fd8bf4c86ec8d85bd0265074711027e640863a/lua/various-textobjs/linewise-textobjs.lua#L16
	local lineWiseSelect = function(startLine, endLine)
		-- save last position in jumplist like vim native textobj
		vim.cmd.normal({ "m`", bang = true })
		vim.api.nvim_win_set_cursor(0, { startLine, 0 })
		if not vim.fn.mode():find("V") then
			vim.cmd.normal({ "V", bang = true })
		end
		-- move cursor to end of visual
		vim.cmd.normal({ "o", bang = true })
		vim.api.nvim_win_set_cursor(0, { endLine, 0 })
	end

	local ufo = require("ufo")

	ufo.foldScope = function(scope)
		local sl, el = getFoldScope()
		vim.cmd(("silent! %d,%d foldopen"):format(sl, el))

		if scope == "inner" then
			local tailFt = { "python" }
			sl = vim.fn.min({ sl + 1, el })
			if not vim.tbl_contains(tailFt, vim.bo.ft) then
				el = vim.fn.max({ el - 1, sl })
			end
		end

		lineWiseSelect(sl, el)
	end

	ufo.setup({
		provider_selector = function(bufnr, filetype, buftype)
			if filetype == "qf" then
				return get_qf_folds
			else
				return { "treesitter", "indent" }
			end
		end,
	})

	-- Keybinds
	vim.keymap.set({ "o", "x" }, "az", function()
		ufo.foldScope("outer")
	end, { desc = "text-obj: a-fold" })

	vim.keymap.set({ "o", "x" }, "iz", function()
		ufo.foldScope("inner")
	end, { desc = "text-obj: i-fold" })
end
init_folding()

-- Statusline
local function init_statusline()
	require("lualine").setup({
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = { "filename" },
			-- {
			-- 	function()
			-- 		return vim.fn.expand("%:.")
			-- 	end,
			-- },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = {
				{
					function()
						local starts = vim.fn.line("v")
						local ends = vim.fn.line(".")

						local nChars = vim.fn.wordcount().visual_chars
						local nWords = vim.fn.wordcount().visual_words
						local nLines = starts <= ends and ends - starts + 1 or starts - ends + 1

						return nChars .. "C " .. nWords .. "W " .. nLines .. "L"
					end,
					cond = function()
						return vim.fn.mode():find("[Vv]") ~= nil
					end,
				},
			},
			lualine_z = {
				"location",
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				function()
					return vim.fn.expand("%:.")
				end,
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		extensions = { "quickfix", "oil" },
	})
end
init_statusline()
