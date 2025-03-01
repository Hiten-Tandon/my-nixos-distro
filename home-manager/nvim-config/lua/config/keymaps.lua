-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-w>m", "<Cmd>WindowsMaximize<CR>")
vim.keymap.set("n", "<C-w>_", "<Cmd>WindowsMaximizeVertically<CR>")
vim.keymap.set("n", "<C-w>|", "<Cmd>WindowsMaximizeHorizontally<CR>")
vim.keymap.set("n", "<C-w>=", "<Cmd>WindowsEqualize<CR>")
-- vim.keymap.set("i", "<Up>", "<Cmd>normal! kzz<CR>")
-- vim.keymap.set("i", "<Down>", "<Cmd>normal! jzz<CR>")
-- vim.keymap.set("i", "<Cr>", "<Cr><Cmd>normal! zz<CR>")
