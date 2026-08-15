-- Task runner. Previously init.lua called `require("overseer").setup()`
-- directly at startup, which dragged in overseer's DAP integration and
-- through it all of nvim-dap — ~31ms before you'd typed anything. Now it
-- loads on first use, and `opts` handles setup().
return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerRun",
    "OverseerToggle",
    "OverseerOpen",
    "OverseerBuild",
    "OverseerInfo",
    "OverseerRunCmd",
    "OverseerQuickAction",
    "OverseerTaskAction",
  },
  keys = {
    { "<leader>ow", "<cmd>OverseerToggle<cr>", desc = "Overseer toggle" },
    { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer run" },
  },
  opts = {},
}
