local map = require("core.keymap")

-- FTerm
map("n", ";t", function()
	require("FTerm").toggle()
end, { desc = "toggle fterm" })

-- map("t", "<esc><esc>", function()
-- 	require("FTerm").close()
-- end, { desc = "Enter Normal Mode" })

-- nvimtree
map("n", ";e", function()
	vim.cmd("Neotree reveal")
end, { noremap = true, silent = true })

map("n", ";b", function()
	vim.cmd("Neotree buffers")
end, { noremap = true, silent = true })

-- Telescope
map("n", ";a", function()
	vim.cmd("Telescope live_grep")
end, { noremap = true, silent = true })
map("n", ";f", function()
	vim.cmd("Telescope fd")
end, { noremap = true, silent = true })
map("n", ";r", function()
	vim.cmd("Telescope resume")
end, { noremap = true, silent = true })


-- Lspsaga
map( 'n', ',e', function() vim.cmd('Lspsaga diagnostic_jump_prev') end, {noremap=true, silent=true})
map( 'n', '.e', function() vim.cmd('Lspsaga diagnostic_jump_next') end, {noremap=true, silent=true})
map( 'n', 'K', vim.lsp.buf.hover, {noremap=true, silent=true})
map( 'n', 'ga', function() vim.cmd('Lspsaga code_action') end, {noremap=true, silent=true})
map( 'n', 'gn', function() vim.cmd('Lspsaga rename') end, {noremap=true, silent=true})
map( 'n', 'gh', function() vim.cmd('Lspsaga finder') end, {noremap=true, silent=true})
map( 'n', 'gd', function() vim.cmd('Lspsaga peek_definition') end, {noremap=true, silent=true})
map( 'n', 'go', function() vim.cmd('Lspsaga outline') end, {noremap=true, silent=true})
map( 'n', '<Leader>ci', function() vim.cmd('Lspsaga incoming_calls') end, {noremap=true, silent=true})
map( 'n', '<Leader>co', function() vim.cmd('Lspsaga outgoing_calls') end, {noremap=true, silent=true})
