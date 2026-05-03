vim.pack.add({
	{ src = "https://www.github.com/neovim/nvim-lspconfig" },
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/onsails/lspkind.nvim",
	"https://github.com/saghen/blink.lib",
	"https://github.com/rafamadriz/friendly-snippets",
	{
		src = "https://github.com/L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
	},
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
	"https://github.com/stevearc/conform.nvim",
	-- Debugging
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/mfussenegger/nvim-dap",
	--    "https://github.com/onsails/lspkind.nvim",
	-- "https://github.com/creativenull/efmls-configs-nvim",
	-- {
	-- 	src = "https://github.com/saghen/blink.cmp",
	-- 	version = vim.version.range("1.*"),
	-- },
	-- "https://github.com/L3MON4D3/LuaSnip",
})

-- Diagnostics
local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

-- Completion & snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-Space>"] = { "show", "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<C-y>"] = { "accept", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	-- See: https://cmp.saghen.dev/recipes.html#icons
	completion = {
		menu = {
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
							if ctx.source_name ~= "Path" then
								return require("lspkind").symbol_map[ctx.kind] or ("" .. ctx.icon_gap)
							end

							local is_unknown_type = vim.tbl_contains(
								{ "link", "socket", "fifo", "char", "block", "unknown" },
								ctx.item.data.type
							)
							local mini_icon, _ = require("mini.icons").get(
								is_unknown_type and "os" or ctx.item.data.type,
								is_unknown_type and "" or ctx.label
							)

							return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
						end,

						highlight = function(ctx)
							if ctx.source_name ~= "Path" then
								return ctx.kind_hl
							end

							local is_unknown_type = vim.tbl_contains(
								{ "link", "socket", "fifo", "char", "block", "unknown" },
								ctx.item.data.type
							)
							local mini_icon, mini_hl = require("mini.icons").get(
								is_unknown_type and "os" or ctx.item.data.type,
								is_unknown_type and "" or ctx.label
							)
							return mini_icon ~= nil and mini_hl or ctx.kind_hl
						end,
					},
				},
			},
		},
	},
	sources = {
		default = { "lsp", "path", "buffer", "snippets" },
	},
	snippets = {
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
	},

	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = { download = true },
	},
})

-- LSP
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"clangd",
		"lua_ls",
		"jsonls",
		"yamlls",
		"texlab",
	},
})

local lsp_group = vim.api.nvim_create_augroup("lsp", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	callback = function(ev)
		local ts = require("telescope.builtin")

		vim.keymap.set("n", "ga", function()
			vim.lsp.buf.code_action()
		end, { buffer = ev.buf, desc = "LSP Code Action" })
		vim.keymap.set("n", "gd", function()
			ts.lsp_definitions()
		end, { buffer = ev.buf, desc = "LSP Goto Definition" })
		vim.keymap.set("n", "gr", function()
			ts.lsp_references({ include_declaration = false })
		end, { buffer = ev.buf, desc = "LSP Goto References" })
		vim.keymap.set("n", "gi", function()
			ts.lsp_implementations()
		end, { buffer = ev.buf, desc = "LSP Goto Implementations" })
		vim.keymap.set("n", "gR", function()
			vim.lsp.buf.rename()
		end, { buffer = ev.buf, desc = "LSP Rename" })
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, { buffer = ev.buf, desc = "LSP Hover" })
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, { buffer = ev.buf, desc = "Open Diagnostics" })
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next()
		end, { buffer = ev.buf, desc = "Next Diagnostic" })
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev()
		end, { buffer = ev.buf, desc = "Previous Diagnostic" })
	end,
})

-- Formatting
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "gofmt" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		cpp = { "clang-format" },
		c = { "clang-format" },
		json = { "fixjson", "jq", stop_after_first = true }, -- For manual indentation, use ":%!jq --indent 2 ."
		tex = { "latexindent" },
	},
	-- Set default options
	default_format_opts = {
		lsp_format = "fallback",
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.keymap.set("n", "<leader>gq", function()
	require("conform").format({ async = true })
end, { desc = "Conform: Format buffer" })

-- Autosave toggle
_G.conform_autosave = true
vim.keymap.set("n", "<leader>fa", function()
	_G.conform_autosave = not _G.conform_autosave
	if _G.conform_autosave then
		print("Format on save: ON")
	else
		print("Format on save: OFF")
	end
end, { desc = "Toggle Conform auto-save formatting" })

-- Autosave functionality
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		if _G.conform_autosave then
			require("conform").format({
				timeout_ms = 4000,
				lsp_format = "fallback",
			})
		end
	end,
})

-- Debugging
local function init_debugging()
	local dap = require("dap")
	local dapui = require("dapui")
	require("nvim-dap-virtual-text").setup({})
	dapui.setup({})

	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end

	vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
	vim.keymap.set("n", "<leader>dr", dap.continue)
	vim.keymap.set("n", "<leader>dc", dap.run_to_cursor)
	vim.keymap.set("n", "<leader>dk", dap.step_back)

	-- Use VSCode's C/C++ extension on windows
	if vim.fn.has("win32") == 1 then
		-- Find debugger installed by VSCode's cpptools extension
		local base = os.getenv("USERPROFILE") .. "\\.vscode\\extensions"
		local matches = vim.fn.glob(base .. "\\ms-vscode.cpptools-*-win32-x64", 0, 1)

		local command = "vscode"
		if #matches > 0 then
			-- pick the latest version by sorting alphabetically
			table.sort(matches)
			local cpptools_dir = matches[#matches]
			command = cpptools_dir .. "\\debugAdapters\\bin\\OpenDebugAD7.exe"
		end

		dap.adapters.vscode = {
			id = "cppdbg",
			type = "executable",
			command = command,
			options = {
				detached = false,
			},
			setupCommands = {
				{
					text = "-enable-pretty-printing",
					description = "enable pretty printing",
					ignoreFailures = false,
				},
			},
		}
	end

	local codelldb = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"
	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			command = codelldb,
			args = { "--port", "${port}" },
		},
	}

	dap.configurations.cpp = {
		{
			name = "Launch VSCode's cpptools",
			type = "vscode",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = true,
			runInTerminal = false,
			MIMode = "lldb",
			miDebuggerPath = "lldb",
		},
		{
			name = "Launch codelldb",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			initCommands = {
				-- "settings set target.process.stop-on-sharedlibrary-loads false",
				-- "settings set target.process.stop-on-exec false",
			},
		},
	}
end
init_debugging()
