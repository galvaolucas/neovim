-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.g.lazyvim_eslint_auto_format = false

-- ── Speed ────────────────────────────────────────────────────
-- Neovim starts a host process for each enabled provider even when no
-- plugin uses it. Nothing here needs python/ruby/perl/node remote plugins.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.opt.termguicolors = true
vim.opt.updatetime = 200

-- ── Cozy ─────────────────────────────────────────────────────
-- Soft, thin window chrome instead of the default heavy glyphs, and no
-- `~` filler past the end of a buffer.
vim.opt.fillchars = {
  eob = " ",
  fold = " ",
  foldopen = "▾",
  foldclose = "▸",
  foldsep = " ",
  diff = "╱",
  horiz = "─",
  horizup = "┴",
  horizdown = "┬",
  vert = "│",
  vertleft = "┤",
  vertright = "├",
  verthoriz = "┼",
}

vim.opt.scrolloff = 8 -- keep the cursor away from the window edges
vim.opt.sidescrolloff = 8
vim.opt.smoothscroll = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes" -- never let the gutter pop in and shift text
vim.opt.pumheight = 12 -- shorter, less overwhelming completion menu
vim.opt.laststatus = 3 -- one global statusline across all splits

-- Don't autoformat these on save.
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "ts", "js", "tsx", "jsx", "css", "scss", "html", "json", "yaml" },
  callback = function()
    vim.b.autoformat = false
  end,
})
