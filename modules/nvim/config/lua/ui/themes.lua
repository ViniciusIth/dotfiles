require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        mason = true,
        which_key = true,
        -- native_lsp = {
        --     enabled = true,
        --     virtual_text = {
        --         errors = { "italic" },
        --         hints = { "italic" },
        --         warnings = { "italic" },
        --         information = { "italic" },
        --     },
        --     underlines = {
        --         errors = { "underline" },
        --         hints = { "underline" },
        --         warnings = { "underline" },
        --         information = { "underline" },
        --     },
        -- },
    },
})

require("techbase").setup({
    transparent = true,
})

require('kanagawa').setup({
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,
    dimInactive = false,
    terminalColors = true,
    colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors)
        local palette = colors.palette
        local theme = colors.theme

        return {

            ---------------------------------------------------------------------
            -- Menu
            ---------------------------------------------------------------------
            BlinkCmpMenu                         = {
                bg = palette.sumiInk2,
                fg = theme.ui.fg,
            },

            BlinkCmpMenuBorder                   = {
                bg = palette.sumiInk2,
                fg = theme.ui.float.border,
            },

            BlinkCmpMenuSelection                = {
                bg = palette.sumiInk4,
                fg = theme.ui.fg,
                bold = true,
            },

            BlinkCmpScrollBarThumb               = { bg = palette.sumiInk5 },
            BlinkCmpScrollBarGutter              = { bg = palette.sumiInk3 },

            ---------------------------------------------------------------------
            -- Labels
            ---------------------------------------------------------------------
            BlinkCmpLabel                        = { fg = theme.ui.fg },
            BlinkCmpLabelMatch                   = { fg = palette.oniViolet, bold = true },
            BlinkCmpLabelDeprecated              = { fg = palette.katanaGray, strikethrough = true },
            BlinkCmpLabelDetail                  = { fg = palette.sumiInk6 },
            BlinkCmpLabelDescription             = { fg = palette.sumiInk6 },

            BlinkCmpSource                       = { fg = palette.sumiInk5 },

            ---------------------------------------------------------------------
            -- Kinds
            ---------------------------------------------------------------------
            BlinkCmpKind                         = { fg = palette.oniViolet }, -- fallback

            BlinkCmpKindFunction                 = { fg = palette.waveAqua2 },
            BlinkCmpKindMethod                   = { fg = palette.waveAqua2 },
            BlinkCmpKindField                    = { fg = palette.sakuraPink },
            BlinkCmpKindProperty                 = { fg = palette.sakuraPink },
            BlinkCmpKindVariable                 = { fg = palette.carpYellow },
            BlinkCmpKindClass                    = { fg = palette.peachRed },
            BlinkCmpKindStruct                   = { fg = palette.peachRed },
            BlinkCmpKindModule                   = { fg = palette.springGreen },
            BlinkCmpKindKeyword                  = { fg = palette.oniViolet },
            BlinkCmpKindSnippet                  = {
                fg = palette.fujiWhite,
                bg = palette.sumiInk5,
                italic = true,
            },

            ---------------------------------------------------------------------
            -- Documentation Window
            ---------------------------------------------------------------------
            BlinkCmpDoc                          = {
                bg = palette.sumiInk2,
                fg = theme.ui.fg,
            },

            BlinkCmpDocBorder                    = {
                bg = palette.sumiInk2,
                fg = theme.ui.float.border,
            },

            BlinkCmpDocSeparator                 = {
                fg = palette.sumiInk4,
            },

            BlinkCmpDocCursorLine                = {
                bg = palette.sumiInk4,
            },

            BlinkCmpSignatureHelp                = {
                bg = palette.sumiInk2,
                fg = theme.ui.fg,
            },

            BlinkCmpSignatureHelpBorder          = {
                bg = palette.sumiInk2,
                fg = theme.ui.float.border,
            },

            BlinkCmpSignatureHelpActiveParameter = {
                fg = palette.peachRed,
                bold = true,
            },
        }
    end,
    theme = "dragon",
    background = {
        dark = "dragon",
        light = "lotus"
    },
})

vim.cmd.colorscheme("kanagawa")
