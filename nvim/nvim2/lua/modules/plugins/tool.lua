local package = require('core.pack').package

package({
  'ibhagwan/smartyank.nvim',
  lazy = true,
  event = 'BufReadPost',
  config = require('tool.smartyank'),
})

package({
  'folke/trouble.nvim',
  lazy = true,
  cmd = { 'Trouble', 'TroubleToggle', 'TroubleRefresh' },
  config = require('tool.trouble'),
})

----------------------------------------------------------------------
--                        Telescope Plugins                         --
----------------------------------------------------------------------

package({
  'nvim-telescope/telescope.nvim',
  lazy = true,
  cmd = 'Telescope',
  config = require('tool.telescope'),
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-lua/plenary.nvim' },
    { 'debugloop/telescope-undo.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
      'nvim-telescope/telescope-frecency.nvim',
      config = function()
        require('telescope').load_extension('frecency')
      end,
      dependencies = {
        { 'kkharji/sqlite.lua' },
      },
    },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
  },
})

----------------------------------------------------------------------
--                           DAP Plugins                            --
----------------------------------------------------------------------

package({
  'mfussenegger/nvim-dap',
  lazy = true,
  cmd = {
    'DapSetLogLevel',
    'DapShowLog',
    'DapContinue',
    'DapToggleBreakpoint',
    'DapToggleRepl',
    'DapStepOver',
    'DapStepInto',
    'DapStepOut',
    'DapTerminate',
  },
  config = require('tool.dap'),
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      config = require('tool.dap.dapui'),
    },
    { 'jay-babu/mason-nvim-dap.nvim' },
  },
})
