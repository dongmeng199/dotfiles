local map = require("core.keymap")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)

map({ "n", "x" }, "*", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- quit
map("n", ";q", function()
	if vim.api.nvim_buf_get_name(0) == "" then
		vim.cmd("q!")
	else
		vim.cmd("x")
	end
end, { noremap = true, silent = true, desc = "quit and save" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
	map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

map("i", "<C-u>", "<C-G>u<C-U>", { noremap = true, desc = "edit: Delete previous block" }))
map("i", "<C-b>", "<Left>", { noremap = true, desc = "edit: Move cursor to left" })
map("i", "<C-f>", "<right>", { noremap = true, desc = "edit: Move cursor to left" })
map("i", "<C-a>", "<ESC>^i", { noremap = true, desc = "edit: Move cursor to line start" })

-- Command mode    ,
map("c", "<C-b>", "<Left>", { noremap = true, desc = "edit: Left" })
map("c", "<C-f>", "<Right>", { noremap = true, desc = "edit: Right" })
map("c", "<C-a>", "<Home>", { noremap = true, desc = "edit: Home" })
map("c", "<C-e>", "<End>", { noremap = true, desc = "edit: End" })
map("c", "<C-d>", "<Del>", { noremap = true, desc = "edit: Delete" })
map("c", "<C-h>", "<BS>", { noremap = true, desc = "edit: Backspace" })
map(
	"c",
	"<C-t>",
	[[<C-R>=expand("%:p:h") . "/" <CR>]],
	{ noremap = true, desc = "edit: Complete path of current file" }
)
