local plugins = {}

local disabled = {}
for _, plugin in ipairs(plugins) do
  table.insert(disabled, { plugin, enabled = false })
end

return disabled
