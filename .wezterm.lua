local wezterm = require('wezterm')
local config = wezterm.config_builder()
local mux = wezterm.mux

-- Remove title bar but keep resize capability
config.window_decorations = "RESIZE"

-- Optional: Add custom tab bar styling since you lose the title
config.term = "xterm-256color"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

-- Open new tabs in the same directory as the current tab
config.default_cwd = wezterm.home_dir
config.switch_to_last_active_tab_when_closing_tab = true

-- Key binding for new tab (optional - Ctrl+Shift+T is default)
config.keys = {
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
}

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

config.color_scheme = 'catppuccin-mocha'
return config
