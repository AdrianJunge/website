# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "landing", to: "landing.js"
pin "terminal", to: "terminal.js"
pin "jquery", to: "jquery.min.js", preload: true
pin "jquery_ujs", to: "jquery_ujs.js", preload: true
pin "jquery-ui", to: "jquery-ui.min.js", preload: true
pin "xterm", to: "https://cdn.jsdelivr.net/npm/xterm/lib/xterm.min.js"
pin "xterm-addon-web-links", to: "https://cdn.jsdelivr.net/npm/xterm-addon-web-links/lib/xterm-addon-web-links.min.js"
