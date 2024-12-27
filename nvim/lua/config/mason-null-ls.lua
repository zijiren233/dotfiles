local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    return
end
local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
    return
end
local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_ok then
    return
end
mason.setup()
mason_null_ls.setup({
    ensure_installed = { "stylua" },
    automatic_installation = false,
    automatic_setup = true,
    handlers = {
        stylua = function(source_name, methods)
            null_ls.register(null_ls.builtins.formatting.stylua)
        end,
        rubyformat = function(source_name, methods)
            null_ls.register(null_ls.builtins.formatting.rubyfmt)
        end,
        clangformat = function(source_name, methods)
            null_ls.register(null_ls.builtins.formatting.clang_format)
        end,
        ocamlformat = function(source_name, methods)
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