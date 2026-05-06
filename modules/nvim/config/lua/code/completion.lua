local blink = require("blink.cmp")

blink.setup({
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	keymap = {
		preset = "none",
		-- Trigger completion manually
		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },

		["<right>"] = {
			function(cmp)
				if cmp.snippet_active() then
					return cmp.accept()
				else
					return cmp.select_and_accept()
				end
			end,
			"snippet_forward",
			"fallback",
		},
		["<down>"] = { "select_next", "fallback" },
		["<up>"] = { "select_prev", "fallback" },

		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 100,
		},
		ghost_text = {
			enabled = true,
			show_with_menu = false,
		},
		menu = {
			auto_show = false,
			border = "rounded",
		},
	},
	signature = {
		enabled = true,
	},
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = {
			download = true,
		},
	},
})
