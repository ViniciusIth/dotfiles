return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
	root_markers = { ".git" },
	settings = {
		redhat = { telemetry = { enabled = false } },
		-- formatting disabled by default in yaml-language-server; enable it
		yaml = { format = { enable = true } },
	},
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = true
	end,
}
