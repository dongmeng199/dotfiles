local package = require('core.pack').package

package({
  'neovim/nvim-lspconfig',
  lazy = true,
  event = { 'CursorHold', 'CursorHoldI' },
  config = require('completion.lsp'),
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    -- {
    -- 	"Jint-lzxy/lsp_signature.nvim",
    -- 	config = require("completion.lsp-signature"),
    -- },
  },
})

package({
  'nvimdev/lspsaga.nvim',
  lazy = true,
  event = 'LspAttach',
  config = require('completion.lspsaga'),
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})

package({
  'dnlhc/glance.nvim',
  lazy = true,
  event = 'LspAttach',
  config = require('completion.glance'),
})

package({
  'simrat39/symbols-outline.nvim',
  lazy = true,
  event = 'LspAttach',
  config = require('completion.symbols-outline'),
})

package({
  'jose-elias-alvarez/null-ls.nvim',
  lazy = true,
  event = { 'CursorHold', 'CursorHoldI' },
  config = require('completion.null-ls'),
  dependencies = {
    'nvim-lua/plenary.nvim',
    'jay-babu/mason-null-ls.nvim',
  },
})

package({
  'hrsh7th/nvim-cmp',
  lazy = true,
  event = 'InsertEnter',
  config = require('completion.cmp'),
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      dependencies = { 'rafamadriz/friendly-snippets' },
      config = require('completion.luasnip'),
    },
    { 'lukas-reineke/cmp-under-comparator' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'hrsh7th/cmp-path' },
    { 'f3fora/cmp-spell' },
    { 'hrsh7th/cmp-buffer' },
    { 'ray-x/cmp-treesitter', commit = 'c8e3a74' },
    -- { "tzachar/cmp-tabnine", build = "./install.sh", config = require("completion.tabnine") },
    -- {
    -- 	"jcdickinson/codeium.nvim",
    -- 	dependencies = {
    -- 		"nvim-lua/plenary.nvim",
    -- 		"MunifTanjim/nui.nvim",
    -- 	},
    -- 	config = require("completion.codeium"),
    -- },
  },
})

package({
  'zbirenbaum/copilot.lua',
  lazy = true,
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = require('completion.copilot'),
  dependencies = {
    {
      'zbirenbaum/copilot-cmp',
      config = require('completion.copilot-cmp'),
    },
  },
})
