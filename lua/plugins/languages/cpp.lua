return {
	{
		"Badhi/nvim-treesitter-cpp-tools",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "cpp" },
		cmd = {
			"TSCppDefineClassFunc",
			"TSCppMakeConcreteClass",
			"TSCppRuleOf3",
			"TSCppRuleOf5",
		},
		config = function()
			require("nt-cpp-tools").setup({
				header_extension = "hpp",
				source_extension = "cpp",
				preview = {
					quit = "<esc>", -- optional keymapping for quit preview
					accept = "<C-y>", -- optional keymapping for accept preview
				},
			})
		end
	},
}
