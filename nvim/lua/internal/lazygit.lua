local fterm = require('FTerm')

local lazygit = fterm:new({
  ft = 'fterm_lazygit', -- You can also override the default filetype, if you want
  cmd = 'lazygit',
  dimensions = {
    height = 0.95,
    width = 0.95,
  },
})

vim.keymap.set('n', ';g', function()
  lazygit:toggle()
end)

return lazygit
