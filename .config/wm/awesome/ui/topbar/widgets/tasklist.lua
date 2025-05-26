local awful = require("awful")
local wibox = require("wibox")
-- local gears = require("gears")
local beautiful = require("beautiful")
local sutils = require("utils.shape")

local function tasklist(s)
  return awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = {
      awful.button({}, 1, function(c)
        c:activate({ context = "tasklist", action = "toggle_minimization" })
      end),
      awful.button({}, 3, function()
        awful.menu.client_list({ theme = { height = 20, width = 450 } })
      end),
      awful.button({}, 4, function()
        awful.client.focus.byidx(-1)
      end),
      awful.button({}, 5, function()
        awful.client.focus.byidx(1)
      end),
    },
    layout = {
      layout = wibox.layout.fixed.horizontal,
      spacing = 10,
    },
    style = {
      -- shape = gears.shape.squircle,
      shape = sutils.rrect(beautiful.widget_bg_radius),
    },
    widget_template = {
      {
        {
          id = "clienticon",
          widget = awful.widget.clienticon,
        },
        left = 2,
        right = 2,
        top = 2,
        bottom = 2,
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
      nil,
      create_callback = function(self, c, index, objects) --luacheck: no unused args
        self:get_children_by_id("clienticon")[1].client = c
      end,
    },
  })
end

return tasklist
