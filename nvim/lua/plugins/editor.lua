local telescope_keys = {
	{
		"<leader>ff",
		function()
			require("telescope.builtin").find_files()
		end,
		desc = "Find Files",
	},
	{
		"<leader>fg",
		function()
			require("telescope.builtin").git_files()
		end,
		desc = "Find Git Files",
	},
	{
		"<leader>fb",
		function()
			require("telescope.builtin").buffers()
		end,
		desc = "Find Buffers",
	},
	{
		"<leader>flg",
		function()
			require("telescope.builtin").live_grep()
		end,
		desc = "Live Grep",
	},
	{
		"<leader>fc",
		function()
			require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
		end,
		desc = "Grep String",
	},
}

return {
	{
		"tpope/vim-sleuth",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = function()
			return require("config.nvim-autopairs")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("config.nvim-treesitter")
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufReadPost", "BufNewFile" },
		submodules = false,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		version = "3.8.6",
		config = function()
			require("config.indent-blankline")
		end,
	},
	{
		"preservim/vim-markdown",
		ft = { "markdown" },
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = "Telescope",
		keys = telescope_keys,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1 and vim.fn.executable("cc") == 1
				end,
			},
		},
		config = function()
			local telescope = require("telescope")
			local has_fd = vim.fn.executable("fd") == 1
			telescope.setup({
				pickers = {
					find_files = has_fd and {
						find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
					} or {},
				},
			})

			pcall(telescope.load_extension, "fzf")
		end,
	},
	{
		"pteroctopus/faster.nvim",
		opts = {},
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			user_default_options = {
				names = false,
			},
		},
	},
}
