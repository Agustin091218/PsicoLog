pin "application", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "https://ga.jspm.io/npm:@hotwired/stimulus-loading@2.0.1/dist/stimulus-loading.js"
pin "trix", to: "https://cdn.jsdelivr.net/npm/trix@2.1.0/dist/trix.umd.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
