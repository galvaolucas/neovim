-- Colorschemes.
--
-- kanagawa-wave is active (see init.lua). It's transparent on purpose so
-- Ghostty's warm #1a1614 background and blur show through the whole
-- window instead of nvim painting a flat rectangle over them — the
-- terminal and the editor end up looking like one surface.
--
-- Everything else is `lazy = true`: lazy.nvim auto-loads a colorscheme
-- plugin the moment you `:colorscheme` it, so switching still works
-- instantly while none of them run setup() at startup.
return {
  -- Tell LazyVim which scheme to use rather than calling :colorscheme
  -- ourselves — otherwise LazyVim loads its default (tokyonight) first and
  -- we'd pay for two colorschemes on every start.
  { "LazyVim/LazyVim", opts = { colorscheme = "kanagawa-wave" } },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Caches the compiled highlight groups to disk. Run :KanagawaCompile
      -- after editing anything below, or the old cache keeps winning.
      compile = true,
      transparent = true,
      terminalColors = true,
      dimInactive = false, -- would fight the transparency
      theme = "wave",
      background = { dark = "wave" },
      commentStyle = { italic = true },
      keywordStyle = { italic = false },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        local palette = colors.palette

        return {
          -- Borderless, transparent floats.
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none", fg = theme.ui.bg_p2 },
          FloatTitle = { bg = "none", fg = palette.surimiOrange, bold = true },

          -- A darker, opaque surface for windows that should feel "set back"
          -- from the buffer (terminals, Lazy, Mason).
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          -- Warm cursor line + a lit line number to anchor the eye.
          CursorLine = { bg = theme.ui.bg_p1 },
          CursorLineNr = { fg = palette.surimiOrange, bold = true },
          LineNr = { fg = theme.ui.nontext },

          -- Hairline splits instead of the default hard divider.
          WinSeparator = { fg = theme.ui.bg_p2, bg = "none" },

          -- Completion menu: no hard background, selection warms up.
          Pmenu = { fg = theme.ui.shade0, bg = "none", blend = vim.o.pumblend },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          -- snacks.picker / dashboard
          SnacksPickerDir = { fg = theme.ui.nontext },
          SnacksPickerMatch = { fg = palette.surimiOrange, bold = true },
          SnacksDashboardHeader = { fg = palette.surimiOrange },
          SnacksDashboardFooter = { fg = theme.ui.nontext, italic = true },
          SnacksDashboardIcon = { fg = palette.carpYellow },
          SnacksDashboardDesc = { fg = theme.ui.fg },
          SnacksDashboardKey = { fg = palette.springBlue },
          SnacksIndent = { fg = theme.ui.bg_p2 },
          SnacksIndentScope = { fg = theme.ui.bg_p2 },
        }
      end,
    },
  },

  -- ── Alternates (lazy; `:colorscheme <name>` loads them on demand) ──
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night", transparent = true, styles = { sidebars = "transparent", floats = "transparent" } },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = { styles = { transparency = true } },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = { transparent_background = true },
  },
  -- Your own theme — kept around, no longer eager. Nothing requires it at
  -- startup now that lualine uses the active colorscheme's palette.
  {
    "galvaolucas/maple.nvim",
    lazy = true,
    opts = { theme = "spring", transparent = true, italic = true },
  },
}
