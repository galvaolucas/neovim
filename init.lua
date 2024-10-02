vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- put this after lazy setup
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- To load all integrations at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end
