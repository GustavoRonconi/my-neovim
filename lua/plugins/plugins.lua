return {
  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer", -- Buffer completions
      "hrsh7th/cmp-path", -- Path completions
      "saadparwaiz1/cmp_luasnip", -- Snippet completions
      "L3MON4D3/LuaSnip", -- Snippet engine
      "rafamadriz/friendly-snippets", -- Predefined snippets
    },
    config = function()
      -- Setup nvim-cmp.
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("cmp").setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    "tpope/vim-fugitive",
    event = "BufRead",
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    config = function()
      vim.g.VM_maps = {
        -- ["Select Cursor Up"] = "<C-k>",
        -- ["Select Cursor Down"] = "<C-j>",
        ["Add Cursor Up"] = "<C-k>",
        ["Add Cursor Down"] = "<C-j>",
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dap_python = require("dap-python")

      -- Set DAP configuration for Python
      local python_default = "/Users/gustavoandreronconi/miniconda3/envs/data-analysis/bin/python"
      dap_python.setup(python_default)

      -- Load workspace-specific DAP configuration, if it exists
      local workspace_dap_config = vim.fn.getcwd() .. "/.nvim/dap_config.lua"
      if vim.fn.filereadable(workspace_dap_config) == 1 then
        local dap_config = dofile(workspace_dap_config)
        dap.configurations.python = dap_config.configurations
      else
        -- Default fallback DAP configurations (if no workspace-specific config found)
        dap.configurations.python = {
          {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            pythonPath = function()
              return python_default
            end,
          },
        }
      end

      -- Set DAP configuration for Rust
      dap.adapters.lldb = {
        type = "executable",
        command = "/opt/homebrew/bin/lldb-dap", -- Adjust this path if needed
        name = "lldb",
      }

      dap.configurations.rust = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = function()
            local input = vim.fn.input("Command-line arguments: ")
            return vim.split(input, " ", { trimempty = true })
          end,
          -- If you want to use `rust-gdb` instead of `lldb`:
          runInTerminal = false,
        },
      }

      -- Set DAP configuration for Go
      dap.adapters.delve = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug Package",
          request = "launch",
          program = "${fileDirname}",
        },
        {
          type = "delve",
          name = "Attach to Process",
          request = "attach",
          processId = require("dap.utils").pick_process,
        },
        {
          type = "delve",
          name = "Debug Test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug Test Package",
          request = "launch",
          mode = "test",
          program = "${fileDirname}",
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup()

      -- Optionally open UI automatically when starting dap
      vim.fn.sign_define("DapBreakpoint", { text = "✋", texthl = "", linehl = "", numhl = "" })

      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
      -- -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   dapui.close()
      -- end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter", -- Loads when you enter Insert mode
    config = function()
      require("copilot").setup({
        suggestion = { enabled = true }, -- If you want to disable inline suggestions
        panel = { enabled = true }, -- If you don't want the floating panel
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "luk400/vim-jukit",
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>bkpo", ":call jukit#send#section(0)<CR>", { noremap = true, silent = true })
      -- Normal mode: send the current line to the output split
      vim.api.nvim_set_keymap("n", "<leader>rn", ":call jukit#send#line()<CR>", { noremap = true, silent = true })

      -- Visual mode: send the visually selected code to the output split
      vim.api.nvim_set_keymap(
        "v",
        "<leader>rn",
        ":<C-U>call jukit#send#selection()<CR>",
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Required for viewing clipboard history
      "tami5/sqlite.lua", -- Optional, but recommended for persistence
    },
    config = function()
      require("neoclip").setup({
        history = 1000, -- Set history length, adjust as needed
        enable_persistent_history = true,
      })
      require("telescope").load_extension("neoclip")
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    "hat0uma/csvview.nvim",
    config = function()
      require("csvview").setup()
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, {
        null_ls.builtins.formatting.prettier, -- Add Prettier as a formatter
      })
    end,
  },
}
