-- ~/.config/nvim/lua/maple_lualine.lua

local maple_lualine = {}

-- Colors from the maple theme palette
local colors = {
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
  grey = "#44444b",
}

-- Lualine theme using Maple colors
local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.magenta, gui = "bold" },
    b = { fg = colors.fg, bg = colors.grey },
    c = { fg = colors.fg, bg = colors.bg },
  },
  insert = {
    a = { fg = colors.black, bg = colors.blue, gui = "bold" },
  },
  visual = {
    a = { fg = colors.black, bg = colors.cyan, gui = "bold" },
  },
  replace = {
    a = { fg = colors.black, bg = colors.red, gui = "bold" },
  },
  inactive = {
    a = { fg = colors.fg, bg = colors.black, gui = "bold" },
    b = { fg = colors.fg, bg = colors.black },
    c = { fg = colors.fg, bg = colors.bg },
  },
}

function maple_lualine.setup()
  require("lualine").setup({
    options = {
      theme = bubbles_theme,
      component_separators = "",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
      lualine_b = { "filename", "branch" },
      lualine_c = {
        "%=", -- Center alignment marker
      },
      lualine_x = {},
      lualine_y = { "filetype", "progress" },
      lualine_z = {
        { "location", separator = { right = "" }, left_padding = 2 },
      },
    },
    inactive_sections = {
      lualine_a = { "filename" },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "location" },
    },
    tabline = {},
    extensions = {},
  })
end

return maple_lualine
