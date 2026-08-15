-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.autocmds")
require("config.options")
require("config.keymaps")

-- The colorscheme is set in lua/plugins/themes.lua via LazyVim's own
-- `colorscheme` option. Every other scheme there is lazy, so
-- `:colorscheme <name>` still switches instantly at zero startup cost.
