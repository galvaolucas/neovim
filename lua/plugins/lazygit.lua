-- Loads only when you actually open lazygit.
--
-- The telescope dependency is gone: it was pulled in purely for the
-- `lazygit` picker extension, which cost ~8ms of startup for a picker
-- that snacks already covers.
return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
}
