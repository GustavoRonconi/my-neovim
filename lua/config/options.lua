-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- disable vim copy on select
vim.api.nvim_set_keymap("x", "y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "d", '"_d', { noremap = true, silent = true })

local dap_config_path = vim.fn.getcwd() .. "/.nvim/dap.lua"
local file_exists = vim.fn.filereadable(dap_config_path)

if file_exists == 1 then
  dofile(dap_config_path)
end
