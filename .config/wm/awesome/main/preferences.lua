local M = {}

M.terminal = "alacritty"
M.editor = os.getenv("EDITOR") or "nvim"
M.editor_cmd = M.terminal .. " -e " .. M.editor
M.modkey = "Mod4"
M.files = M.terminal .. " -e " .. "ranger"
M.browser = "firefox"
M.rofi = "rofi -show drun"
M.rofi_windows = "rofi -show window"

return M
