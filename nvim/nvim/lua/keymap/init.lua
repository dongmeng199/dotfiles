require("keymap.helpers")
local bind = require("keymap.bind")
local map_cr = bind.map_cr
-- local map_cu = bind.map_cu
-- local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local plug_map = {
	["n|;w"] = map_callback(function()
			vim.cmd("w")
		end)
		:with_silent()
		:with_noremap()
		:with_nowait()
		:with_desc("save file"),
	["n|;q"] = map_callback(function()
			if vim.api.nvim_buf_get_name(0) == "" then
				vim.cmd("q!")
			else
				vim.cmd("x")
			end
		end)
		:with_silent()
		:with_noremap()
		:with_nowait()
		:with_desc("delete file"),
}

bind.nvim_load_mapping(plug_map)

-- Plugin keymaps
require("keymap.completion")
require("keymap.editor")
require("keymap.lang")
require("keymap.tool")
require("keymap.ui")
