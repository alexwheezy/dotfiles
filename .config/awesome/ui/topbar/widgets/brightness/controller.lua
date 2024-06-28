local awful = require("awful")

local controller = {}

local on_update = function(_) end

function controller.on_update(update_fn)
  on_update = update_fn
end

function controller.inc()
  awful.spawn.easy_async("xbacklight -inc 5", controller.update)
end

function controller.dec()
  awful.spawn.easy_async("xbacklight -dec 5", controller.update)
end

function controller.set(val)
  awful.spawn.easy_async("xbacklight -set " .. tostring(val) .. "%", controller.update)
end

local function get_percentage_from_stdout(stdout)
  local percentage_str = stdout:match("%d+")
  return tonumber(percentage_str)
end

function controller.update()
  awful.spawn.easy_async("xbacklight -get", function(stdout)
    local percentage = get_percentage_from_stdout(stdout)
    if percentage < 1 then
      controller.set(1)
      on_update(percentage)
      return
    end
    on_update(get_percentage_from_stdout(stdout))
  end)
end

return controller
