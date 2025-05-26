local awful = require("awful")
local info = {}

local on_update = function(_) end
function info.on_update(update_fn)
  on_update = update_fn
end

function info.update()
  awful.spawn.easy_async(
    -- At the moment here is a workaround to get the value of indicators close to realtime.
    -- https://unix.stackexchange.com/a/90904
    [[bash -c "top -bn 2 -d 0.01 | grep '^%Cpu' | tail -n 1 | gawk '{print $2+$4+$6}'"]],
    function(stdout)
      -- local cpu_idle = stdout
      -- cpu_idle = string.gsub(cpu_idle, "^%s*(.-)%s*$", "%1")
      -- on_update(string.format("%d%%", 100 - tonumber(cpu_idle)))
      on_update(string.format("%.1f%%", stdout))
    end
  )
end
info.update()

return info
