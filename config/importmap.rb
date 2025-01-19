# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "landing", to: "landing.js"
pin "jquery", to: "jquery.min.js", preload: true
pin "jquery_ujs", to: "jquery_ujs.js", preload: true
pin "jquery-ui", to: "jquery-ui.min.js", preload: true
