return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			defer = function(ctx)
				if vim.list_contains({ "d", "y" }, ctx.operator) then
					return true
				end
				return vim.list_contains({ "v", "<C-V>", "V" }, ctx.mode)
			end,
			preset = "helix",
			icons = {
				colors = true,
				keys = {},
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps",
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.add({
				{ "<leader>b", group = "Buffer", mode = "n", icon = " " },
				{ "<leader>l", group = "Lsp", mode = "n", icon = "󰿘 " },
				{ "<leader>f", group = "Find", mode = "n" },
				{ "<leader>s", group = "Search", mode = "n" },
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			return require("config.lualine")
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = function()
			return require("config.noice")
		end,
	},
}
