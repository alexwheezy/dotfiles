# General settings
# Load your autoconfig, use this, if the rest of your config is empty!
config.load_autoconfig()

RUSSIAN = 'йцукенгшщзхъфывапролджэячсмитьбю.'
ENGLISH = 'qwertyuiop[]asdfghjkl;\'zxcvbnm,./'

c.bindings.key_mappings = {
    **{r: e for r, e in zip(RUSSIAN, ENGLISH)},
    **{r.upper(): e.upper() for r, e in zip(RUSSIAN, ENGLISH)}
}

# Aliases
c.aliases = {
    "q": "close",
    "qa": "quit",
    "w": "session-save",
    "wq": "quit --save",
    "wqa": "quit --save",
    "so": "config.source",
    "tor-proxy": "set content.proxy socks://127.0.0.1:9050",
    "ssh-proxy": "set content.proxy socks://127.0.0.1:1080",
    "mitm-proxy": "set content.proxy http://127.0.0.1:8080",
    "system-proxy": "set content.proxy system",
    "settings": "open -t qute://settings",
    "changelog": "open -t qute://help/changelog.html",
    "adblock-off": "set content.blocking.enabled false",
    "adblock-on": "set content.blocking.enabled true",
}

# Font
c.fonts.default_family = 'SauceCodeProNerdFont'
c.fonts.default_size = '15px'

# Search engine
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    '!apkg': 'https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=',
    '!aw': 'https://wiki.archlinux.org/?search={}',
    '!gg': 'https://www.google.com/search?hl=en&q={}',
    '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
    '!red': 'https://www.reddit.com/search?q={}',
    '!rstd': 'https://doc.rust-lang.org/stable/std/?search={}',
    '!yt': 'https://www.youtube.com/results?search_query={}',
    '!zstd': 'https://ziglang.org/documentation/master/std/#?{}',
}

# Colors
c.colors.webpage.bg = 'black'
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = 'never'
c.colors.webpage.preferred_color_scheme = 'dark'

# Fileselect
# Set Yazi as file picker.
c.fileselect.handler = 'external'
c.fileselect.single_file.command = ['alacritty', '--class', 'yazi,yazi', '-e', 'yazi', '--choosefile', '{}']
c.fileselect.multiple_files.command = ['alacritty', '--class', 'yazi,yazi', '-e', 'yazi', '--choosefile', '{}']
c.fileselect.folder.command = ['alacritty', '--class', 'yazi,yazi', '-e', 'yazi', '--choosefile', '{}']

# Editor
# Launch nvim in the terminal for editor.
c.editor.command = ['alacritty', '-t', 'edit_text', '-e', 'nvim', '{}']

# Content
c.content.autoplay = False
c.content.pdfjs = True

# Statusbar
c.statusbar.show = 'always'
c.statusbar.widgets = ['keypress', 'url', 'search_match', 'scroll', 'history', 'progress']

# Tabs
c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 5, 'right': 5}
c.tabs.indicator.width = 2
c.tabs.show = 'multiple'
c.tabs.title.format = '{current_title}'

# Scrolling
c.scrolling.bar = 'always'
c.scrolling.smooth = True

# Session
c.auto_save.session = True
c.session.default_name = 'default'
c.session.lazy_restore = True

# Key bindings
config.bind('<Ctrl-o>', 'cmd-set-text -s :session-load')
config.bind('<Ctrl-s>', 'cmd-set-text -s :session-save -o')

config.unbind('q') # record macro
config.unbind('d') # close tab
config.unbind('u') # restore tab
config.unbind('co') # close tab except one

config.unbind('<Ctrl-q>') # close tab
config.unbind('<Ctrl-w>') # close window
config.unbind('<Shift-k>') # tab-next
config.unbind('<Shift-j>') # tab-prev

config.bind('<', 'tab-move -')
config.bind('>', 'tab-move +')

config.bind('h', 'scroll-px -70 0')
config.bind('j', 'scroll-px 0 50')
config.bind('k', 'scroll-px 0 -50')
config.bind('l', 'scroll-px 70 0')

config.bind('<Shift-Tab>', 'tab-prev')
config.bind('<Tab>', 'tab-next')

config.bind('cs', 'config-source')

config.bind('$', 'fake-key <End>')
config.bind('0', 'fake-key <Home>')

config.bind('<Shift-w>', 'fake-key <Ctrl-Right>')
config.bind('<Shift-b>', 'fake-key <Ctrl-Left>')

config.bind('I', 'fake-key <Home>;; mode-enter insert')
config.bind('A', 'fake-key <End>;; mode-enter insert')

config.bind('dw', 'fake-key <Ctrl+Right><Ctrl+Shift+Left><Delete>')
config.bind('dd', 'fake-key <Home><Shift+End><Delete>')
config.bind('cw', 'fake-key <Ctrl+Right><Ctrl+Shift+Left><Delete>;; mode-enter insert')
config.bind('cc', 'fake-key <Home><Shift+End><Delete>;; mode-enter insert')
config.bind('<Shift-c>', 'fake-key <Shift-End><Delete>;; mode-enter insert')

# Colorscheme
# Github Dark Tritanopia
palette = {
    "rosewater": "#f5e0dc",
    "red": "#ff7b72",
    "peach": "#ffa657",
    "yellow": "#e3b341",
    "green": "#7ee787",
    "teal": "#94e2d5",
    "sky": "#89dceb",
    "blue": "#79c0ff",
    "black": "#010409",
    "magenta": "#d2a8ff",
    "text": "#c9d1d9",
    "subtext1": "#bac2de",
    "subtext0": "#a6adc8",
    "overlay3": "#f85149",
    "overlay2": "#9399b2",
    "overlay1": "#7f849c",
    "overlay0": "#6c7086",
    "surface2": "#264f78",
    "surface1": "#45475a",
    "surface0": "#313244",
    "base": "#0d1117",
    "mantle": "#0d1117",
    "crust": "#6e7681",
}

# Completion {{{
## Background color of the completion widget category headers.
c.colors.completion.category.bg = palette["black"]
## Bottom border color of the completion widget category headers.
c.colors.completion.category.border.bottom = palette["black"]
## Top border color of the completion widget category headers.
c.colors.completion.category.border.top = palette["black"]
## Foreground color of completion widget category headers.
c.colors.completion.category.fg = palette["peach"]
## Background color of the completion widget for even and odd rows.
c.colors.completion.even.bg = palette["mantle"]
c.colors.completion.odd.bg = c.colors.completion.even.bg
## Text color of the completion widget.
c.colors.completion.fg = palette["subtext0"]

## Background color of the selected completion item.
c.colors.completion.item.selected.bg = palette["surface2"]
## Bottom border color of the selected completion item.
c.colors.completion.item.selected.border.bottom = palette["surface2"]
## Top border color of the completion widget category headers.
c.colors.completion.item.selected.border.top = palette["surface2"]
## Foreground color of the selected completion item.
c.colors.completion.item.selected.fg = palette["text"]
## Foreground color of the selected completion item.
c.colors.completion.item.selected.match.fg = palette["rosewater"]
## Foreground color of the matched text in the completion.
c.colors.completion.match.fg = palette["blue"]

## Color of the scrollbar in completion view
c.colors.completion.scrollbar.bg = palette["black"]
## Color of the scrollbar handle in completion view.
c.colors.completion.scrollbar.fg = palette["crust"]
# }}}

# Downloads {{{
c.colors.downloads.bar.bg = palette["base"]
c.colors.downloads.error.bg = palette["base"]
c.colors.downloads.start.bg = palette["base"]
c.colors.downloads.stop.bg = palette["base"]

c.colors.downloads.error.fg = palette["red"]
c.colors.downloads.start.fg = palette["blue"]
c.colors.downloads.stop.fg = palette["green"]
c.colors.downloads.system.fg = "none"
c.colors.downloads.system.bg = "none"
# }}}

# Hints {{{
## Background color for hints. Note that you can use a `rgba(...)` value
## for transparency.
c.colors.hints.bg = palette["blue"]

## Font color for hints.
c.colors.hints.fg = palette["mantle"]

## Hints
c.hints.border = "1px solid " + palette["mantle"]

## Font color for the matched part of hints.
c.colors.hints.match.fg = palette["overlay3"]
# }}}

# Keyhints {{{
## Background color of the keyhint widget.
c.colors.keyhint.bg = palette["mantle"]

## Text color for the keyhint widget.
c.colors.keyhint.fg = palette["text"]

## Highlight color for keys to complete the current keychain.
c.colors.keyhint.suffix.fg = palette["subtext1"]
# }}}

# Messages {{{
## Background color of an error message.
c.colors.messages.error.bg = palette["base"]
## Background color of an info message.
c.colors.messages.info.bg = palette["base"]
## Background color of a warning message.
c.colors.messages.warning.bg = palette["base"]

## Border color of an error message.
c.colors.messages.error.border = palette["mantle"]
## Border color of an info message.
c.colors.messages.info.border = palette["mantle"]
## Border color of a warning message.
c.colors.messages.warning.border = palette["mantle"]

## Foreground color of an error message.
c.colors.messages.error.fg = palette["red"]
## Foreground color an info message.
c.colors.messages.info.fg = palette["text"]
## Foreground color a warning message.
c.colors.messages.warning.fg = palette["peach"]
# }}}

# Prompts {{{
## Background color for prompts.
c.colors.prompts.bg = palette["base"]

# ## Border used around UI elements in prompts.
c.colors.prompts.border = "1px solid " + palette["overlay0"]

## Foreground color for prompts.
c.colors.prompts.fg = palette["text"]

## Background color for the selected item in filename prompts.
c.colors.prompts.selected.bg = palette["surface2"]

## Background color for the selected item in filename prompts.
c.colors.prompts.selected.fg = palette["rosewater"]
# }}}

# Statusbar {{{
## Background color of the statusbar.
c.colors.statusbar.normal.bg = palette["base"]
## Background color of the statusbar in insert mode.
c.colors.statusbar.insert.bg = palette["base"]
## Background color of the statusbar in command mode.
c.colors.statusbar.command.bg = palette["base"]
## Background color of the statusbar in caret mode.
c.colors.statusbar.caret.bg = palette["base"]
## Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = palette["base"]

## Background color of the progress bar.
c.colors.statusbar.progress.bg = palette["base"]
## Background color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.bg = palette["base"]

## Foreground color of the statusbar.
c.colors.statusbar.normal.fg = palette["text"]
## Foreground color of the statusbar in insert mode.
c.colors.statusbar.insert.fg = palette["blue"]
## Foreground color of the statusbar in command mode.
c.colors.statusbar.command.fg = palette["magenta"]
## Foreground color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.fg = palette["peach"]
## Foreground color of the statusbar in caret mode.
c.colors.statusbar.caret.fg = palette["peach"]
## Foreground color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.fg = palette["peach"]

## Foreground color of the URL in the statusbar on error.
c.colors.statusbar.url.error.fg = palette["red"]

## Default foreground color of the URL in the statusbar.
c.colors.statusbar.url.fg = palette["text"]

## Foreground color of the URL in the statusbar for hovered links.
c.colors.statusbar.url.hover.fg = palette["sky"]

## Foreground color of the URL in the statusbar on successful load
c.colors.statusbar.url.success.http.fg = palette["teal"]

## Foreground color of the URL in the statusbar on successful load
c.colors.statusbar.url.success.https.fg = palette["crust"]

## Foreground color of the URL in the statusbar when there's a warning.
c.colors.statusbar.url.warn.fg = palette["peach"]

## PRIVATE MODE COLORS
## Background color of the statusbar in private browsing mode.
c.colors.statusbar.private.bg = palette["mantle"]
## Foreground color of the statusbar in private browsing mode.
c.colors.statusbar.private.fg = palette["subtext1"]
## Background color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.bg = palette["base"]
## Foreground color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.fg = palette["subtext1"]
# }}}

# Tabs {{{
## Background color of the tab bar.
c.colors.tabs.bar.bg = palette["crust"]
## Background color of unselected even tabs.
c.colors.tabs.even.bg = palette["base"]
## Background color of unselected odd tabs.
c.colors.tabs.odd.bg = palette["base"]

## Foreground color of unselected even tabs.
c.colors.tabs.even.fg = palette["overlay2"]
## Foreground color of unselected odd tabs.
c.colors.tabs.odd.fg = palette["overlay2"]

## Color for the tab indicator on errors.
c.colors.tabs.indicator.error = palette["red"]
## Color gradient interpolation system for the tab indicator.
## Valid values:
## - rgb: Interpolate in the RGB color system.
## - hsv: Interpolate in the HSV color system.
## - hsl: Interpolate in the HSL color system.
## - none: Don't show a gradient.
c.colors.tabs.indicator.system = "none"

# ## Background color of selected even tabs.
c.colors.tabs.selected.even.bg = palette["base"]
# ## Background color of selected odd tabs.
c.colors.tabs.selected.odd.bg = palette["base"]

# ## Foreground color of selected even tabs.
c.colors.tabs.selected.even.fg = palette["green"]
# ## Foreground color of selected odd tabs.
c.colors.tabs.selected.odd.fg = palette["green"]
# }}}

# Context menus {{{
c.colors.contextmenu.menu.bg = palette["base"]
c.colors.contextmenu.menu.fg = palette["text"]

c.colors.contextmenu.disabled.bg = palette["mantle"]
c.colors.contextmenu.disabled.fg = palette["overlay0"]

c.colors.contextmenu.selected.bg = palette["overlay0"]
c.colors.contextmenu.selected.fg = palette["rosewater"]
# }}}
