---@class util.ui
local M = {}

function _G.dump(...)
  vim.print(...)
end

function M.reload_all()
  for name, _ in pairs(package.loaded) do
    if
      name:match("^lazy")
      or name:match("^mapping")
      or name:match("^plugrc")
      or name:match("^ui")
      or name:match("^editor")
      or name:match("^plugins")
      or name:match("^syntax")
      or name:match("^terminal")
      or name:match("^utils")
    then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
end

function M.reload_one(module)
  for name, _ in pairs(package.loaded) do
    if name:match("^" .. module) then
      package.loaded[name] = nil
      require(name)
      return
    end
  end
end

--{ "git", "rg", { "fd", "fdfind" }, "lazygit" }
M.check_if_cmd_exist = function(cmds)
  local result = {}
  for _, cmd in ipairs(cmds) do
    local name = type(cmd) == "string" and cmd or vim.inspect(cmd)
    local commands = type(cmd) == "string" and { cmd } or cmd
    ---@cast commands string[]
    local found = false
    for _, c in ipairs(commands) do
      if vim.fn.executable(c) == 1 then
        name = c
        found = true
      end
      result[name] = { found }
    end
  end
  return result
end

---@param editor_variable? {global: boolean}
---@param values? {[1]:any, [2]:any}
---@param option string
function M.toggle(option, editor_variable, values)
  if values then
    if not editor_variable then
      if vim.deep_equal(vim.opt_local[option]:get(), values[1]) then
        vim.opt_local[option] = values[2]
      else
        vim.opt_local[option] = values[1]
      end
      vim.notify(
        "set editor option " .. option .. " to " .. tostring(vim.opt_local[option]:get()),
        vim.log.levels.INFO,
        { title = "toggle editor option" }
      )
    else
      if not editor_variable.global then
        local bufnr = vim.api.nvim_get_current_buf()
        if vim.b[bufnr][option] == values[1] then
          vim.b[bufnr][option] = values[2]
        else
          --if option is unset or nil
          vim.b[bufnr][option] = values[1]
        end
        --:h debug.getinfo() or lua_getinfo() to get information about a function
        vim.notify("set option " .. option .. " to " .. tostring(vim.b[bufnr][option]), vim.log.levels.INFO, {
          title = "toggle local option",
        })
      else
        if vim.g[option] == values[1] then
          vim.g[option] = values[2]
        else
          --if option is unset or nil
          vim.g[option] = values[1]
        end
        vim.notify("set global option " .. option .. " to " .. tostring(vim.g[option]), vim.log.levels.INFO, {
          title = "toggle global option",
        })
      end
    end
  else
    if not editor_variable then
      vim.opt_local[option] = not vim.opt_local[option]:get()
      vim.notify(
        "set editor option " .. option .. " to " .. tostring(vim.opt_local[option]:get()),
        vim.log.levels.INFO,
        {
          title = "toggle editor option",
        }
      )
    else
      if not editor_variable.global then
        local bufnr = vim.api.nvim_get_current_buf()
        vim.b[bufnr][option] = not vim.b[bufnr][option] and true or false
        vim.notify("set option " .. option .. " to " .. tostring(vim.b[bufnr][option]), vim.log.levels.INFO, {
          title = "toggle local option",
        })
      else
        vim.g[option] = not vim.g[option]
        vim.notify("set global option " .. option .. " to " .. tostring(vim.g[option]), vim.log.levels.INFO, {
          title = "toggle global option",
        })
      end
    end
  end
end

---@param fn fun()
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("Lazy", { clear = true }),
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

---@param modules string[]
--modules like "autocmds" | "options" | "keymaps"
M.lazy_load = function(modules)
  -- when no file is opened at startup
  if vim.fn.argc(-1) == 0 then
    -- autocmds and keymaps can wait to load
    -- always load lazyvim, then user file
    M.on_very_lazy(function()
      for i = 1, #modules do
        require(modules[i])
      end
    end)
  else
    -- load them now so they affect the opened buffers
    for i = 1, #modules do
      require(modules[i])
    end
  end
end

---@param on_attach fun(client, bufnr)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, bufnr)
    end,
  })
end

---@param plugin string
function M.has(plugin)
  if package.loaded["lazy"] then
    return require("lazy.core.config").plugins[plugin] ~= nil
  else
    local plugin_name = vim.split(plugin, ".", { plain = true, trimempty = true })
    return package.loaded[plugin_name[1]] ~= nil
  end
end

---@param description? string
---@param opt table
local function mdesc(opt, description)
  return vim.tbl_extend("force", opt, { desc = description })
end

---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts? table
---@param desc? string
M.map = function(mode, lhs, rhs, opts, desc)
  opts = opts and opts or {}
  opts = mdesc(opts, desc)
  vim.keymap.set(mode, lhs, rhs, opts)
end

M.augroup = function(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

---@type (fun(buf:number, lnum:number, vnum:number, win:number):Sign[]?)[]
M.virtual = {}

---@alias Sign {name:string, text:string, texthl:string, priority:number}

-- Returns a list of regular and extmark signs sorted by priority (low to high)
---@return Sign[]
---@param buf number
---@param lnum number
function M.get_signs(buf, lnum)
  -- Get regular signs
  ---@type Sign[]
  local signs = {}

  if vim.fn.has("nvim-0.10") == 0 then
    -- Only needed for Neovim <0.10
    -- Newer versions include legacy signs in nvim_buf_get_extmarks
    for _, sign in ipairs(vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs) do
      local ret = vim.fn.sign_getdefined(sign.name)[1] --[[@as Sign]]
      if ret then
        ret.priority = sign.priority
        signs[#signs + 1] = ret
      end
    end
  end

  -- Get extmark signs
  local extmarks = vim.api.nvim_buf_get_extmarks(
    buf,
    -1,
    { lnum - 1, 0 },
    { lnum - 1, -1 },
    { details = true, type = "sign" }
  )
  for _, extmark in pairs(extmarks) do
    signs[#signs + 1] = {
      name = extmark[4].sign_hl_group or extmark[4].sign_name or "",
      text = extmark[4].sign_text,
      texthl = extmark[4].sign_hl_group,
      priority = extmark[4].priority,
    }
  end

  -- Sort by priority
  table.sort(signs, function(a, b)
    return (a.priority or 0) < (b.priority or 0)
  end)

  return signs
end

---@return Sign?
---@param buf number
---@param lnum number
function M.get_mark(buf, lnum)
  local marks = vim.fn.getmarklist(buf)
  vim.list_extend(marks, vim.fn.getmarklist())
  for _, mark in ipairs(marks) do
    if mark.pos[1] == buf and mark.pos[2] == lnum and mark.mark:match("[a-zA-Z]") then
      return { text = mark.mark:sub(2), texthl = "DiagnosticHint" }
    end
  end
end

---@param sign? Sign
---@param len? number
function M.icon(sign, len)
  sign = sign or {}
  len = len or 2
  local text = vim.fn.strcharpart(sign.text or "", 0, len) ---@type string
  text = text .. string.rep(" ", len - vim.fn.strchars(text))
  return sign.texthl and ("%#" .. sign.texthl .. "#" .. text .. "%*") or text
end

function M.foldtext()
  local ok = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
  local ret = ok and vim.treesitter.foldtext and vim.treesitter.foldtext()
  if not ret or type(ret) == "string" then
    ret = { { vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1], {} } }
  end
  table.insert(ret, { " " .. require("lazyvim.config").icons.misc.dots })

  if not vim.treesitter.foldtext then
    return table.concat(
      vim.tbl_map(function(line)
        return line[1]
      end, ret),
      " "
    )
  end
  return ret
end

function M.statuscolumn()
  local win = vim.g.statusline_winid
  local buf = vim.api.nvim_win_get_buf(win)
  local is_file = vim.bo[buf].buftype == ""
  local show_signs = vim.wo[win].signcolumn ~= "no"

  local components = { "", "", "" } -- left, middle, right

  local show_open_folds = vim.g.lazyvim_statuscolumn and vim.g.lazyvim_statuscolumn.folds_open
  local use_githl = vim.g.lazyvim_statuscolumn and vim.g.lazyvim_statuscolumn.folds_githl

  if show_signs then
    local signs = M.get_signs(buf, vim.v.lnum)

    local has_virtual = false
    for _, fn in ipairs(M.virtual) do
      local virtual = fn(buf, vim.v.lnum, vim.v.virtnum, win)
      if virtual then
        has_virtual = true
        vim.list_extend(signs, virtual)
      end
    end

    ---@type Sign?,Sign?,Sign?
    local left, right, fold, githl
    for _, s in ipairs(signs) do
      if s.name and s.name:lower():find("^octo_clean") then
        s.texthl = "IblScope"
      end
      if s.name and (s.name:find("GitSign") or s.name:find("MiniDiffSign")) then
        right = s
        if use_githl then
          githl = s["texthl"]
        end
      else
        left = s
      end
    end
    if vim.v.virtnum ~= 0 and not has_virtual then
      left = nil
    end

    vim.api.nvim_win_call(win, function()
      if vim.fn.foldclosed(vim.v.lnum) >= 0 then
        fold = { text = vim.opt.fillchars:get().foldclose or "", texthl = githl or "Folded" }
      elseif show_open_folds and not M.skip_foldexpr[buf] and vim.treesitter.foldexpr(vim.v.lnum):sub(1, 1) == ">" then -- fold start
        fold = { text = vim.opt.fillchars:get().foldopen or "", texthl = githl }
      end
    end)
    -- Left: mark or non-git sign
    components[1] = M.icon(M.get_mark(buf, vim.v.lnum) or left)
    -- Right: fold icon or git sign (only if file)
    components[3] = is_file and M.icon(fold or right) or ""
  end

  -- Numbers in Neovim are weird
  -- They show when either number or relativenumber is true
  local is_num = vim.wo[win].number
  local is_relnum = vim.wo[win].relativenumber
  if (is_num or is_relnum) and vim.v.virtnum == 0 then
    if vim.v.relnum == 0 then
      components[2] = is_num and "%l" or "%r" -- the current line
    else
      components[2] = is_relnum and "%r" or "%l" -- other lines
    end
    components[2] = "%=" .. components[2] .. " " -- right align
  end

  if vim.v.virtnum ~= 0 then
    components[2] = "%= "
  end

  return table.concat(components, "")
end

---@return {fg?:string}?
function M.fg(name)
  local color = M.color(name)
  return color and { fg = color } or nil
end

---@param name string
---@param bg? boolean
---@return string?
function M.color(name, bg)
  ---@type {foreground?:number}?
  ---@diagnostic disable-next-line: deprecated
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name, link = false })
    or vim.api.nvim_get_hl_by_name(name, true)
  ---@diagnostic disable-next-line: undefined-field
  ---@type string?
  local color = nil
  if hl then
    if bg then
      color = hl.bg or hl.background
    else
      color = hl.fg or hl.foreground
    end
  end
  return color and string.format("#%06x", color) or nil
end

M.skip_foldexpr = {} ---@type table<number,boolean>
local skip_check = assert(vim.uv.new_check())

function M.foldexpr()
  local buf = vim.api.nvim_get_current_buf()

  -- still in the same tick and no parser
  if M.skip_foldexpr[buf] then
    return "0"
  end

  -- don't use treesitter folds for non-file buffers
  if vim.bo[buf].buftype ~= "" then
    return "0"
  end

  -- as long as we don't have a filetype, don't bother
  -- checking if treesitter is available (it won't)
  if vim.bo[buf].filetype == "" then
    return "0"
  end

  local ok = pcall(vim.treesitter.get_parser, buf)

  if ok then
    return vim.treesitter.foldexpr()
  end

  -- no parser available, so mark it as skip
  -- in the next tick, all skip marks will be reset
  M.skip_foldexpr[buf] = true
  skip_check:start(function()
    M.skip_foldexpr = {}
    skip_check:stop()
  end)
  return "0"
end

---@param buf number?
function M.bufremove(buf)
  buf = buf or 0
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  if vim.bo.modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if choice == 0 then -- Cancel
      return
    end
    if choice == 1 then -- Yes
      vim.cmd.write()
    end
  end

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
        return
      end
      -- Try using alternate buffer
      local alt = vim.fn.bufnr("#")
      if alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.api.nvim_win_set_buf(win, alt)
        return
      end

      -- Try using previous buffer
      local has_previous = pcall(vim.cmd, "bprevious")
      if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
        return
      end

      -- Create new listed buffer
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, new_buf)
    end)
  end
  if vim.api.nvim_buf_is_valid(buf) then
    pcall(vim.cmd, "bdelete! " .. buf)
  end
end

return M
