local package = require('core.pack').package
local conf = require('modules.tools.config')

package({
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    config = conf.telescope,
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzy-native.nvim' },
    },
})

package({
    'glepnir/hlsearch.nvim',
    event = 'BufRead',
    config = function()
      require('hlsearch').setup()
    end,
})

package({
    "chrisgrieser/nvim-recorder",
    config = function()
      require("recorder").setup {
          slots = { "a", "b" },
          mapping = {
              startStopRecording = "q",
              playMacro = "Q",
              switchSlot = "<C-q>",
              editMacro = "cq",
              yankMacro = "yq", -- also decodes it for turning macros to mappings
              addBreakPoint = "##", -- ⚠️ this should be a string you don't use in insert mode during a macro
          },
          require("recorder").recordingStatus()
      }
    end,
})


package({
    'tanvirtin/vgit.nvim',
    config = conf.vgit,
})

package({
    'willothy/flatten.nvim',
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
})

package({
    "aserowy/tmux.nvim",
    config = function() return require("tmux").setup() end
})


package({
    "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
      vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = 'white', bg = 'gray' })
    end
})
