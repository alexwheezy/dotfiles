local gears = require("gears")
local beautiful = require("beautiful")
local wutils = require("utils.widget")
local cpuinfo = require("ui.topbar.widgets.cpu.cpuinfo")

local icon = "󰻠"

local cpu_widget = wutils.topbar_status_widget()

cpuinfo.on_update(function(info)
  cpu_widget.change_text(info, beautiful.cpu_color)
  cpu_widget.change_icon(icon, beautiful.cpu_color)
end)

cpuinfo.update()

gears.timer({
  timeout = 3,
  call_now = true,
  autostart = true,
  callback = function()
    cpuinfo.update()
  end,
})

return cpu_widget.widget
