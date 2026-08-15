return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    explorer = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true, timeout = 2500 },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },

    indent = {
      enabled = true,
      indent = { char = "│" },
      scope = { char = "│" },
      animate = { enabled = false }, -- the scope line sliding around is distracting
    },

    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = "󰈞 ", key = "f", desc = "Find file", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = "󰈔 ", key = "n", desc = "New file", action = ":ene | startinsert" },
          { icon = "󰍉 ", key = "g", desc = "Grep", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = "󰋚 ", key = "r", desc = "Recent", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = "󰦛 ", key = "s", desc = "Last session", section = "session" },
          { icon = "󰊢 ", key = "l", desc = "Lazygit", action = ":LazyGit" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = "󰗼 ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
        ( (
         ) )
      ........
      |      |]
      \      /
       `----']],
      },
      sections = {
        { section = "header" },
        { text = "take your time", align = "center", hl = "SnacksDashboardFooter", padding = 1 },
        { section = "keys", gap = 0, padding = 1 },
        { section = "startup" },
      },
    },

    styles = {
      notification = { wo = { wrap = true } },
    },
  },
}
