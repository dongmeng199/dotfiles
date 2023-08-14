local package = require('core.pack').package

package({
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = require('ui.catppuccin'),
})

-- package({
--   'lewis6991/gitsigns.nvim',
--   lazy = true,
--   event = { 'CursorHold', 'CursorHoldI' },
--   config = require('ui.gitsigns'),
-- })

package({
  'lukas-reineke/indent-blankline.nvim',
  lazy = true,
  event = 'BufReadPost',
  config = require('ui.indent-blankline'),
})

package({
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  cmd = 'Neotree',
  config = require('ui.neo_tree'),
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
})

package({
  'folke/paint.nvim',
  lazy = true,
  event = { 'CursorHold', 'CursorHoldI' },
  config = require('ui.paint'),
})

package({
  'nicwest/vim-camelsnek',
})

package({
  'rcarriga/nvim-notify',
  lazy = true,
  event = 'VeryLazy',
  config = require('ui.notify'),
})

--package{
--  "folke/noice.nvim",
-- 	event = "VeryLazy",
-- 	opts = require("ui.noice"),
-- 	dependencies = {
-- 		"MunifTanjim/nui.nvim",
-- 		"rcarriga/nvim-notify",
-- 	},
-- }

package({
  'numToStr/FTerm.nvim',
})
