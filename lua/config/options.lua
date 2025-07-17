-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- -- Set to false to disable auto format
vim.g.lazyvim_eslint_auto_format = false

vim.opt.laststatus = 2 -- Or 3 for global statusline
vim.opt.statusline = " %f %m %= %l:%c ♥ "

-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "ts", "js", "tsx", "jsx", "css", "scss", "html", "json", "yaml" },
  callback = function()
    vim.b.autoformat = false
  end,
})
