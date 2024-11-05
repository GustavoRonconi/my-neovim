require("lspconfig").rust_analyzer.setup({})

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
}
