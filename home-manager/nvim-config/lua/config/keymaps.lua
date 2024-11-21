-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set(
  { "n", "v" },
  "<leader>ks",
  require("keep-it-secret").toggle,
  { noremap = true, silent = true, desc = "Toggle secret" }
)
