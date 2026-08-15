-- Pretty markdown rendering, loaded only for markdown buffers.
-- Icons come from mini.icons (already set up by LazyVim), so the
-- nvim-web-devicons dependency is gone.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "codecompanion" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    heading = { sign = false, width = "block", left_pad = 1, right_pad = 2 },
    code = { sign = false, width = "block", left_pad = 1, right_pad = 2 },
  },
}
