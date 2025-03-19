config.load_autoconfig()
config.set('content.javascript.clipboard', 'access-paste')
config.set('content.autoplay', False) # Disable video autoplay
# c.content.javascript.enabled = False  # Disable globally
# c.content.javascript.clipboard = "access"  # Allow clipboard access
for mode in ["normal", "caret"]:
    config.bind("gs", "spawn --userscript yomichad", mode=mode)
    config.bind("gS", "spawn --userscript yomichad --prefix-search", mode=mode)
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.bg", "grey")

config.bind("xs", "config-cycle statusbar.show always never")
config.bind("xt", "config-cycle tabs.show always never")
config.bind("xx", "config-cycle tabs.show always never;; config-cycle statusbar.show always never")
config.bind("Alt+o", "cmd-set-text -s :open -b")
config.bind("Alt+O", "cmd-set-text -s :open -w")
config.bind(",v", "spawn mpv {url}")  # Open video links in MPV
config.bind(",y", "hint links yank")  # Copy link URLs to clipboard
config.bind('<Tab>', 'tab-next', mode='normal')
config.bind('<Shift-Tab>', 'tab-prev', mode='normal')


c.url.searchengines = {
        "DEFAULT": "https://duckduckgo.com/?q={}&ia=web",
        "!dd": "https://thefreedictionary.com/{}",
        "!cmk": "https://comick.io/search?q={}",
        "!fb": "https://www.facebook.com/s.php?q={}",
        "!gh": "https://github.com/search?o=desc&q={}&s=stars",
        "!gist": "https://gist.github.com/search?q={}",
        "!gi": "https://www.google.com/search?tbm=isch&q={}&tbs=imgo:1",
        "!ig": "https://www.instagram.com/explore/tags/{}",
        "!m": "https://www.google.com/maps/search/{}",
        # "!p": "https://pry.sh/{}",
        "!r": "https://www.reddit.com/search?q={}",
        "!t": "https://www.thesaurus.com/browse/{}",
        "!tw": "https://twitter.com/search?q={}",
        "!mal": "https://myanimelist.net/search/all?q={}&cat=all",
        "!w": "https://en.wikipedia.org/wiki/{}",
        "!yt": "https://www.youtube.com/results?search_query={}",
        "!ji": "https://jisho.org/search/{}",
        }

# Set the default font to JetBrains Mono
c.fonts.default_family = ["JetBrains Mono"]
c.fonts.default_size = "12pt"

# Status bar font
c.fonts.statusbar = "12pt JetBrains Mono"

# Tab bar font
c.fonts.tabs.selected = "12pt JetBrains Mono"
c.fonts.tabs.unselected = "12pt JetBrains Mono"

# Hints font
c.fonts.hints = "bold 12pt JetBrains Mono"

# Download bar font
c.fonts.downloads = "12pt JetBrains Mono"

# Completion menu font
c.fonts.completion.entry = "12pt JetBrains Mono"
c.fonts.completion.category = "bold 12pt JetBrains Mono"

# c.content.blocking.method = 'adblock'
c.content.blocking.adblock.lists = [
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt"]

# color-scheme
one_light = colorscheme = {
        'background': '#111',
        'foreground': '#ffffff',
        'current_line': '#333',
        'comment': '#808080',
        'cyan': '#00FFFF',
        'violet': '#800080',
        'green': '#008000',
        'orange': '#FFA500',
        'pink': '#FFC0CB',
        'purple': '#800080',
        'red': '#FF0000',
        'yellow': '#FFFF00',
        'magenta': '#FF00FF',
        'blue': '#0000FF',
        'highlight': '#C9E4CA',
        }
# one_light = colorscheme = {
#     'background': '#fafafa',
#     'foreground': '#383a42',
#     'current_line': '#e5e9f0',
#     'comment': '#a0a1a7',
#     'cyan': '#0184bc',
#     'violet': '#b48ead',
#     'green': '#50a14f',
#     'orange': '#c18401',
#     'pink': '#d33682',
#     'purple': '#a626a4',
#     'red': '#e45649',
#     'yellow': '#986801',
#     'magenta': '#b48ead',  # Added magenta
#     'blue': '#4078f2',
#     'highlight': '#add8ff',
# }

c.colors.completion.category.bg = one_light['background']
c.colors.completion.category.border.bottom = one_light['background']
c.colors.completion.category.border.top = one_light['background']
c.colors.completion.category.fg = one_light['blue']
c.colors.completion.even.bg = one_light['current_line']
c.colors.completion.fg = one_light['foreground']
c.colors.completion.item.selected.bg = one_light['highlight']
c.colors.completion.item.selected.border.bottom = one_light['highlight']
c.colors.completion.item.selected.border.top = one_light['highlight']
c.colors.completion.item.selected.fg = one_light['foreground']
c.colors.completion.match.fg = one_light['blue']
c.colors.completion.odd.bg = one_light['current_line']
c.colors.completion.scrollbar.bg = one_light['current_line']
c.colors.completion.scrollbar.fg = one_light['blue']
c.colors.downloads.bar.bg = one_light['background']
c.colors.downloads.error.bg = one_light['red']
c.colors.downloads.error.fg = one_light['background']
c.colors.downloads.start.bg = one_light['blue']
c.colors.downloads.start.fg = one_light['background']
c.colors.downloads.stop.bg = one_light['green']
c.colors.downloads.stop.fg = one_light['background']
c.colors.hints.bg = one_light['blue']
c.colors.hints.fg = one_light['background']
c.colors.hints.match.fg = one_light['foreground']
c.colors.messages.error.bg = one_light['red']
c.colors.messages.error.border = one_light['red']
c.colors.messages.error.fg = one_light['background']
c.colors.messages.info.bg = one_light['current_line']
c.colors.messages.info.border = one_light['current_line']
c.colors.messages.info.fg = one_light['foreground']
c.colors.messages.warning.bg = one_light['orange']
c.colors.messages.warning.border = one_light['orange']
c.colors.messages.warning.fg = one_light['background']
c.colors.prompts.bg = one_light['current_line']
c.colors.prompts.border = '1px solid ' + one_light['foreground']
c.colors.prompts.fg = one_light['foreground']
c.colors.prompts.selected.bg = one_light['highlight']
c.colors.statusbar.caret.bg = one_light['blue']
c.colors.statusbar.caret.fg = one_light['background']
c.colors.statusbar.caret.selection.bg = one_light['violet']
c.colors.statusbar.caret.selection.fg = one_light['background']
c.colors.statusbar.command.bg = one_light['background']
c.colors.statusbar.command.fg = one_light['foreground']
c.colors.statusbar.command.private.bg = one_light['current_line']
c.colors.statusbar.command.private.fg = one_light['foreground']
c.colors.statusbar.insert.bg = one_light['green']
c.colors.statusbar.insert.fg = one_light['background']
c.colors.statusbar.normal.bg = one_light['background']
c.colors.statusbar.normal.fg = one_light['foreground']
c.colors.statusbar.passthrough.bg = one_light['magenta']
c.colors.statusbar.passthrough.fg = one_light['background']
c.colors.statusbar.private.bg = one_light['current_line']
c.colors.statusbar.private.fg = one_light['foreground']
c.colors.statusbar.progress.bg = one_light['foreground']
c.colors.statusbar.url.error.fg = one_light['red']
c.colors.statusbar.url.fg = one_light['foreground']
c.colors.statusbar.url.hover.fg = one_light['blue']
c.colors.statusbar.url.success.http.fg = one_light['foreground']
c.colors.statusbar.url.success.https.fg = one_light['foreground']
c.colors.statusbar.url.warn.fg = one_light['orange']
c.colors.tabs.bar.bg = one_light['background']
c.colors.tabs.even.bg = one_light['current_line']
c.colors.tabs.even.fg = one_light['foreground']
c.colors.tabs.indicator.error = one_light['red']
c.colors.tabs.indicator.start = one_light['blue']
c.colors.tabs.indicator.stop = one_light['green']
c.colors.tabs.odd.bg = one_light['current_line']
c.colors.tabs.odd.fg = one_light['foreground']
c.colors.tabs.selected.even.bg = one_light['background']
c.colors.tabs.selected.even.fg = one_light['blue']
c.colors.tabs.selected.odd.bg = one_light['background']
c.colors.tabs.selected.odd.fg = one_light['blue']
