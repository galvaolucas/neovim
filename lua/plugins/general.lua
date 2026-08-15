-- Extra CLI tools to auto-install via Mason.
-- (LazyVim's mason spec uses opts_extend on ensure_installed, so this list is
-- appended to the defaults rather than overwriting them.)
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua", -- Lua formatter
        "shellcheck", -- shell linter
        "shfmt", -- shell formatter
        -- flake8 intentionally dropped: Ruff (python.lua / lang.python extra) supersedes it.
      },
    },
  },
}
