local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = has_cmp_nvim_lsp and cmp_nvim_lsp.default_capabilities() or nil

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

	if client.name == "rust_analyzer" then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		local ok, conform = pcall(require, "conform")
		if ok then
			conform.format({
				async = true,
				lsp_format = "fallback",
			})
			return
		end

		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

local function configure(server, config)
	local base = vim.lsp.config[server] or {}
	local base_on_attach = base.on_attach
	local user_on_attach = config.on_attach
	local merged = vim.tbl_deep_extend("force", base, config)

	if capabilities then
		merged.capabilities = vim.tbl_deep_extend("force", {}, base.capabilities or {}, config.capabilities or {}, capabilities)
	end

	if base_on_attach or user_on_attach then
		merged.on_attach = function(client, bufnr)
			if base_on_attach then
				base_on_attach(client, bufnr)
			end

			if user_on_attach then
				user_on_attach(client, bufnr)
			end
		end
	end

	vim.lsp.config(server, merged)
end

configure("pylsp", {
	on_attach = on_attach,
	settings = {
		pylsp = {
			plugins = {
				pyflakes = { enabled = false },
				pylint = { enabled = false },
				pycodestyle = { enabled = false },
			},
		},
	},
})

configure("gopls", {
	on_attach = on_attach,
})

configure("lua_ls", {
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

configure("bashls", {})

configure("rust_analyzer", {
	on_attach = on_attach,
})

configure("clangd", {
	on_attach = on_attach,
})

configure("ocamllsp", {
	on_attach = on_attach,
})

configure("ruby_lsp", {
	on_attach = on_attach,
})

configure("hls", {
	on_attach = on_attach,
})

configure("ruff", {
	on_attach = on_attach,
	init_options = {
		settings = {},
	},
})

for _, server in ipairs({
	"pylsp",
	"gopls",
	"lua_ls",
	"bashls",
	"rust_analyzer",
	"clangd",
	"ocamllsp",
	"ruby_lsp",
	"hls",
	"ruff",
}) do
	vim.lsp.enable(server)
end
