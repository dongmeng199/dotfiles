local config = {}

function config.null_ls()
  local null_ls = require("null-ls")
  null_ls.setup({
      sources = {
          null_ls.builtins.diagnostics.cspell,
          null_ls.builtins.code_actions.cspell,
          null_ls.builtins.diagnostics.golangci_lint,
      },
  })
end

function config.lspconfig()
  local plugin = require("mason-lspconfig")
  plugin.setup {
      ensure_installed = { "gopls", "rust_analyzer", "lua_ls", "clangd" },
  }

  plugin.setup_handlers(require('modules.lsp.lsp_server'))
end

function config.nvim_lsp()
  local signs = {
      Error = ' ',
      Warn = ' ',
      Info = ' ',
      Hint = 'ﴞ ',
  }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
      signs = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      virtual_text = {
          source = true,
      },
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(ev)
        vim.lsp.buf.format()
      end
  })

  vim.lsp.handlers['workspace/diagnostic/refresh'] = function(_, _, ctx)
    local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
    local bufnr = vim.api.nvim_get_current_buf()
    vim.diagnostic.reset(ns, bufnr)
    return true
  end
end

function config.lspsaga()
  require("lspsaga").setup({
      outline = {
          keys = {
              jump = "<CR>",
          }
      },
      symbol_in_winbar = {
          enable = false,
      }
  })
end

function config.nvim_cmp()
  local cmp = require('cmp')
  cmp.setup({
      completion = {
          completeopt = 'menu,menuone,noinsert',
      },
      preselect = cmp.PreselectMode.Item,
      window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
      },
      formatting = {
          fields = { 'abbr', 'kind', 'menu' },
      },
      mapping = cmp.mapping.preset.insert({
          ['<C-e>'] = cmp.config.disable,
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
      },
      sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
      },
  })
end

function config.lua_snip()
  local ls = require('luasnip')
  local types = require('luasnip.util.types')
  ls.config.set_config({
      history = true,
      enable_autosnippets = true,
      updateevents = 'TextChanged,TextChangedI',
      ext_opts = {
          [types.choiceNode] = {
              active = {
                  virt_text = { { '<- choiceNode', 'Comment' } },
              },
          },
      },
  })
  require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({
      paths = { './snippets/' },
  })

  vim.keymap.set('i', '<Tab>', function()
    ls.jump(1)
  end, { noremap = true, silent = true })

  vim.keymap.set('s', '<Tab>', function()
    ls.jump(1)
  end, { noremap = true, silent = true })

  vim.keymap.set('i', '<C-o>', function()
    ls.jump( -1)
  end, { noremap = true, silent = true })

  vim.keymap.set('s', '<C-o>', function()
    ls.jump( -1)
  end, { noremap = true, silent = true })
end

return config
