-- Cozy UI chrome: rounded, transparent, low-contrast.
return {
  -- Statusline: maple's own lualine extension, not LazyVim's layout.
  --
  -- `require("maple").load()` calls `lualine.setup()` itself with maple's
  -- sections (mode, filename, branch, diagnostics, diff, filetype, filesize,
  -- position, clock) and its matching theme, so the statusline is already
  -- built by the time the colorscheme finishes loading. Returning an empty
  -- table here drops LazyVim's own layout instead of assembling it a moment
  -- before maple replaces it.
  --
  -- `globalstatus` isn't set by maple, but lualine defaults it to
  -- `vim.go.laststatus == 3` — which config/options.lua already sets — so the
  -- single global statusline survives.
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      return {}
    end,
  },

  -- Soft, rounded bufferline with a slim indicator instead of a hard block.
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "thin",
        indicator = { style = "underline" },
        show_buffer_close_icons = false,
        show_close_icon = false,
        offsets = {
          { filetype = "snacks_layout_box", text = "", highlight = "Directory", text_align = "left" },
        },
      },
    },
  },

  -- Rounded borders on hovers, signatures and the command popup.
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      lsp = {
        signature = { enabled = true },
      },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
      win = { border = "rounded" },
    },
  },

  -- Inline blame, replacing blamer.nvim: gitsigns is already installed by
  -- LazyVim and does the same job without a second plugin walking the
  -- buffer on every cursor move.
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text_pos = "eol",
        delay = 400,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = "󰊢  <author>, <author_time:%R> · <summary>",
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▁" },
        topdelete = { text = "▔" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },
}
