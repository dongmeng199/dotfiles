local package = require('core.pack').package
local conf = require('modules.ui.config')

package({ 'glepnir/zephyr-nvim', config = conf.zephyr })

package {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  cmd = 'Neotree',
  config = conf.neo_tree,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  }
}
