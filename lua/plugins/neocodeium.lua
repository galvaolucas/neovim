-- AI completion. Nothing it does matters outside insert mode, so it
-- loads there rather than on VeryLazy.
return {
  "monkoose/neocodeium",
  event = "InsertEnter",
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup()
    vim.keymap.set("i", "<A-f>", neocodeium.accept, { desc = "Accept AI suggestion" })
  end,
}
