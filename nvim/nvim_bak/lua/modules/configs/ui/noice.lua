return function()
	local opts = {
		lsp = {
			signature = {
				enabled = true,
			},
			message = {
				enabled = false,
			},
			progress = {
				enabled = false,
			},
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		routes = {},
	}
	return opts
end
