local bind = require("keymap.bind")
local map_cr = bind.map_cr
-- local map_cu = bind.map_cu
-- local map_cmd = bind.map_cmd
-- local map_callback = bind.map_callback

local plug_map = {
	-- Plugin: nvimtree
	["n|;e"] = bind.map_callback(function()
		vim.cmd("Neotree reveal")
	end)
		:with_noremap()
		:with_silent()
		:with_desc("Neotree: reveal"),

	["n|;b"] = bind.map_callback(function()
		vim.cmd("Neotree buffers")
	end)
		:with_noremap()
		:with_silent()
		:with_desc("Neotree: reveal"),
}

bind.nvim_load_mapping(plug_map)

local mapping = {}

function mapping.gitsigns(buf)
	local actions = require("gitsigns.actions")
	local map = {
		["n|.g"] = bind.map_callback(function()
			if vim.wo.diff then
				return "]g"
			end
			vim.schedule(function()
				actions.next_hunk()
			end)
			return "<Ignore>"
		end)
			:with_buffer(buf)
			:with_expr()
			:with_desc("git: Goto next hunk"),
		["n|,g"] = bind.map_callback(function()
			if vim.wo.diff then
				return "[g"
			end
			vim.schedule(function()
				actions.prev_hunk()
			end)
			return "<Ignore>"
		end)
			:with_buffer(buf)
			:with_expr()
			:with_desc("git: Goto prev hunk"),
	}
	bind.nvim_load_mapping(map)
end

return mapping
