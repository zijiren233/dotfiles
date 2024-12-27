local status_ok, telescope = pcall(require, "telescope.builtin")
if not status_ok then
    return
end
vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope.git_files, {})
vim.keymap.set("n", "<leader>fb", telescope.buffers, {})
vim.keymap.set("n", "<leader>flg", telescope.live_grep, {}) -- NOTE: requires ripgrep
vim.keymap.set("n", "<leader>fc", function() -- fc = find by content
    telescope.grep_string({ search = vim.fn.input("Grep > ") })
end)