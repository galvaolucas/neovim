# neovim

My personal Neovim configuration — a [LazyVim](https://github.com/LazyVim/LazyVim)
setup tuned for a calm, transparent editor that starts fast and stays out of
the way.

Two ideas drive everything here:

- **Nothing loads until it's needed.** Every spec in `lua/plugins/` declares its
  own trigger (`cmd` / `keys` / `ft` / `event`), so a cold start only pays for
  the colorscheme, `snacks.nvim`, and lualine — which the colorscheme pulls in
  because maple builds the statusline itself.
- **The terminal and the editor are one surface.** The colorscheme is
  transparent on purpose so the terminal background (Ghostty, warm `#1a1614`)
  shows through instead of Neovim painting a flat rectangle over it.

## Requirements

| | |
|---|---|
| Neovim | >= 0.11.2 (LazyVim's floor) |
| Terminal | true-color + undercurl — [Ghostty](https://ghostty.org), WezTerm, Kitty |
| Font | a [Nerd Font](https://www.nerdfonts.com/) (icons are used throughout) |
| Tools | `git`, a C compiler (for treesitter), [`lazygit`](https://github.com/jesseduffield/lazygit), [`ripgrep`](https://github.com/BurntSushi/ripgrep), [`fd`](https://github.com/sharkdp/fd) |

## Install

```bash
# back up anything you already have
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

git clone git@github.com:galvaolucas/neovim.git ~/.config/nvim
nvim
```

First launch bootstraps `lazy.nvim`, installs every plugin at the versions
pinned in `lazy-lock.json`, and Mason pulls the external tools. Run `:checkhealth`
once it settles.

## Layout

```
init.lua                  entry point — loads config.{lazy,autocmds,options,keymaps}
lua/config/
  lazy.lua                lazy.nvim bootstrap, disabled builtins, rounded UI
  options.lua             providers off, cozy fillchars, per-filetype autoformat
  keymaps.lua             (intentionally thin — see below)
  autocmds.lua            disables autoformat for JS/TS buffers
lua/plugins/
  themes.lua              maple (autumn) + the cozy override layer; alternates lazy
  ui.lua                  bufferline, noice, which-key, gitsigns (statusline is maple's)
  snacks.lua              picker, explorer, dashboard, indent, notifier
  blink.lua               completion (enter to accept, Rust fuzzy matcher)
  neocodeium.lua          AI completion, insert mode only
  python.lua              Ruff over pylsp; ruff_format on save
  lazygit.lua             loads on <leader>gg
  overseer.lua            task runner, loads on first command
  precognition.lua        motion hints, off until toggled
  markdown-preview.lua    render-markdown for markdown buffers
  smear.lua               cursor trail (disabled — flip `enabled` to try it)
  general.lua             extra Mason tools
lazyvim.json              enabled LazyVim extras
```

Keymaps that belong to a plugin live on that plugin's spec, not in
`keymaps.lua` — defining them in both places would shadow the lazy-loading
trigger and load the plugin at startup anyway.

## Custom keymaps

Everything from [LazyVim's defaults](https://lazyvim.github.io/keymaps) still
applies. On top of those:

| Key | Action |
|---|---|
| `<leader>gg` | LazyGit |
| `<leader>ow` | Toggle the Overseer task list |
| `<leader>or` | Run an Overseer task |
| `<leader>up` | Toggle precognition motion hints |
| `<A-f>` (insert) | Accept the NeoCodeium suggestion |

## Themes

My own [maple.nvim](https://github.com/galvaolucas/maple.nvim) is active, on the
`autumn` palette and transparent. Autumn rather than spring because Ghostty runs
the `ember` palette — a warm near-black — and autumn's parchment-on-#1C1C1A with
rust/amber/sage accents sits on top of it without a colour clash, where spring's
teal base would fight the warm ground showing through.

The statusline is maple's own lualine extension too: `require("maple").load()`
calls `lualine.setup()` itself, so LazyVim's layout is dropped in `ui.lua` rather
than assembled and immediately replaced. This is the one thing that costs
startup time — lualine now loads with the colorscheme instead of on `VeryLazy`.

On top of the theme, `themes.lua` carries a **cozy layer** — a `ColorScheme
maple` hook that fills in UI that postdates the theme (blink, snacks,
bufferline, noice, which-key), maps `:terminal` to the palette, and softens a
few groups that read loud on a dark warm ground. It also patches over a handful
of upstream bugs worth fixing in maple itself one day:

- `Normal`, `Keyword`, `@keyword`, `@keyword.function` and `@operator` are
  re-set by maple's own `ColorScheme` handlers with no `fg`. `nvim_set_hl`
  replaces rather than merges, so they come out colourless.
- `DiagnosticWarn` points at `columbia_blue`, which isn't in either palette.
- `DiffAdd`/`Change`/`Delete`/`Text` are pastel *backgrounds* (`#a4dfae` and
  friends) with no foreground — unreadable light slabs on a dark theme.
- `setup()` writes `"NONE"` into the shared palette table's `bg` and `border`
  in transparent mode, so neither can be read back afterwards.

The layer runs through `vim.schedule` for exactly this reason: maple registers
its own `ColorScheme` handlers while its colors file is being sourced — i.e.
after anything registered from the plugin spec — so a direct call would be
overwritten. One tick later puts it last.

Kanagawa, Tokyonight, Rosé Pine and Catppuccin are installed lazily —
`:colorscheme <name>` loads them on demand at no startup cost.

## Notes on the tuning

A few deliberate choices, so future-me doesn't undo them:

- Python/Ruby/Perl/Node providers are disabled — nothing here uses remote plugins.
- `checker` is off; background update checks spawn a git process per plugin.
  Run `:Lazy sync` when you actually want updates.
- Netrw and the other bundled plugins are disabled — `snacks.explorer` replaces it.
- Autoformat is off for JS/TS/CSS/HTML/JSON/YAML, on for Python via `ruff_format`.
- `gitsigns` handles inline blame, replacing a second blame plugin that walked
  the buffer on every cursor move.

## License

Apache-2.0 — see [LICENSE](LICENSE). Built on
[LazyVim](https://github.com/LazyVim/LazyVim) by folke.
