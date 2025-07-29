-- ~/.config/nvim/lua/colors/maple.lua

local maple = {}

-- Palette based on your VSCode Maple colors (6-digit hex only)
maple.colors = {
  bg = "#1e1e1f",
  fg = "#cbd5e1",
  red = "#edabab",
  green = "#a4dfae",
  yellow = "#eecfa0",
  blue = "#8fc7ff",
  magenta = "#d2ccff",
  cyan = "#a1e8e5",
  white = "#f3f2f2",
  black = "#333333",

  bright_black = "#666666",
  bright_red = "#ffc4c4",
  bright_green = "#bdf8c7",
  bright_yellow = "#ffe8b9",
  bright_blue = "#a8e0ff",
  bright_magenta = "#ebe5ff",
  bright_cyan = "#bafffe",
  bright_white = "#ffffff",

  cursor = "#8d9db4",
  selection = "#475569",
  comment = "#999999",
  border = "#44444b",
}

local function hi(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

function maple.setup(opts)
  opts = opts or {}
  local transparent = opts.transparent or false
  local c = maple.colors

  if transparent then
    c.bg = "NONE"
    c.border = "NONE"
    c.selection = "#333333"
  end

  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.background = "dark"
  vim.g.colors_name = "maple"

  hi("Normal", { fg = c.fg, bg = c.bg })
  hi("Cursor", { fg = c.bg, bg = c.cursor })
  hi("Visual", { bg = c.selection })
  hi("LineNr", { fg = c.comment })
  hi("CursorLineNr", { fg = c.white, bold = true })
  hi("Comment", { fg = c.comment, italic = true })
  hi("StatusLine", { fg = c.fg, bg = c.border })
  hi("VertSplit", { fg = c.border })
  hi("WinSeparator", { fg = c.border })

  hi("Identifier", { fg = c.cyan })
  hi("Function", { fg = c.blue })
  hi("Statement", { fg = c.magenta })
  hi("Keyword", { fg = c.magenta, bold = true })
  hi("Type", { fg = c.yellow })
  hi("String", { fg = c.green })
  hi("Number", { fg = c.yellow })
  hi("Boolean", { fg = c.red })
  hi("Constant", { fg = c.cyan })

  hi("DiagnosticError", { fg = c.red, undercurl = false })
  hi("DiagnosticWarn", { fg = c.yellow, undercurl = false })
  hi("DiagnosticInfo", { fg = c.blue, undercurl = false })
  hi("DiagnosticHint", { fg = c.cyan, undercurl = false })
  hi("DiagnosticUnderlineError", { fg = c.red, undercurl = true })
  hi("DiagnosticUnderlineWarn", { fg = c.yellow, undercurl = true })
  hi("DiagnosticUnderlineInfo", { fg = c.blue, undercurl = false })
  hi("DiagnosticUnderlineHint", { fg = c.cyan, undercurl = false })

  hi("GitSignsAdd", { fg = c.green })
  hi("GitSignsChange", { fg = c.blue })
  hi("GitSignsDelete", { fg = c.red })

  hi("DiffAdd", { bg = "#a4dfae" })
  hi("DiffChange", { bg = "#8fc7ff" })
  hi("DiffDelete", { bg = "#edabab" })
  hi("DiffText", { bg = "#8fc7ff" })

  hi("TelescopeBorder", { fg = c.border, bg = c.bg })
  hi("TelescopePromptBorder", { fg = c.border, bg = c.bg })
  hi("TelescopeResultsBorder", { fg = c.border, bg = c.bg })
  hi("TelescopePreviewBorder", { fg = c.border, bg = c.bg })
  hi("TelescopePromptNormal", { fg = c.fg, bg = c.bg })
  hi("TelescopePromptPrefix", { fg = c.green, bg = c.bg })
  hi("TelescopePromptTitle", { fg = c.green, bg = c.bg, bold = true })
  hi("TelescopeResultsTitle", { fg = c.fg, bg = c.bg })
  hi("TelescopePreviewTitle", { fg = c.fg, bg = c.bg })
  hi("TelescopeSelection", { fg = c.black, bg = c.green, bold = true })
  hi("TelescopeMultiSelection", { fg = c.green, bg = c.bg })
  hi("TelescopeMatching", { fg = c.yellow, bold = true })

  hi("@comment", { fg = c.comment, italic = true })
  hi("@keyword", { fg = c.magenta, bold = true })
  hi("@keyword.function", { fg = c.magenta })
  hi("@function", { fg = c.blue })
  hi("@function.call", { fg = c.blue })
  hi("@method", { fg = c.blue })
  hi("@variable", { fg = c.fg })
  hi("@property", { fg = c.cyan })
  hi("@field", { fg = c.cyan })
  hi("@string", { fg = c.green })
  hi("@number", { fg = c.yellow })
  hi("@boolean", { fg = c.red })
  hi("@constant", { fg = c.cyan })
  hi("@type", { fg = c.yellow })
  hi("@namespace", { fg = c.magenta })
  hi("@operator", { fg = c.magenta })
  hi("@parameter", { fg = c.fg })
  hi("@punctuation.delimiter", { fg = c.fg })
  hi("@punctuation.bracket", { fg = c.fg })

  hi("@lsp.type.namespace", { link = "@namespace" })
  hi("@lsp.type.type", { link = "@type" })
  hi("@lsp.type.class", { link = "@type" })
  hi("@lsp.type.enum", { link = "@type" })
  hi("@lsp.type.interface", { link = "@type" })
  hi("@lsp.type.struct", { link = "@type" })
  hi("@lsp.type.parameter", { link = "@parameter" })
  hi("@lsp.type.variable", { link = "@variable" })
  hi("@lsp.type.property", { link = "@property" })
  hi("@lsp.type.enumMember", { link = "@constant" })
  hi("@lsp.type.function", { link = "@function" })
  hi("@lsp.type.method", { link = "@method" })
  hi("@lsp.type.macro", { link = "@function" })

  hi("Pmenu", { fg = c.fg, bg = c.bg })
  hi("PmenuSel", { fg = c.black, bg = c.green })
  hi("PmenuSbar", { bg = c.selection })
  hi("PmenuThumb", { bg = c.selection })
  hi("CursorLine", { bg = c.selection })
  hi("ColorColumn", { bg = c.border })
  hi("StatusLineNC", { fg = c.comment, bg = c.border })
  hi("TabLine", { fg = c.comment, bg = c.border })
  hi("TabLineFill", { bg = c.border })
  hi("TabLineSel", { fg = c.fg, bg = c.selection })
  hi("VisualNOS", { fg = c.red, bg = c.bg })

  hi("Search", { bg = c.yellow, fg = c.black })
  hi("IncSearch", { bg = c.yellow, fg = c.black, bold = true })

  hi("CursorLineNr", { fg = c.white, bold = true })

  hi("LualineInsertA", { fg = c.white, bg = c.magenta, bold = true })

  -- Transparency fix for sidebars and floating windows
  if transparent then
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "maple",
      callback = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "NONE", bg = "NONE" })

        -- Sidebars
        vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })

        -- Telescope
        vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE" })
      end,
    })
  end
end

return maple
