-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Load LSP config from .nvim directory if it exists
local workspace_lsp_config = vim.fn.getcwd() .. "/.nvim/workspace_config.lua"
if vim.fn.filereadable(workspace_lsp_config) == 1 then
  dofile(workspace_lsp_config)
end
