local quickshell_qml_path = vim.fn.getenv("QUICK_SHELL_QML_PATH")

return {
    cmd = { "qmlls", "-E" },
    filetypes = { "qml" },

    root_markers = { "shell.qml" },

    settings = {
        qml = {
            importPaths = {
                quickshell_qml_path,
            },
        },
    },
}
