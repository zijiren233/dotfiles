local which_key_ok, which_key = pcall(require, "which-key")
if not which_key_ok then
    return
end
which_key.setup({
    defer = function(ctx)
        if vim.list_contains({ 'd', 'y' }, ctx.operator) then
            return true
        end
        return vim.list_contains({ 'v', '<C-V>', 'V' }, ctx.mode)
    end,
    preset = 'helix',
    icons = {
        colors = true,
        keys = {
        },
    },
})

-- Document existing key chains
which_key.add {
    { '<leader>b', group = 'Buffer', mode = 'n', icon = ' ' },
    { '<leader>l', group = 'Lsp', mode = 'n', icon = '󰿘 ' },
    { '<leader>f', group = 'Find', mode = 'n' },
    { '<leader>s', group = 'Search', mode = 'n' },
}
