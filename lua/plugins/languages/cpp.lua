return {
	{
		"Badhi/nvim-treesitter-cpp-tools",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "cpp" },
		cmd = {
			"TSCppDefineClassFunc",
			"TSCppMakeConcreteClass",
			"TSCppRuleOf3",
			"TSCppRuleOf5",
		},
	},
}
