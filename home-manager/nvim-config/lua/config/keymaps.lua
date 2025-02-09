-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-w>m", "<Cmd>WindowsMaximize<CR>")
vim.keymap.set("n", "<C-w>_", "<Cmd>WindowsMaximizeVertically<CR>")
vim.keymap.set("n", "<C-w>|", "<Cmd>WindowsMaximizeHorizontally<CR>")
vim.keymap.set("n", "<C-w>=", "<Cmd>WindowsEqualize<CR>")
vim.keymap.set("n", "j", "jzz", { noremap = true, silent = true })
vim.keymap.set("n", "k", "kzz", { noremap = true, silent = true })
vim.keymap.set("n", "G", "Gzz", { noremap = true, silent = true })
vim.keymap.set("n", "gg", "ggzz", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", "jzz", { noremap = true, silent = true })
vim.keymap.set("n", "<Up>", "kzz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
