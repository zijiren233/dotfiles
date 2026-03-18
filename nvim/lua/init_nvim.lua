pcall(vim.loader.enable)

do
	local shada_dir = vim.fn.stdpath("state") .. "/shada"
	local main = shada_dir .. "/main.shada"
	local backup = shada_dir .. "/main.shada.tmp.b"
	if vim.uv.fs_stat(backup) then
		if vim.uv.fs_stat(main) then
			pcall(vim.uv.fs_unlink, backup)
		else
			pcall(vim.uv.fs_rename, backup, main)
		end
	end
end

require("options")
require("keymaps")
require("config.lazy")
