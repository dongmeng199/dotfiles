return function()
	require("vgit").setup({
		keymaps = {
			["n ,g"] = function()
				require("vgit").hunk_up()
			end,
			["n .g"] = function()
				require("vgit").hunk_down()
			end,
			["n ;d"] = function()
				require("vgit").buffer_diff_preview()
			end,
			["n ;h"] = function()
				require("vgit").buffer_history_preview()
			end,
		},
		settings = {
			live_blame = {
				enabled = false,
			},
			live_gutter = {
				enabled = true,
				edge_navigation = true, -- This allows users to navigate within a hunk
			},
			authorship_code_lens = {
				enabled = false,
			},
			scene = {
				diff_preference = "unified", -- unified or split
				keymaps = {
					quit = "q",
				},
			},
			diff_preview = {
				keymaps = {
					buffer_stage = "S",
					buffer_unstage = "U",
					buffer_hunk_stage = "s",
					buffer_hunk_unstage = "u",
					toggle_view = "t",
				},
			},
			project_diff_preview = {
				keymaps = {
					buffer_stage = "s",
					buffer_unstage = "u",
					buffer_hunk_stage = "gs",
					buffer_hunk_unstage = "gu",
					buffer_reset = "r",
					stage_all = "S",
					unstage_all = "U",
					reset_all = "R",
				},
			},
			project_commit_preview = {
				keymaps = {
					save = "S",
				},
			},
		},
	})
end
