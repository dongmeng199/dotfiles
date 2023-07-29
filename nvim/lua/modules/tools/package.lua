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
  "desdic/agrolens.nvim"
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
        yankMacro = "yq",    -- also decodes it for turning macros to mappings
        addBreakPoint = "#", -- ⚠️ this should be a string you don't use in insert mode during a macro
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
  "numToStr/FTerm.nvim"
})

package({
  "samjwill/nvim-unception",
  init = function()
    vim.api.nvim_create_autocmd(
      "User",
      {
        pattern = "UnceptionEditRequestReceived",
        callback = function()
          -- Toggle the terminal off.
          require('FTerm').close()
          require("internal.lazygit"):close()
        end
      }
    )
    vim.g.unception_open_buffer_in_new_tab = true
  end
})

package({
  dir = vim.fn.stdpath("config") .. "nvim/lua/internal/lazygit.lua",
  config = function()
    require("internal.lazygit")
  end
})

package({
  "nicwest/vim-camelsnek",
})

package({
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = conf.flash,
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end },
  },
})

package({
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = conf.noice,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  }
})
