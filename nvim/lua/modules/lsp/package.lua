local package = require('core.pack').package
local conf = require('modules.lsp.config')

local enable_lsp_filetype = {
    'go',
    'lua',
    'sh',
    'rust',
    'c',
    'cpp',
    'python',
    'typescript',
    'proto',
}

package({
    'neovim/nvim-lspconfig',
    ft = enable_lsp_filetype,
    config = conf.nvim_lsp,
    dependencies = 'mason-lspconfig.nvim'
})

package({
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    config = conf.lspconfig,
    dependencies = "mason.nvim",
})

package({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
})

package({
    "glepnir/lspsaga.nvim",
    ft = enable_lsp_filetype,
    config = conf.lspsaga,
})

package({
    "jose-elias-alvarez/null-ls.nvim",
    ft = enable_lsp_filetype,
    config = conf.null_ls,
})

package({
    'ray-x/lsp_signature.nvim',
    ft = enable_lsp_filetype,
    config = function()
      require "lsp_signature".setup({})
    end
})

package({
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = conf.nvim_cmp,
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-buffer' },
        { 'saadparwaiz1/cmp_luasnip' },
    },
})


package({
    'L3MON4D3/LuaSnip',
    version = "<CurrentMajor>.*",
    build = "make install_jsregexp",
    event = 'InsertCharPre',
    config = conf.lua_snip,
    dependencies = 'rafamadriz/friendly-snippets',
})
