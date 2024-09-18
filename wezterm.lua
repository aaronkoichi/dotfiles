-- These are the basic's for using wezterm.
-- Mux is the mutliplexes for windows etc inside of the terminal
-- Action is to perform actions on the terminal
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action
local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').main

-- These are vars to put things in later (i dont use em all yet)
local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

config.font = wezterm.font 'CaskaydiaCove Nerd Font'
config.font_size = 13
config.launch_menu = launch_menu
config.default_cursor_style = 'SteadyBlock'
config.window_decorations = "RESIZE"

config.keys = {
  { key = 'l', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(1) },
  { key = 'h', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = 'j', mods = 'CMD', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'CMD', action = act.ActivatePaneDirection 'Up' },
  { key = 'Enter', mods = 'CMD', action = act.ActivateCopyMode },
  { key = 'R', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
  { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },
  { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
  { key = 'U', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
  { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
  { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down' },
  { key = 'f', mods = 'SHIFT|CTRL', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'SHIFT|CTRL', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },
  { key = 't', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CTRL', action = act.CloseCurrentTab{ confirm = false } },
  { key = 'x', mods = 'CTRL', action = act.CloseCurrentPane{ confirm = false } },
  { key = 'b', mods = 'CTRL', action = act.SendString '\x02' },
  
  { key = 'k', mods = 'CTRL|ALT', action = act.Multiple {
      act.ClearScrollback 'ScrollbackAndViewport',
      act.SendKey { key = 'L', mods = 'CTRL' }
    }
  },
  { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
}


config.mouse_bindings = mouse_bindings
config.colors = theme.colors()
config.front_end = "WebGpu"
config.disable_default_key_bindings = true

wezterm.on('gui-startup', function()
 local tab, pane, window = mux.spawn_window({})
 window:gui_window():maximize()
end)


-- There are mouse binding to mimc Windows Terminal and let you copy
-- To copy just highlight something and right click. Simple
mouse_bindings = {
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
 {
  event = { Down = { streak = 1, button = "Right" } },
  mods = "NONE",
  action = wezterm.action_callback(function(window, pane)
   local has_selection = window:get_selection_text_for_pane(pane) ~= ""
   if has_selection then
    window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
    window:perform_action(act.ClearSelection, pane)
   else
    window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
   end
  end),
 },
}

config.default_domain = 'WSL:Ubuntu'
return config