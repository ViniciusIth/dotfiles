return {
    cmd = { "nil" },
    filetypes = { "nix" },
    root_markers = {
        "flake.nix",
        "default.nix",
        ".git",
    },
    settings = {
        ["nil"] = {
            formatting = {
                command = { "alejandra" },
            },
            nix = {
                flake = {
                    autoEvalInputs = true,
                },
            },
            diagnostics = {
                excludedFiles = { "hardware-configuration.nix" },
            },
        },
    },
}
