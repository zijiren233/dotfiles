local init_vim_path = vim.fn.expand("~/.config/nvim/init.vim")
if vim.fn.filereadable(init_vim_path) == 1 then
    vim.cmd(string.format([[source %s]], init_vim_path))
end

-- vim.opt.clipboard:append("unnamedplus")
-- if vim.fn.exists('$SSH_TTY') == 1 and vim.env.TMUX == nil then
--     vim.g.clipboard = {
--         name = 'OSC 52',
--         copy = {
--             ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--             ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--         },
--         paste = {
--             ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--             ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--         },
--     }
-- end
