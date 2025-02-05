return {
  -- Add a setup for your desired LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Customize the servers you want to configure here
      servers = {
        -- Add a specific configuration for pyright (or any other LSP)
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off", -- Disable type checking for Python
              },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true, -- Enable checking for unused parameters
              },
              staticcheck = true, -- Enable additional static checks
            },
          },
        },
        tsserver = {
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "rust",
      },
    },
  },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   dependencies = {
  --     "jose-elias-alvarez/nvim-lsp-ts-utils", -- Optional: Additional utilities for TypeScript
  --   },
  --   opts = function(_, opts)
  --     local null_ls = require("null-ls")
  --     vim.list_extend(opts.sources, {
  --       null_ls.builtins.formatting.prettier, -- Prettier for formatting
  --       null_ls.builtins.diagnostics.eslint_d, -- Eslint for linting
  --       null_ls.builtins.code_actions.eslint_d, -- Eslint for code actions
  --     })
  --   end,
  -- },
}
