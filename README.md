# dev‑environment

A curated setup of my personal development environment — configuration files and scripts for enhancing productivity and consistency across machines.

## 🚀 What's included

- `init.lua` — Neovim configuration (Lua) for a fast, modular editor experience  
- `lua/` — Custom Lua modules and plugin configurations for Neovim  
- `wezterm.lua` — Configuration for WezTerm terminal emulator  
- `.tmux.conf` — Setup for tmux session management and workflows  
- `tmux‑projects.sh` — Helper script for switching between project‑specific tmux sessions  
- `remind.sh` — Utility shell script for reminders/notifications  
- `.gitignore` — Standard ignore rules for version control  
- `lazy‑lock.json` — Lock‑file for pinned Neovim plugin versions

## 🎯 Why use this repo

This repository captures the tools and workflows I rely on daily, so I can replicate my setup across machines quickly, maintain consistency, and iterate on my workflow over time.

- **Portable**: Clone this repo and link/execute the configs to get up and running.  
- **Modular**: Neovim and shell/terminal configs are separated, making tweaks easier.  
- **Versioned**: All changes are tracked so I can pinpoint when and why a setting changed.

## 🛠 Getting Started

1. Clone the repo:  
   ```bash
   git clone https://github.com/SSSM0602/dev-environment.git
   cd dev-environment
   ```

2. Backup any existing configs you want to keep, then link or copy files to your home directory. Example:  
   ```bash
   ln -s "$(pwd)/init.lua" ~/.config/nvim/init.lua
   ln -s "$(pwd)/.tmux.conf" ~/.tmux.conf
   ln -s "$(pwd)/wezterm.lua" ~/.config/wezterm/wezterm.lua
   ```

3. For Neovim — install the plugins via your plugin manager (based on `lazy-lock.json`).  
4. For tmux & terminal — apply or reload your configs.  
5. Optionally modify scripts (e.g., `tmux‑projects.sh`, `remind.sh`) to match your personal workflow.

## 🔧 Customization Tips

- Update `lua/` modules to add/remove Neovim plugins or change behavior.  
- Customize the `tmux` keybindings inside `.tmux.conf` to match your preferred shortcuts.  
- Modify `WezTerm` config for theme, font, pane behavior.  
- Use `remind.sh` as a basis for your own reminder system — you might hook it into cron, i3/sway notifications, etc.

## 📚 Further Resources

- Check out the `lua/` folder for modular plugin setup and custom functions.  
- In `tmux‑projects.sh`, each project path is declared; add your own to streamline session switching.  
- The linked configs assume a UNIX‑like system (macOS, Linux). Adjust paths accordingly if you use Windows/WSL.

---

Feel free to open issues or pull requests if you find improvements. This repo is meant to evolve as I refine my workflow — contributions welcome!
