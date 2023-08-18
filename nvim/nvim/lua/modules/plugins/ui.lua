local ui = {}

ui["catppuccin/nvim"] = {
	lazy = false,
	name = "catppuccin",
	config = require("ui.catppuccin"),
}
ui["lukas-reineke/indent-blankline.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("ui.indent-blankline"),
}
ui["nvim-neo-tree/neo-tree.nvim"] = {
	branch = "v2.x",
	cmd = "Neotree",
	config = require("ui.neo_tree"),
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
}
ui["folke/paint.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.paint"),
}
ui["nicwest/vim-camelsnek"] = {}
ui["rcarriga/nvim-notify"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("ui.notify"),
}
ui["numToStr/FTerm.nvim"] = {}
ui["tanvirtin/vgit.nvim"] = {
	config = require("ui.vgit"),
}

return ui
