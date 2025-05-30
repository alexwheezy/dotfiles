--[[
--
-- This file is not required for your own configuration,
-- but helps people determine if their system is setup correctly.
--
--]]
local health = vim.health
local version = vim.version

local check_version = function()
  local verstr = string.format("%s.%s.%s", version().major, version().minor, version().patch)
  if not version.cmp then
    health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
    return
  end

  if version.cmp(version(), { 0, 9, 4 }) >= 0 then
    health.ok(string.format("Neoversion is: '%s'", verstr))
  else
    health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
  end
end

local check_external_reqs = function()
  -- Basic utils: `git`, `make`, `unzip`
  for _, exe in ipairs({ "git", "make", "unzip", "rg" }) do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      health.ok(string.format("Found executable: '%s'", exe))
    else
      health.warn(string.format("Could not find executable: '%s'", exe))
    end
  end

  return true
end

return {
  check = function()
    health.start("nvim")

    health.info([[NOTE: Not every warning is a 'must-fix' in `:checkhealth`

  Fix only warnings for plugins and languages you intend to use.
    Mason will give warnings for languages that are not installed.
    You do not need to install, unless you want to use those languages!]])

    local uv = vim.uv or vim.loop
    health.info("System Information: " .. vim.inspect(uv.os_uname()))

    check_version()
    check_external_reqs()
  end,
}
