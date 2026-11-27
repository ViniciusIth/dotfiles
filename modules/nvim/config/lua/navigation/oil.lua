local oil = require("oil")

oil.setup({
    default_file_explorer = false,
    columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
    },
    win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
    },
    delete_to_trash = false,
    skip_confirm_for_simple_edits = false,
    prompt_save_select_new_entry = true,
    cleanup_delay_ms = 2000,
    lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = true,
    },
    constrain_cursor = "editable",
    watch_for_changes = false,

    use_default_keymaps = false,
    keymaps = {
		["g?"] = { "actions.show_help", mode = "n", desc = "Show help" },

		["<CR>"] = { "actions.select", desc = "Open entry" },
		["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
		["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
		["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },

		["<C-p>"] = { "actions.preview", desc = "Preview file" },
		["<C-c>"] = { "actions.close", desc = "Close" },

		["-"] = { "actions.parent", desc = "Go to parent directory" },
		["_"] = { "actions.open_cwd", desc = "Open cwd" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },

    view_options = {
        show_hidden = false,
        is_hidden_file = function(name, bufnr)
            local m = name:match("^%.")
            return m ~= nil
        end,
        is_always_hidden = function(name, bufnr)
            return false
        end,

        natural_order = "fast",
        case_insensitive = false,
        sort = {
            { "type", "asc" },
            { "name", "asc" },
        },
        highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
            return nil
        end,
    },

    float = {
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = nil,
        win_options = {
            winblend = 0,
        },
        get_win_title = function() return nil end,
        preview_split = "auto",
        override = function(conf) return conf end,
    },

})

vim.keymap.set("n", "<leader>e", function() require("oil").open_float() end, { desc = "Oil float" })

-- 	keymaps = {
-- 		-- Open / edit (oil's default <CR> does the edit_or_open behavior)
-- 		["`"] = { "actions.cd", mode = "n", desc = "Change directory" },
-- 		["~"] = { "actions.cd", opts = { scope = "tab" }, desc = "Change directory (tab)" },
--
-- 		-- Toggle hidden files (mirrors "I" in nvim-tree)
-- 		["I"] = {
-- 			callback = function()
-- 				local oil_view = require("oil.view_options")
-- 				oil_view.toggle_hidden()
-- 			end,
-- 			desc = "Toggle hidden filter",
-- 		},
--
-- 		-- Create / rename / delete (oil uses buffer edits, not commands)
-- 		-- In oil you edit the buffer directly, then :w to apply.
-- 		["a"] = { "actions.create", desc = "Create file/dir (then edit buffer)" },
--
-- 		-- Open in system app (mirrors "o" in nvim-tree)
-- 		["o"] = { "actions.open_external", desc = "Open in default app" },
-- 		["O"] = { "actions.open_terminal", desc = "Open in terminal" },
--
-- 		-- Collapse / refresh (closest analog to nvim-tree "C" / collapse)
-- 		["C"] = { "actions.refresh", desc = "Refresh" },
--
-- 		-- Yank / copy paths
-- 		["y."] = { "actions.yank_entry", desc = "Yank entry" },
-- 		["gy"] = { "actions.copy_entry_path", desc = "Copy entry path" },
--
-- 		-- Misc
-- 		["q"] = { "actions.close", desc = "Close" },
-- 		["<C-l>"] = { "actions.refresh", desc = "Refresh" },
-- 	},
--
-- -- Keymaps outside oil (global) to open the parent dir, like opening nvim-tree
-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- vim.keymap.set("n", "<leader>e", function() require("oil").open_float() end, { desc = "Oil float" })
