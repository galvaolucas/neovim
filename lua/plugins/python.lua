return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Disable pylsp — pycodestyle conflicts with Ruff's line-length = 88
        pylsp = { enabled = false },
        ruff = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },
}
