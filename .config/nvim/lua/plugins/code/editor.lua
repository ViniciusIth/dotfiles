return {
    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy = false,
    },
    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        config = function()
            local mc = require("multicursor-nvim")

            mc.setup()

            local set = vim.keymap.set

            -- Add or skip cursor above/below the main cursor.
            set({ "n", "v" }, "<up>",
                function() mc.lineAddCursor(-1) end, { desc = "Add cursor above" })
            set({ "n", "v" }, "<down>",
                function() mc.lineAddCursor(1) end, { desc = "Add cursor below" })
            set({ "n", "v" }, "<leader><up>",
                function() mc.lineSkipCursor(-1) end, { desc = "Skip cursor above" })
            set({ "n", "v" }, "<leader><down>",
                function() mc.lineSkipCursor(1) end, { desc = "Skip cursor below" })

            -- Add or skip adding a new cursor by matching symbol/selection
            set({ "n", "v" }, "<C-j>",
                function() mc.matchAddCursor(1) end, { desc = "Add cursor to next symbol" })
            set({ "n", "v" }, "<C-J>",
                function() mc.matchAddCursor(-1) end, { desc = "Add cursor at previous symbol" })

            -- Add all matches in the document
            set({ "n", "v" }, "<leader>A", mc.matchAllAddCursors, { desc = "Add all matches" })

            -- You can also add cursors with any motion you prefer:
            -- set("n", "<right>", function()
            --     mc.addCursor("w")
            -- end)
            -- set("n", "<leader><right>", function()
            --     mc.skipCursor("w")
            -- end)

            -- Rotate the main cursor.
            set({ "n", "v" }, "<left>", mc.nextCursor, { desc = "Next cursor" })
            set({ "n", "v" }, "<right>", mc.prevCursor, { desc = "Previous cursor" })

            -- Delete the main cursor.
            set({ "n", "v" }, "<leader>x", mc.deleteCursor, { desc = "Delete main cursor" })

            -- Add and remove cursors with control + left click.
            set("n", "<c-leftmouse>", mc.handleMouse, { desc = "Add cursor with mouse" })

            -- Easy way to add and remove cursors using the main cursor.
            set({ "n", "v" }, "<c-q>", mc.toggleCursor, { desc = "Add/remove cursor at main cursor" })

            -- Clone every cursor and disable the originals.
            set({ "n", "v" }, "<leader><c-q>", mc.duplicateCursors)

            set("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                elseif mc.hasCursors() then
                    mc.clearCursors()
                else
                    -- Default <esc> handler.
                end
            end)

            -- bring back cursors if you accidentally clear them
            set("n", "<leader>gv", mc.restoreCursors, { desc = "Restore cleared cursors" })

            -- Align cursor columns.
            set("v", "<leader>a", mc.alignCursors)

            -- Split visual selections by regex.
            set("v", "S", mc.splitCursors)

            -- Append/insert for each line of visual selections.
            set("v", "I", mc.insertVisual)
            set("v", "A", mc.appendVisual)

            -- match new cursors within visual selections by regex.
            set("v", "M", mc.matchCursors)

            -- Rotate visual selection contents.
            set("v", "<leader>t",
                function() mc.transposeCursors(1) end)
            set("v", "<leader>T",
                function() mc.transposeCursors(-1) end)

            -- Jumplist support
            set({ "v", "n" }, "<c-i>", mc.jumpForward)
            set({ "v", "n" }, "<c-o>", mc.jumpBackward)

            -- Customize how cursors look.
            local hl = vim.api.nvim_set_hl
            hl(0, "MultiCursorCursor", { link = "Cursor" })
            hl(0, "MultiCursorVisual", { link = "Visual" })
            hl(0, "MultiCursorSign", { link = "SignColumn" })
            hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
            hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
            hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
        end
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    -- {
    --     'jinh0/eyeliner.nvim',
    --     config = function()
    --         require('eyeliner').setup({
    --             highlight_on_key = true,
    --         })
    --     end
    -- },
    {
        "theKnightsOfRohan/csvlens.nvim",
        dependencies = {
            "akinsho/toggleterm.nvim"
        },
        config = true,
        opts = { --[[ Place your opts here ]] }
    }
}
