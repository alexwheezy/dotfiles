local function create_colorscheme(theme, black, white, gray, red, green, blue, yellow, magenta, cyan)
  theme.widget_bg = theme.bg_normal

  theme.bg_normal = black
  theme.bg_focus = blue
  theme.bg_urgent = red
  theme.bg_systray = theme.widget_bg
  theme.border_focus = blue
  theme.border_color_normal = black
  theme.border_color_marked = red
  theme.bg_minimize = "#00000000"
  theme.fg_normal = "#bfbfbf"
  theme.fg_focus = white
  theme.fg_urgent = white
  theme.fg_minimize = white

  -- for widgets
  theme.bat_color = yellow
  theme.bat_red_color = red
  theme.vol_color = white
  theme.vol_mute_color = white .. "aa"
  theme.mic_color = green
  theme.mic_mute_color = green .. "aa"
  theme.brightness_color = yellow
  theme.datetime_color = cyan
  theme.network_color = white
  theme.network_color_nocon = red .. "aa"
  theme.fs_color = blue
  theme.mem_color = red
  theme.cpu_color = magenta
  theme.notif_color = green

  theme.tag_active_bg = blue
  theme.tag_active_fg = black
  theme.tag_empty_bg = theme.bg_normal
  theme.tag_empty_fg = white .. "55"
  theme.tag_inactive_bg = theme.bg_normal
  theme.tag_inactive_fg = white

  theme.notif = {
    title_bg = gray,
    border_color = blue,
    message_bg = {
      normal = black,
      critical = black,
      low = black,
    },
    message_fg = {
      normal = white,
      critical = red,
      low = white,
    },
  }

  return theme
end

return create_colorscheme
