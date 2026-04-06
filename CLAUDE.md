# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository containing configurations for:
- **zsh** — shell config (`zsh/.zshrc`)
- **starship** — prompt (`starship/starship.toml`)
- **ghostty** — terminal emulator (`ghostty/config`)
- **nvim** — Neovim config built on lazy.nvim (`nvim/`)

No build system or test suite exists — changes are applied by symlinking or copying files to their target locations on each machine.

## Deployment

Configs are meant to be symlinked (or copied) to their canonical locations:

| File | Target |
|------|--------|
| `zsh/.zshrc` | `~/.zshrc` |
| `starship/starship.toml` | `~/.config/starship/starship.toml` |
| `ghostty/config` | `~/.config/ghostty/config` |
| `nvim/` | `~/.config/nvim/` |

## Architecture

### zsh
- Loads plugins conditionally per OS (Homebrew on macOS, system paths on Linux).
- Sources `~/.config/zsh/aliases.zsh` for shared aliases and `~/.zsh_local` for machine-specific overrides — neither file lives in this repo.
- Tool integrations (fzf, zoxide, starship) are guarded with `command -v` checks so the config is safe on hosts where tools are missing. The fzf check also validates `fzf --zsh` succeeds before evaling (some hosts have older fzf versions that don't support `--zsh`).

### Neovim
- Entry point: `nvim/init.lua` → bootstraps `config.lazy` and `wolf`.
- `nvim/lua/config/lazy.lua` — bootstraps lazy.nvim, sets `<leader>` to `<Space>`, loads all `lua/plugins/*.lua` specs, and configures LSP + nvim-cmp directly (no lsp-zero abstraction layer despite the filename).
- `nvim/lua/wolf/` — personal config: `init.lua` requires `wolf.remap`, `remap.lua` sets keymaps and options.
- `nvim/lua/plugins/` — lazy.nvim plugin specs: `lsp-zero.lua` (nvim-lspconfig + nvim-cmp), `mason.lua` (mason + mason-lspconfig), `mini.lua` (mini.nvim), `catppuccin-mocha.lua` (colorscheme).
- Active LSP servers (enabled in `config/lazy.lua`): gleam, ocamllsp, lua_ls, jedi_language_server, bashls, dockerls, terraformls.
- `nvim/lazy-lock.json` — pin file; update with `:Lazy update` inside Neovim.

### Starship
- Uses the **catppuccin_mocha** palette (defined inline at the bottom of `starship.toml`).
- Prompt shows: OS icon → username@hostname → directory → git branch/status → language icons → time.

### Ghostty
- Theme: catppuccin-mocha. Font: FiraCode Nerd Font (required for icons throughout all configs).
- `macos-option-as-alt = true` is macOS-specific and harmless on Linux.
