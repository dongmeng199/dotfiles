return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      enable_git_status = true,
      enable_diagnostics = true,
      window = {
        position = "float",
        mappings = {
          ["l"] = "open",
        },
      },
      filesystem = {
        window = {
          mappings = {
            [",g"] = "prev_git_modified",
            [".g"] = "next_git_modified",
          },
        },
        commands = {}, -- Add a custom command or override a global one using the same function name
      },
    },

    keys = {
      {
        ";e",
        function()
          vim.cmd("Neotree reveal")
        end,
        desc = "Explorer NeoTree",
      },
      {
        ";b",
        function()
          vim.cmd("Neotree buffers")
        end,
        desc = "Explorer buffers",
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

      -- stylua: ignore start
      map("n", ",g", gs.next_hunk, "Next Hunk")
      map("n", ".g", gs.prev_hunk, "Prev Hunk")
      end,
    },
  },

  {
    "folke/todo-comments.nvim",
    keys = {
      {
        ".t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        ",t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "gopls",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<enter>",
          node_incremental = "<enter>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { [".f"] = "@function.outer", [".c"] = "@class.outer", [".a"] = "@parameter.inner" },
          goto_next_end = { [".F"] = "@function.outer", [".C"] = "@class.outer" },
          goto_previous_start = { [",f"] = "@function.outer", [",c"] = "@class.outer" },
          goto_previous_end = { [",F"] = "@function.outer", [",C"] = "@class.outer", [",a"] = "@parameter.inner" },
        },
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.",
            ["ia"] = "@parameter.inner",
            ["aa"] = "@parameter.outer",
          },
        },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- disable the keymap to grep files
      { "<leader>/", false },
      -- change a keymap
      { ";d", "<cmd>Telescope diagnostics<cr>", desc = "Find Files" },
      { ";f", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { ";z", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { ";a", "<cmd>Telescope live_grep<cr>", desc = "grep" },
      {
        ";s",
        function()
          require("telescope.builtin")["lsp_dynamic_workspace_symbols"]({
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },

      -- add a keymap to browse plugin files
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      for _, v in pairs(keys) do
        if v[1] == "]d" then
          v[1] = ".e"
        elseif v[1] == "[d" then
          v[1] = ",e"
        elseif v[1] == "<leader>ca" then
          v[1] = "ga"
        elseif v[1] == "<leader>cr" then
          v[1] = "gn"
        end
      end
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    keys = {
      {
        "<C-i>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<C-i>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<C-o>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },

    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        fish = { "fish" },
        go = { "golangcilint" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
      },
      linters = {},
    },
  },
  {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify", -- optional
    opts = {}, -- required even with default settings, since it calls `setup()`
  },

  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew" },
  },

  {
    "willothy/flatten.nvim",
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
}
