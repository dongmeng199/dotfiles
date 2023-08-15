local package = require('core.pack').package

package({
  'LunarVim/bigfile.nvim',
  lazy = false,
  config = require('editor.bigfile'),
  cond = true,
})

package({
  'numToStr/Comment.nvim',
  lazy = true,
  event = { 'CursorHold', 'CursorHoldI' },
  config = require('editor.comment'),
})

package({
  'sindrets/diffview.nvim',
  lazy = true,
  cmd = { 'DiffviewOpen', 'DiffviewClose' },
})

package({
  'junegunn/vim-easy-align',
  lazy = true,
  cmd = 'EasyAlign',
})

package({
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = require('editor.flash'),
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
    },
    {
      'S',
      mode = { 'n', 'o', 'x' },
      function()
        require('flash').treesitter()
      end,
    },
  },
})

package({
  'RRethy/vim-illuminate',
  lazy = true,
  event = { 'CursorHold', 'CursorHoldI' },
  config = require('editor.vim-illuminate'),
})

package({
  'romainl/vim-cool',
  lazy = true,
  event = { 'CursorMoved', 'InsertEnter' },
})

package({
  'lambdalisue/suda.vim',
  lazy = true,
  cmd = { 'SudaRead', 'SudaWrite' },
  config = require('editor.suda'),
})

----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------

package({
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  build = function()
    if #vim.api.nvim_list_uis() ~= 0 then
      vim.api.nvim_command('TSUpdate')
    end
  end,
  event = 'BufReadPost',
  config = require('editor.treesitter'),
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'JoosepAlviste/nvim-ts-context-commentstring' },
    { 'andymass/vim-matchup' },
    {
      'hiphish/rainbow-delimiters.nvim',
      config = require('editor.rainbow_delims'),
    },
    {
      'nvim-treesitter/nvim-treesitter-context',
      config = require('editor.ts-context'),
    },
    {
      'windwp/nvim-ts-autotag',
      config = require('editor.autotag'),
    },
    {
      'NvChad/nvim-colorizer.lua',
      config = require('editor.colorizer'),
    },
    {
      'abecodes/tabout.nvim',
      config = require('editor.tabout'),
    },
  },
})
