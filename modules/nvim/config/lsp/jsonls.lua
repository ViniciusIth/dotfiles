---@brief
---
--- JSON Language Server
--- https://github.com/hrsh7th/vscode-langservers-extracted
---
--- Install:
---   npm i -g vscode-langservers-extracted
---

---@type vim.lsp.Config
return {
	filetypes = { "json", "jsonc" },

	root_markers = {
		".git",
		"package.json",
	},

	init_options = {
		provideFormatter = true,
	},

	cmd = function(_, config)
		local cmd = "vscode-json-language-server"

		-- Prefer project-local install if available
		if config.root_dir then
			local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules", ".bin", cmd)

			if vim.fn.executable(local_cmd) == 1 then
				cmd = local_cmd
			end
		end

		return { cmd, "--stdio" }
	end,

	on_attach = function(client, bufnr)
		local opts = {
			buffer = bufnr,
			silent = true,
		}

		vim.keymap.set("n", "<leader>gf", function()
			vim.lsp.buf.format({
				async = true,
			})
		end, opts)
	end,

	capabilities = (function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		return capabilities
	end)(),
}
