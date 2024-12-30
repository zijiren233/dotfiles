local status_ok, noice = pcall(require, "noice")
if not status_ok then
    return
end
noice.setup({
    presets = {
        command_palette = false,
    },
    messages = {
        enabled = true,
    },
    popupmenu = {
        enabled = false,
    },
    lsp = {
        signature = {
            enabled = false,
        },
        progress = {
            enabled = true,
        },
        hover = {
            enabled = false,
        },
    },
})