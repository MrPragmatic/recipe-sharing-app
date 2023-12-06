# Pin npm packages by running ./bin/importmap
# frozen_string_literal: true

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'trix'
pin '@rails/actiontext', to: 'actiontext.esm.js'
pin 'flowbite', to: 'https://ga.jspm.io/npm:flowbite@2.2.0/lib/esm/index.js'
pin '@popperjs/core', to: 'https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js'
pin '@notus.sh/cocooned', to: 'https://ga.jspm.io/npm:@notus.sh/cocooned@2.0.4/index.js'
