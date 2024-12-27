local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
    return
end
autopairs.setup({
    disable_filetype = { "TelescopePrompt" },
    map_cr = true,
    check_ts = true,
    ts_config = {
        lua = { "string" }, -- it will not add a pair on that tree-sitter node
        javascript = { "template_string" },
        java = false, -- don't check tree-sitter on java
    },
})