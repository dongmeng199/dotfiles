local keymap = require('core.keymap')
local nmap, imap, cmap, xmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = ' '

-- leaderkey
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })
nmap({ ';', '', opts(noremap) })
xmap({ ';', '', opts(noremap) })

-- usage example
nmap({
  { ';;',    ';',     opts(noremap, silent) },
  { ',,',    ',',     opts(noremap, silent) },
  { '*',     '*N',    opts(noremap, silent) },
  { 'Y',     'y$',    opts(noremap) },
  { 'n',     'n',     opts(silent, noremap) },
  { 'N',     'N',     opts(silent, noremap) },
  { '<C-o>', '<C-o>', opts(silent, noremap) },
  { '<C-i>', '<C-i>', opts(silent, noremap) },

  { ";w", function()
    vim.cmd('w')
  end, opts(noremap, silent) },

  { ";q", function()
    if vim.api.nvim_buf_get_name(0) == "" then
      vim.cmd('q!')
    else
      vim.cmd('x')
    end
  end, opts(noremap, silent) },

})

imap({
  { '<C-f>', '<Right>', opts(noremap) },
  { '<C-b>', '<Left>',  opts(noremap) },
  { '<C-a>', '<Home>',  opts(noremap) },
  { '<C-h>', '<Bs>',    opts(noremap) },
  { '<C-e>', '<End>',   opts(noremap) },
})

-- commandline remap
cmap({
  { '<C-b>', '<Left>',  opts(noremap) },
  { '<C-f>', '<Right>', opts(noremap) },
  { '<C-h>', '<Bs>',    opts(noremap) },
  { '<C-a>', '<Home>',  opts(noremap) },
  { '<C-e>', '<End>',   opts(noremap) },
})

-- usage of plugins
nmap({

  -- nvimtree
  { ";e",         function() vim.cmd('Neotree reveal') end,  opts(noremap, silent) },
  { ";b",         function() vim.cmd('Neotree buffers') end, opts(noremap, silent) },
  -- { ";g",         function() vim.cmd('Neotree git_status') end, opts(noremap, silent) },

  -- Telescope
  { '<Leader>b',  cmd('Telescope buffers'),                  opts(noremap, silent) },
  { '<Leader>fa', cmd('Telescope live_grep'),                opts(noremap, silent) },
  { '<Leader>ff', cmd('Telescope find_files'),               opts(noremap, silent) },
  { ';a',         cmd('Telescope live_grep'),                opts(noremap, silent) },
  { ';f',         cmd('Telescope fd'),                       opts(noremap, silent) },
  { ';r',         cmd('Telescope resume'),                   opts(noremap, silent) },

  -- Lspsaga
  { ',e',         cmd('Lspsaga diagnostic_jump_prev'),       opts(noremap, silent) },
  { '.e',         cmd('Lspsaga diagnostic_jump_next'),       opts(noremap, silent) },
  { 'K',          vim.lsp.buf.hover,                         opts(noremap, silent) },
  { 'ga',         cmd('Lspsaga code_action'),                opts(noremap, silent) },
  { 'gn',         cmd('Lspsaga rename'),                     opts(noremap, silent) },
  { 'gh',         cmd('Lspsaga lsp_finder'),                 opts(noremap, silent) },
  { 'gd',         cmd('Lspsaga peek_definition'),            opts(noremap, silent) },
  { 'go',         cmd('Lspsaga outline'),                    opts(noremap, silent) },
  { '<Leader>ci', cmd('Lspsaga incoming_calls'),             opts(noremap, silent) },
  { '<Leader>co', cmd('Lspsaga outgoing_calls'),             opts(noremap, silent) },

})
