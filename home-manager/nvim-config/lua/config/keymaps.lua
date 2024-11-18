-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>ht", function()
  vim.cmd([[
    10sp
    setlocal nonumber norelativenumber
    startinsert
    nnoremap <buffer> <leader>ht :q<CR>
  ]])
end, { desc = "[H]orizontal [T]erminal" })

vim.keymap.set("n", "<leader>vt", function()
  vim.cmd([[
    60vsp
    setlocal nonumber norelativenumber
    startinsert
    nnoremap <buffer> <leader>ht :q<CR>
  ]])
end, { desc = "[V]ertical [T]erminal" })

