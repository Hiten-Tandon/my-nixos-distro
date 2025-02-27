-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g["conjure#client#scheme#stdio#command"] = "petite"
vim.g["conjure#client#scheme#stdio#value_prefix_pattern"] = false
vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "> "
vim.g.markdown_fenced_languages = {
  "ts=typescript",
}
vim.o.scrolloff = math.floor(vim.api.nvim_win_get_height(0) / 2)
vim.o.exrc = true
vim.o.secure = true
vim.o.clipboard = ""
vim.g["mkdp_auto_start"] = true
