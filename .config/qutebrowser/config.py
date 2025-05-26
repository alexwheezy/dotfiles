import themes.catppuccin as catppuccin

# load your autoconfig, use this, if the rest of your config is empty!
config.load_autoconfig()

# set colorscheme
# set the flavor you'd like to use
# valid options are 'mocha', 'macchiato', 'frappe', and 'latte'
# last argument (optional, default is False): enable the plain look for the menu rows
catppuccin.setup(c, 'mocha', True)

c.url.searchengines = {
    # note - if you use duckduckgo, you can make use of its built in bangs, of which there are many! https://duckduckgo.com/bangs
    'DEFAULT': 'https://google.com/?q={}',
    '!aw': 'https://wiki.archlinux.org/?search={}',
    '!apkg': 'https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=',
    '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
    '!yt': 'https://www.youtube.com/results?search_query={}',
}

# styles, cosmetics
# c.content.user_stylesheets = ["~/.config/qutebrowser/styles/youtube-tweaks.css"]
c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 5, 'right': 5}
c.tabs.indicator.width = 0 # no tab indicators
# c.window.transparent = True # apparently not needed
c.tabs.width = '7%'

# fonts
# c.fonts.default_family = []
# c.fonts.default_size = '10pt'
# c.fonts.web.family.fixed = 'monospace'
# c.fonts.web.family.sans_serif = 'monospace'
# c.fonts.web.family.serif = 'monospace'
# c.fonts.web.family.standard = 'monospace'

# font = 'SauceCodeProNerdFont'
# c.fonts.default_size = '14px'
# c.fonts.completion.entry = font
# c.fonts.completion.category = font
# c.fonts.debug_console = font
# c.fonts.downloads = font
# c.fonts.hints = font
# c.fonts.keyhint = font
# c.fonts.messages.info = font
# c.fonts.messages.error = font
# c.fonts.prompts = font
# c.fonts.statusbar = font


font = 'SauceCodeProNerdFont'
c.fonts.default_family = ['SauceCodeProNerdFont']
c.fonts.default_size = '15px'
c.fonts.web.family.fixed = font
c.fonts.web.family.sans_serif = font
c.fonts.web.family.serif = font
c.fonts.web.family.standard = font
