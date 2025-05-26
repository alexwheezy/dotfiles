local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")

local pref = require("main.preferences")

local terminal = pref.terminal
local editor_cmd = pref.editor_cmd
local rofi = pref.rofi
local rofi_windows = pref.rofi_windows

local awesomemenu = {
  {
    "hotkeys",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
  },
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  {
    "quit",
    function()
      awesome.quit()
    end,
  },
}

local menus = {
  { "application menu", rofi },
  { "windows menu", rofi_windows },
  { "power menu", "bash .config/awesome/scripts/powermenu.sh" },
}

local menu = awful.menu({
  items = {
    { "awesome", awesomemenu, beautiful.awesome_icon },
    { "menus", menus },
  },
})

awful.widget.launcher({ image = ".config/awesome/logo.png", menu = menu })

return menu
