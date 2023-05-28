local lspconfig = require('lspconfig')
local M = {
    function(server_name) -- default handler (optional)
      lspconfig[server_name].setup {}
    end,
}

local T = {}

local notify = vim.notify
function T.notify(msg, ...)
  if msg:match("warning: multiple different client offset_encodings") then
    return
  end
  if msg == 'No code actions available' then
    return
  end
  notify(msg, ...)
end

---@diagnostic disable-next-line: unused-local
function T.attach(client, bufnr)
  vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
  client.server_capabilities.semanticTokensProvider = nil
  vim.notify = T.notify
end

M.gopls = function()
  lspconfig.gopls.setup({
      cmd = { 'gopls', 'serve' },
      on_attach = T.attach,
      init_options = {
          usePlaceholders = true,
          completeUnimported = true,
      },
      settings = {
          gopls = {
              analyses = {
                  unusedparams = true,
              },
              -- semanticTokens = true,
              -- staticcheck = true,
          },
      },
  })
end

M.lua_ls = function()
  lspconfig.lua_ls.setup({
      on_attach = T.attach,
      settings = {
          Lua = {
              diagnostics = {
                  enable = true,
                  globals = { 'vim' },
              },
              runtime = {
                  version = 'LuaJIT',
                  path = vim.split(package.path, ';'),
              },
              workspace = {
                  library = {
                      vim.env.VIMRUNTIME,
                      vim.env.HOME .. '/.local/share/nvim/lazy/emmylua-nvim',
                  },
                  checkThirdParty = false,
              },
              completion = {
                  callSnippet = 'Replace',
              },
          },
      },
  })
end

M.clangd = function()
  local notify = vim.notify
  lspconfig.clangd.setup({
      on_attach = T.attach,
      cmd = {
          'clangd',
          '--background-index',
          '--suggest-missing-includes',
          '--clang-tidy',
          '--header-insertion=iwyu',
      },
  })
end

M.rust_analyzer = function()
  lspconfig.rust_analyzer.setup({
      on_attach = T.attach,
      settings = {
          ['rust-analyzer'] = {
              imports = {
                  granularity = {
                      group = 'module',
                  },
                  prefix = 'self',
              },
              cargo = {
                  buildScripts = {
                      enable = true,
                  },
              },
              procMacro = {
                  enable = false,
              },
          },
      },
  })
end

return M
