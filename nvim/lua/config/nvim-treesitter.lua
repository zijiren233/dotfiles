local treesitter = require("nvim-treesitter")

local ensure_installed = {
	"c",
	"cpp",
	"lua",
	"bash",
	"vim",
	"regex",
	"yaml",
	"toml",
	"rust",
	"python",
	"make",
	"json",
	"dockerfile",
	"gitignore",
	"gomod",
	"go",
	"gotmpl",
	"nginx",
	"sql",
	"diff",
	"markdown",
	"markdown_inline",
}

treesitter.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

-- Parsers and queries are installed asynchronously and are skipped when current.
treesitter.install(ensure_installed)

local parser_filetypes = {
	bash = true,
	sh = true,
	c = true,
	cpp = true,
	lua = true,
	vim = true,
	regex = true,
	yaml = true,
	toml = true,
	rust = true,
	python = true,
	py = true,
	make = true,
	automake = true,
	json = true,
	jsonc = true,
	dockerfile = true,
	gitignore = true,
	gitconfig = true,
	gomod = true,
	go = true,
	gotmpl = true,
	nginx = true,
	sql = true,
	diff = true,
	gitdiff = true,
	markdown = true,
	pandoc = true,
}

local highlight_disabled = {
	c = true,
	rust = true,
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	group = vim.api.nvim_create_augroup("zjr_treesitter", { clear = true }),
	callback = function(args)
		local filetype = vim.bo[args.buf].filetype
		if not parser_filetypes[filetype] then
			return
		end

		local parser_ok = pcall(vim.treesitter.get_parser, args.buf)
		if not parser_ok then
			return
		end
		if not highlight_disabled[filetype] then
			local highlighter = vim.treesitter.highlighter
			if not highlighter.active[args.buf] and not pcall(vim.treesitter.start, args.buf) then
				return
			end
		end

		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldenable = false
		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- Neovim 0.12 provides incremental selection as a core Tree-sitter feature.
vim.keymap.set("n", "gss", function()
	vim.treesitter.select("parent")
end, { desc = "Tree-sitter select parent" })
vim.keymap.set("x", "gsi", function()
	vim.treesitter.select("parent")
end, { desc = "Tree-sitter select parent" })
vim.keymap.set("x", "gsc", function()
	vim.treesitter.select("parent")
end, { desc = "Tree-sitter select scope" })
vim.keymap.set("x", "gsd", function()
	vim.treesitter.select("child")
end, { desc = "Tree-sitter select child" })
