local wibox = require("wibox")
local awful = require("awful")

local M = {}

function M.left_widgets(s)
  local taglist = require("ui.topbar.widgets.taglist")(s)
  return taglist
end

function M.middle_widgets(s)
  local tasklist = require("ui.topbar.widgets.tasklist")(s)
  return tasklist
end

function M.right_widgets(s)
  local systray = require("ui.topbar.widgets.systray")
  local datetime = require("ui.topbar.widgets.datetime")
  -- local battery = require("ui.topbar.widgets.battery")
  -- local brightness = require("ui.topbar.widgets.brightness")
  local volume = require("ui.topbar.widgets.volume")
  local mic = require("ui.topbar.widgets.mic")
  local cpu = require("ui.topbar.widgets.cpu")
  local mem = require("ui.topbar.widgets.memory")
  local fs = require("ui.topbar.widgets.fs")
  -- local network = require("ui.topbar.widgets.network")
  local kbd = require("ui.topbar.widgets.keyboard")
  local notif = require("ui.topbar.widgets.notifications")
  local layoutbox = require("ui.topbar.widgets.layoutbox")(s)

  return {
    layout = wibox.layout.fixed.horizontal,
    spacing = 5,
    systray,
    cpu,
    mem,
    fs,
    -- network,
    -- battery,
    -- brightness,
    mic,
    volume,
    notif,
    datetime,
    kbd,
    layoutbox,
  }
end

return M
