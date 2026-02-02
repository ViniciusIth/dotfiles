return {
    cmd = { 'gopls' },
    filetypes = { "go" },
    root_markers = {
        ".git",
        "go.sum",
        "go.work",
        "go.mod",
    },

    settings = {
        gopls = {
          staticcheck = true,
          analyses = {
            unusedparams = true,
            shadow = true,
            undeclarednames = true,
            ST1000 = false,
            -- S1002 = true,
            -- S1006 = true,
            -- QF1006 = true,
            -- QF1007 = true,
            -- S1005 = true,
            -- S1008 = true,
            -- S1011 = true,
            -- S1021 = true,
            -- S1025 = true,
            -- SA1002 = true,
            -- SA1014 = true,
          },
          usePlaceholders = true,
        },
    },
}
