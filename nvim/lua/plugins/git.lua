return {
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gread", "Ggrep", "Gclog" },
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>gb",
				function()
					require("gitsigns").blame_line({ full = true })
				end,
				desc = "Git blame line",
			},
			{
				"<leader>gB",
				function()
					require("gitsigns").blame()
				end,
				desc = "Git blame buffer",
			},
			{
				"<leader>gtb",
				function()
					require("gitsigns").toggle_current_line_blame()
				end,
				desc = "Toggle current-line blame",
			},
		},
		opts = function()
			return require("config.gitsigns")
		end,
	},
}
