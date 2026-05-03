-- Install colorschemes
vim.pack.add({
	{ src = "https://github.com/raddari/last-color.nvim" },
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/EdenEast/nightfox.nvim" },
})

require("catppuccin").setup({
	transparent_background = false,
})

vim.opt.termguicolors = true

local function get_colorscheme()
	return require("last-color").recall() or "catppuccin"
end

local transparency_enabled = false
local last_theme = require("last-color").recall() or "catppuccin"

-- track any manual :colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function(args)
		last_theme = args.match

		-- Disable the freaking annoying Unneccessary->Comment link
		-- that causes unused functions to be rendered like comments
		vim.api.nvim_set_hl(0, "@lsp.type.unused", {})
		vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", {})
		vim.api.nvim_set_hl(0, "LspDiagnosticsUnused", {})
	end,
})

vim.cmd.colorscheme(last_theme)

-- transparency
local function set_transparent()
	local groups = {
		"Normal",
		"NormalNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"ColorColumn",
	}

	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end

	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

local function restore_theme()
	vim.cmd.colorscheme(last_theme)
end

local function toggle_transparency()
	transparency_enabled = not transparency_enabled

	if transparency_enabled then
		set_transparent()
	else
		restore_theme()
	end
end

vim.api.nvim_create_user_command("ToggleTransparency", toggle_transparency, {})
vim.keymap.set("n", "<leader>tb", toggle_transparency, { desc = "Toggle Transparency" })
