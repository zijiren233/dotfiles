local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
    return
end
local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_ok then
    return
end
mason_null_ls.setup({
    ensure_installed = { "stylua" },
    automatic_installation = false,
    handlers = {
        stylua = function()
            null_ls.register(null_ls.builtins.formatting.stylua)
        end,
        rubyformat = function()
            null_ls.register(null_ls.builtins.formatting.rubyfmt)
        end,
        clangformat = function()
            null_ls.register(null_ls.builtins.formatting.clang_format)
        end,
        ocamlformat = function()
            null_ls.register(null_ls.builtins.formatting.ocamlformat.with({
                extra_args = {
                    "--if-then-else",
                    "vertical",
                    "--break-cases",
                    "fit-or-vertical",
                    "--type-decl",
                    "sparse",
                },
            }))
        end,
    },
})
null_ls.setup({
    sources = {},
})
