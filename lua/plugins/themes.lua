-- Colorschemes.
--
-- maple (autumn) is active — my own theme. It runs transparent on purpose so
-- Ghostty's warm #1a1614 background and blur show through the whole window
-- instead of nvim painting a flat rectangle over it; the terminal and the
-- editor end up looking like one surface.
--
-- `autumn` rather than `spring`: Ghostty is on the `ember` palette (a warm
-- near-black), and maple's autumn side — parchment #EDE8DC on #1C1C1A, with
-- rust/amber/sage accents — sits on top of that without a colour clash.
-- Spring's #1F2B2F teal base would fight the warm ground showing through.
-- Swap `theme = "spring"` below to try it.
--
-- Everything else here is `lazy = true`: lazy.nvim auto-loads a colorscheme
-- plugin the moment you `:colorscheme` it, so switching still works instantly
-- while none of them run setup() at startup.

-- ── The cozy layer ───────────────────────────────────────────
-- maple ships the palette and the syntax; this fills in the UI that came
-- after it was written (blink, snacks, bufferline, noice, which-key) and
-- softens the few groups that read loud on a dark warm ground. Same idea as
-- kanagawa's `overrides` block below — the theme stays untouched upstream.

-- Ghostty's `ember` background. maple is transparent, so this is the colour
-- that actually shows behind the buffer, and therefore the one that any
-- "slightly lifted" surface (cursor line, diff blocks, folds) has to be
-- mixed against. Note that maple rewrites `c.bg` and `c.border` to the
-- string "NONE" in transparent mode, so neither can be read back here.
local GROUND = "#1a1614"

local function blend(base, tint, alpha)
  local b, t = tonumber(base:sub(2), 16), tonumber(tint:sub(2), 16)
  local function mix(shift)
    local bc, tc = math.floor(b / shift) % 256, math.floor(t / shift) % 256
    return math.floor(bc + (tc - bc) * alpha + 0.5)
  end
  return string.format("#%02x%02x%02x", mix(65536), mix(256), mix(1))
end

local function cozy(theme)
  local c = require("maple.palette").colors(theme)

  -- Surfaces, all derived from the ground so they stay a *lift* rather than
  -- a panel: opaque enough to read as a band, dark enough to keep the blur.
  local ember = blend(GROUND, c.orange, 0.10) -- cursor line
  local sel = blend(GROUND, c.parchment, 0.16) -- visual / menu selection
  local sunk = blend(GROUND, "#000000", 0.45) -- windows that sit "behind"
  local fill = blend(GROUND, c.fg, 0.08) -- faint fills
  local hair = blend(GROUND, c.fg, 0.14) -- splits, indent guides
  local edge = blend(GROUND, c.brown, 0.70) -- float borders

  local groups = {
    -- ── Editor chrome ──
    -- maple's transparent path re-sets Normal with only a `bg`, and
    -- nvim_set_hl replaces the whole group rather than merging — so the
    -- theme's own foreground is dropped and body text falls back to
    -- whatever Ghostty's default fg happens to be. Put the parchment back.
    Normal = { fg = c.fg, bg = "NONE" },
    NormalNC = { fg = c.fg, bg = "NONE" },

    CursorLine = { bg = ember },
    CursorColumn = { bg = ember },
    -- Amber to match Ghostty's cursor, instead of maple's plain white.
    CursorLineNr = { fg = c.cursor, bold = true },
    -- maple uses `comment` here, which is bright enough to compete with the
    -- code itself; the gutter should recede.
    LineNr = { fg = c.brown },
    LineNrAbove = { link = "LineNr" },
    LineNrBelow = { link = "LineNr" },
    SignColumn = { bg = "NONE" },
    FoldColumn = { fg = c.brown, bg = "NONE" },
    Folded = { fg = c.comment, bg = fill, italic = true },
    Visual = { bg = sel },
    VisualNOS = { bg = sel },
    MatchParen = { fg = c.cursor, bg = blend(GROUND, c.cursor, 0.18), bold = true },
    NonText = { fg = hair },
    Whitespace = { link = "NonText" },
    SpecialKey = { link = "NonText" },
    EndOfBuffer = { fg = fill, bg = "NONE" },
    Conceal = { fg = c.brown },
    WinSeparator = { fg = hair, bg = "NONE" },
    -- Was the raw border brown — a solid bar down the buffer.
    ColorColumn = { bg = fill },
    QuickFixLine = { bg = ember, bold = true },

    -- Only the match under the cursor gets the loud amber block; the rest
    -- are tinted so a search doesn't repaint the file.
    Search = { fg = c.parchment, bg = blend(GROUND, c.yellow, 0.22) },
    IncSearch = { fg = c.black, bg = c.cursor, bold = true },
    CurSearch = { link = "IncSearch" },
    Substitute = { link = "IncSearch" },

    -- ── Floats ──
    NormalFloat = { fg = c.fg, bg = "NONE" },
    FloatBorder = { fg = edge, bg = "NONE" },
    FloatTitle = { fg = c.orange, bg = "NONE", bold = true },
    WinBar = { fg = c.parchment, bg = "NONE", bold = true },
    WinBarNC = { fg = c.brown, bg = "NONE" },

    -- Windows that should feel set back from the buffer rather than floating
    -- over it — otherwise their long lists read straight through the blur.
    LazyNormal = { fg = c.fg, bg = sunk },
    MasonNormal = { fg = c.fg, bg = sunk },
    NormalDark = { fg = c.comment, bg = sunk },

    -- ── Statusline / tabline ──
    StatusLine = { fg = c.comment, bg = "NONE" },
    StatusLineNC = { fg = c.brown, bg = "NONE" },
    TabLine = { fg = c.brown, bg = "NONE" },
    TabLineFill = { bg = "NONE" },
    TabLineSel = { fg = c.parchment, bg = "NONE", bold = true },

    -- ── Popup menu ──
    Pmenu = { fg = c.fg, bg = "NONE", blend = vim.o.pumblend },
    PmenuSel = { bg = sel, bold = true },
    PmenuSbar = { bg = fill },
    PmenuThumb = { bg = blend(GROUND, c.fg, 0.25) },
    PmenuMatch = { fg = c.orange, bold = true },

    -- ── Syntax ──
    -- maple's `italic = true` path sets these four with no `fg`, and
    -- nvim_set_hl replaces rather than merges — so keywords come out
    -- colourless. This runs after maple's own ColorScheme handlers and puts
    -- the magenta back. Bold on every keyword also reads shouty here, so
    -- it's italic only.
    Keyword = { fg = c.magenta, italic = true },
    ["@keyword"] = { fg = c.magenta, italic = true },
    ["@keyword.function"] = { fg = c.magenta, italic = true },
    ["@operator"] = { fg = c.magenta },
    Comment = { fg = c.comment, italic = true },

    -- Groups added to treesitter after maple was written; without these they
    -- fall through to the terminal's own colours.
    ["@variable.builtin"] = { fg = c.red, italic = true },
    ["@variable.parameter"] = { fg = c.parchment },
    ["@constant.builtin"] = { fg = c.orange },
    ["@constructor"] = { fg = c.yellow },
    ["@module"] = { fg = c.parchment },
    ["@attribute"] = { fg = c.cyan },
    ["@string.escape"] = { fg = c.orange },
    ["@string.special"] = { fg = c.orange },
    ["@comment.todo"] = { fg = c.cyan, bold = true },
    ["@comment.note"] = { fg = c.blue, bold = true },
    ["@comment.warning"] = { fg = c.yellow, bold = true },
    ["@comment.error"] = { fg = c.bright_red, bold = true },
    ["@markup.heading"] = { fg = c.orange, bold = true },
    ["@markup.link"] = { fg = c.blue, underline = true },
    ["@markup.raw"] = { fg = c.green },
    ["@markup.list"] = { fg = c.orange },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },

    -- ── Diagnostics ──
    -- maple points DiagnosticWarn at `columbia_blue`, which isn't in either
    -- palette, so warnings render with no colour at all.
    DiagnosticError = { fg = c.bright_red },
    DiagnosticWarn = { fg = c.yellow },
    DiagnosticInfo = { fg = c.blue },
    DiagnosticHint = { fg = c.cyan },
    DiagnosticOk = { fg = c.green },
    -- Undercurls belong on `sp`; as `fg` they recolour the code underneath.
    DiagnosticUnderlineError = { undercurl = true, sp = c.bright_red },
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.yellow },
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.blue },
    DiagnosticUnderlineHint = { undercurl = true, sp = c.cyan },
    DiagnosticVirtualTextError = { fg = blend(GROUND, c.bright_red, 0.60), italic = true },
    DiagnosticVirtualTextWarn = { fg = blend(GROUND, c.yellow, 0.60), italic = true },
    DiagnosticVirtualTextInfo = { fg = blend(GROUND, c.blue, 0.60), italic = true },
    DiagnosticVirtualTextHint = { fg = blend(GROUND, c.cyan, 0.60), italic = true },
    DiagnosticUnnecessary = { fg = c.brown, italic = true },

    -- ── Diff ──
    -- maple hardcodes four pastel *backgrounds* (#a4dfae and friends) with no
    -- foreground — on a dark theme those are unreadable light slabs. Same
    -- hues, mixed down into the ground instead.
    DiffAdd = { bg = blend(GROUND, c.green, 0.18) },
    DiffChange = { bg = blend(GROUND, c.blue, 0.14) },
    DiffDelete = { fg = blend(GROUND, c.red, 0.45), bg = blend(GROUND, c.red, 0.14) },
    DiffText = { bg = blend(GROUND, c.blue, 0.30) },
    Added = { fg = c.green },
    Changed = { fg = c.blue },
    Removed = { fg = c.bright_red },

    -- ── Git ──
    -- gitsigns paints the blame at end-of-line on every cursor move; at full
    -- comment brightness it pulls the eye off the code.
    GitSignsCurrentLineBlame = { fg = c.brown, italic = true },

    -- ── LSP ──
    LspInlayHint = { fg = c.brown, bg = "NONE", italic = true },
    LspSignatureActiveParameter = { fg = c.orange, bold = true },
    LspReferenceText = { bg = blend(GROUND, c.fg, 0.10) },
    LspReferenceRead = { link = "LspReferenceText" },
    LspReferenceWrite = { link = "LspReferenceText" },
    IlluminatedWordText = { link = "LspReferenceText" },
    IlluminatedWordRead = { link = "LspReferenceText" },
    IlluminatedWordWrite = { link = "LspReferenceText" },
    TreesitterContext = { bg = fill },
    TreesitterContextLineNumber = { fg = c.brown },

    -- ── blink.cmp ──
    BlinkCmpMenu = { fg = c.fg, bg = "NONE" },
    BlinkCmpMenuBorder = { fg = edge, bg = "NONE" },
    BlinkCmpMenuSelection = { bg = sel, bold = true },
    BlinkCmpScrollBarGutter = { bg = fill },
    BlinkCmpScrollBarThumb = { bg = blend(GROUND, c.fg, 0.25) },
    BlinkCmpLabel = { fg = c.fg },
    BlinkCmpLabelMatch = { fg = c.orange, bold = true },
    BlinkCmpLabelDeprecated = { fg = c.brown, strikethrough = true },
    BlinkCmpLabelDescription = { fg = c.comment },
    BlinkCmpLabelDetail = { fg = c.comment },
    BlinkCmpKind = { fg = c.cyan },
    BlinkCmpSource = { fg = c.brown },
    BlinkCmpDoc = { fg = c.fg, bg = "NONE" },
    BlinkCmpDocBorder = { fg = edge, bg = "NONE" },
    BlinkCmpDocSeparator = { fg = edge, bg = "NONE" },
    BlinkCmpSignatureHelp = { fg = c.fg, bg = "NONE" },
    BlinkCmpSignatureHelpBorder = { fg = edge, bg = "NONE" },
    BlinkCmpSignatureHelpActiveParameter = { fg = c.orange, bold = true },
    BlinkCmpGhostText = { fg = c.brown, italic = true },

    -- ── snacks (picker, explorer, dashboard, indent, notifier) ──
    SnacksNormal = { fg = c.fg, bg = "NONE" },
    SnacksNormalNC = { fg = c.fg, bg = "NONE" },
    SnacksWinBar = { fg = c.orange, bg = "NONE", bold = true },
    SnacksPicker = { fg = c.fg, bg = "NONE" },
    SnacksPickerBorder = { fg = edge, bg = "NONE" },
    SnacksPickerTitle = { fg = c.orange, bg = "NONE", bold = true },
    SnacksPickerInputBorder = { fg = edge, bg = "NONE" },
    SnacksPickerInputTitle = { fg = c.orange, bg = "NONE", bold = true },
    SnacksPickerPrompt = { fg = c.green },
    SnacksPickerMatch = { fg = c.orange, bold = true },
    SnacksPickerDir = { fg = c.brown },
    SnacksPickerPathHidden = { fg = c.brown },
    SnacksPickerPathIgnored = { fg = c.brown, italic = true },
    SnacksPickerDirectory = { fg = c.parchment },
    SnacksPickerGitStatusUntracked = { fg = c.brown },
    SnacksDashboardHeader = { fg = c.orange },
    SnacksDashboardFooter = { fg = c.brown, italic = true },
    SnacksDashboardIcon = { fg = c.yellow },
    SnacksDashboardDesc = { fg = c.fg },
    SnacksDashboardKey = { fg = c.cyan },
    SnacksDashboardTitle = { fg = c.parchment, bold = true },
    SnacksDashboardSpecial = { fg = c.magenta },
    SnacksIndent = { fg = fill },
    SnacksIndentScope = { fg = blend(GROUND, c.orange, 0.35) },
    SnacksNotifierInfo = { fg = c.blue, bg = "NONE" },
    SnacksNotifierWarn = { fg = c.yellow, bg = "NONE" },
    SnacksNotifierError = { fg = c.bright_red, bg = "NONE" },
    SnacksNotifierDebug = { fg = c.brown, bg = "NONE" },
    SnacksNotifierBorderInfo = { fg = edge, bg = "NONE" },
    SnacksNotifierBorderWarn = { fg = edge, bg = "NONE" },
    SnacksNotifierBorderError = { fg = edge, bg = "NONE" },
    SnacksInputBorder = { fg = edge, bg = "NONE" },
    SnacksInputTitle = { fg = c.orange, bg = "NONE", bold = true },

    -- ── bufferline ──
    BufferLineFill = { bg = "NONE" },
    BufferLineBackground = { fg = c.brown, bg = "NONE" },
    BufferLineBufferVisible = { fg = c.comment, bg = "NONE" },
    BufferLineBufferSelected = { fg = c.parchment, bg = "NONE", bold = true },
    BufferLineIndicatorSelected = { fg = c.orange, bg = "NONE" },
    BufferLineIndicatorVisible = { fg = hair, bg = "NONE" },
    BufferLineSeparator = { fg = hair, bg = "NONE" },
    BufferLineSeparatorVisible = { fg = hair, bg = "NONE" },
    BufferLineSeparatorSelected = { fg = hair, bg = "NONE" },
    BufferLineOffsetSeparator = { fg = hair, bg = "NONE" },
    BufferLineModified = { fg = c.green, bg = "NONE" },
    BufferLineModifiedVisible = { fg = c.green, bg = "NONE" },
    BufferLineModifiedSelected = { fg = c.green, bg = "NONE" },
    BufferLineDuplicate = { fg = c.brown, bg = "NONE", italic = true },
    BufferLineDuplicateVisible = { fg = c.brown, bg = "NONE", italic = true },
    BufferLineDuplicateSelected = { fg = c.comment, bg = "NONE", italic = true },
    BufferLineTruncMarker = { fg = c.brown, bg = "NONE" },
    BufferLineError = { fg = c.brown, bg = "NONE" },
    BufferLineErrorSelected = { fg = c.bright_red, bg = "NONE" },
    BufferLineWarning = { fg = c.brown, bg = "NONE" },
    BufferLineWarningSelected = { fg = c.yellow, bg = "NONE" },

    -- ── which-key ──
    WhichKey = { fg = c.orange },
    WhichKeyGroup = { fg = c.blue },
    WhichKeyDesc = { fg = c.fg },
    WhichKeySeparator = { fg = c.brown },
    WhichKeyValue = { fg = c.comment },
    WhichKeyFloat = { bg = "NONE" },
    WhichKeyNormal = { bg = "NONE" },
    WhichKeyBorder = { fg = edge, bg = "NONE" },
    WhichKeyTitle = { fg = c.orange, bg = "NONE", bold = true },

    -- ── noice ──
    NoicePopup = { bg = "NONE" },
    NoicePopupBorder = { fg = edge, bg = "NONE" },
    NoiceCmdlinePopup = { bg = "NONE" },
    NoiceCmdlinePopupBorder = { fg = edge, bg = "NONE" },
    NoiceCmdlinePopupTitle = { fg = c.orange, bold = true },
    NoiceCmdlineIcon = { fg = c.orange },
    NoiceCmdlineIconSearch = { fg = c.yellow },
    NoiceConfirm = { bg = "NONE" },
    NoiceConfirmBorder = { fg = edge, bg = "NONE" },
    NoiceMini = { bg = "NONE" },
    NoiceVirtualText = { fg = c.orange },
  }

  for group, opts in pairs(groups) do
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- :terminal and lazygit inherit these, so the embedded UIs land on the same
  -- palette as the editor instead of the default ANSI set.
  local ansi = {
    c.black,
    c.red,
    c.green,
    c.yellow,
    c.blue,
    c.magenta,
    c.cyan,
    c.fg,
    c.brown,
    c.bright_red,
    c.bright_green,
    c.bright_yellow,
    c.bright_blue,
    c.bright_magenta,
    c.bright_cyan,
    c.bright_white,
  }
  for i, color in ipairs(ansi) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end
end

return {
  -- LazyVim normally applies the colorscheme itself, but it does so from
  -- inside `require("lazy").setup()` — before a single plugin has loaded.
  -- That is too early for maple: loading maple also builds the statusline,
  -- which drags lualine in with it, and LazyVim's lualine spec reaches for
  -- the `Snacks` global while assembling its sections. So LazyVim gets a
  -- no-op and maple applies itself from its own spec, ordered just behind
  -- snacks.nvim (priority 1000). Still the first thing to load, so there's
  -- no flash of default colors.
  { "LazyVim/LazyVim", opts = { colorscheme = function() end } },

  {
    "galvaolucas/maple.nvim",
    lazy = false,
    priority = 900,
    opts = { theme = "autumn", transparent = true, italic = true },
    config = function(_, opts)
      require("maple").setup(opts)

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "maple",
        callback = function()
          -- maple registers its own ColorScheme handlers while its colors
          -- file is being sourced — i.e. after this one — so a straight
          -- call here would be overwritten by them. One tick later puts the
          -- cozy layer last, whichever order the handlers run in.
          vim.schedule(function()
            cozy(opts.theme)
          end)
        end,
      })

      vim.cmd.colorscheme("maple")
    end,
  },

  -- ── Alternates (lazy; `:colorscheme <name>` loads them on demand) ──
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
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
}
