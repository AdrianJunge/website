# Pin npm packages by running ./bin/importmap

pin "application", preload: true

pin "landing", to: "landing.js"
pin "terminal", to: "terminal.js"
pin "ctf", to: "ctf.js"

pin "flowbite", to: "flowbite.turbo.min.js"
# pin "flowbite", to: "https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.turbo.min.js"
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"
pin "jquery-ujs", to: "https://cdn.jsdelivr.net/npm/jquery-ujs@1.2.3/src/rails.min.js"
pin "jquery-ui", to: "https://cdn.jsdelivr.net/npm/jquery-ui@1.14.1/dist/jquery-ui.min.js"

pin "xterm", to: "https://cdn.jsdelivr.net/npm/xterm/lib/xterm.min.js"
pin "xterm-addon-web-links", to: "https://cdn.jsdelivr.net/npm/xterm-addon-web-links/lib/xterm-addon-web-links.min.js"
pin "xterm-addon-fit", to: "https://cdn.jsdelivr.net/npm/@xterm/addon-fit@0.10.0/lib/addon-fit.min.js"

pin "mathjax", to: "https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js", preload: true
