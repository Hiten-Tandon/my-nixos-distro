-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(_)
    vim.lsp.inlay_hint.enable(true)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(_)
    vim.o.conceallevel = 2
  end,
})
--
-- vim.api.nvim_create_augroup("CenterCursorOnMove", { clear = true })
--
-- vim.api.nvim_create_autocmd("CursorMoved", {
--   group = "CenterCursorOnMove",
--   pattern = "*",
--   command = ":normal! zz",
-- })
