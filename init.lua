-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.autocmds")
require("config.options")
require("config.keymaps")
require("overseer").setup()
require("maple.lualine")

-- vim.cmd("colorscheme kanagawa-wave")
vim.cmd("colorscheme maple")
