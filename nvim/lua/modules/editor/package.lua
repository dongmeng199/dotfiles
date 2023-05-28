local package = require('core.pack').package
local conf = require('modules.editor.config')

package({
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  run = ':TSUpdate',
  config = conf.nvim_treesitter,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    "p00f/nvim-ts-rainbow",
    "andymass/vim-matchup",
  },
})

package({
  "m-demare/hlargs.nvim",
  config = function()
    require('hlargs').setup()
  end
})

package({
  'junegunn/vim-easy-align',
  opt = true,
  cmd = 'EasyAlign'
})

package({
  "rcarriga/nvim-notify",
  opt = true,
})

package({
  "nvim-neorg/neorg",
  run = ":Neorg sync-parsers",
  ft = "norg",
  after = "nvim-treesitter",
  config = conf.neorg,
})

package {
  'jghauser/mkdir.nvim'
}

package({
  "windwp/nvim-autopairs",
  config = function() require("nvim-autopairs").setup {} end
})

package({
  'RRethy/vim-illuminate',
  config = conf.illuminate,
})
