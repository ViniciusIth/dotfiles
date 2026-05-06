require("lspconfig")
require("mason").setup()

vim.lsp.config("*", {
	flags = {
		debounce_text_changes = 150,
	},
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("gopls")
vim.lsp.enable("nil")
vim.lsp.enable("qmlls")
vim.lsp.enable("emmet-language-server")

vim.lsp.enable("ruff")
vim.lsp.enable("python")

vim.lsp.enable("typescript")
vim.lsp.enable("yaml")
vim.lsp.enable("jsonls")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local bufnr = event.buf

		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end

		if client and client:supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})

			vim.keymap.set("n", "<leader>gf", function()
				vim.lsp.buf.format({ async = true })
			end, { buffer = bufnr, desc = "Format buffer" })
		end

		local bindOpts = { noremap = true, silent = true, buffer = event.buf }
		-- Lsp definications, implementations etc
		bindOpts.desc = "Show LSP references"
		vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", bindOpts)

		bindOpts.desc = "Show LSP definitions"
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bindOpts)

		bindOpts.desc = "Show LSP implementations"
		vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bindOpts)

		bindOpts.desc = "Show LSP type definitions"
		vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", bindOpts)

		bindOpts.desc = "Go to declaration"
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bindOpts)

		-- Diagnostics
		bindOpts.desc = "Show buffer diagnostics"
		vim.keymap.set("n", "<leader>bD", "<cmd>Telescope diagnostics bufnr=0<CR>", bindOpts)

		bindOpts.desc = "Show line diagnostics"
		vim.keymap.set("n", "<leader>bd", vim.diagnostic.open_float, bindOpts)

		-- Lsp actions (use [gra] instead)
		-- bindOpts.desc = "See available code actions"
		-- vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bindOpts)

		bindOpts.desc = "Smart rename"
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bindOpts)

		bindOpts.desc = "Show documentation for what is under cursor"
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, bindOpts)
	end,
})

vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
})
