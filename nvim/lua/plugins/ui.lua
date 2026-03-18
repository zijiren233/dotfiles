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
				{ "<leader>g", group = "Git", mode = "n" },
				{ "<leader>q", group = "Session", mode = "n" },
				{ "<leader>s", group = "Search", mode = "n" },
				{ "<leader>x", group = "Diagnostics", mode = "n", icon = "󱍼 " },
			})
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				search = {
					enabled = true,
				},
			},
		},
		keys = {
			{
				"s",
				function()
					require("flash").jump()
				end,
				mode = { "n", "x", "o" },
				desc = "Flash",
			},
			{
				"S",
				function()
					require("flash").treesitter()
				end,
				mode = { "n", "x", "o" },
				desc = "Flash Treesitter",
			},
			{
				"r",
				function()
					require("flash").remote()
				end,
				mode = "o",
				desc = "Remote Flash",
			},
			{
				"R",
				function()
					require("flash").treesitter_search()
				end,
				mode = { "o", "x" },
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				function()
					require("flash").toggle()
				end,
				mode = "c",
				desc = "Toggle Flash Search",
			},
		},
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
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				function()
					require("trouble").toggle("diagnostics")
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>xX",
				function()
					require("trouble").toggle("diagnostics", { filter = { buf = 0 } })
				end,
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>xq",
				function()
					require("trouble").toggle("quickfix")
				end,
				desc = "Quickfix List",
			},
			{
				"<leader>xl",
				function()
					require("trouble").toggle("loclist")
				end,
				desc = "Location List",
			},
			{
				"gR",
				function()
					require("trouble").toggle("lsp_references")
				end,
				desc = "LSP References",
			},
		},
		opts = {},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			branch = true,
		},
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>qS",
				function()
					require("persistence").select()
				end,
				desc = "Select Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Stop Session Save",
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewFileHistory",
		},
		keys = {
			{
				"<leader>gd",
				"<cmd>DiffviewOpen<cr>",
				desc = "Git Diff View",
			},
			{
				"<leader>gh",
				"<cmd>DiffviewFileHistory %<cr>",
				desc = "File History",
			},
			{
				"<leader>gH",
				"<cmd>DiffviewFileHistory<cr>",
				desc = "Repo History",
			},
		},
		opts = {},
	},
}
