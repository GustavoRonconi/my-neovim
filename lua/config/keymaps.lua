-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-q>", ":close<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", '"', 'c"<C-r>"<Esc>', { noremap = true, silent = true })

local dap, dapui = require("dap"), require("dapui")

vim.keymap.set("n", "<F5>", function()
  dap.continue()
end)
vim.keymap.set("n", "<F10>", function()
  dap.step_over()
end)
vim.keymap.set("n", "<F11>", function()
  dap.step_into()
end)
vim.keymap.set("n", "<F12>", function()
  dap.step_out()
end)
vim.keymap.set("n", "<Leader>b", function()
  dap.toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>dl", function()
  dap.run_last()
end)
vim.keymap.set("n", "<leader>du", function()
  dapui.close()
end)

local copilot_panel = require("copilot.panel")

vim.keymap.set("n", "<Leader>oc", function()
  copilot_panel.open({ "botton", 0.4 })
end)
