return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			notify_on_error = true,
			format_on_save = function(bufnr)
				local disable_filetypes = {
					c = true,
					cpp = true,
				}

				return {
					timeout_ms = 1000,
					lsp_format = disable_filetypes[vim.bo[bufnr].filetype] and "never" or "fallback",
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				go = { "gofmt" },
				rust = { "rustfmt" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufWritePost", "InsertLeave" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				sh = { "shellcheck" },
				bash = { "shellcheck" },
			}

			local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = group,
				callback = function()
					local names = lint._resolve_linter_by_ft(vim.bo.filetype)
					if #names == 0 then
						return
					end

					local available = {}
					for _, name in ipairs(names) do
						local linter = lint.linters[name]
						if linter and linter.cmd and vim.fn.executable(linter.cmd) == 1 then
							table.insert(available, name)
						end
					end

					if #available > 0 then
						lint.try_lint(available)
					end
				end,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				"shellcheck",
			},
			auto_update = false,
			run_on_start = true,
		},
	},
}
