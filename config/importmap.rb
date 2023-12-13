# Pin npm packages by running ./bin/importmap
# frozen_string_literal: true

# Pin the 'application' package and preload it
pin 'application', preload: true
# Pin '@hotwired/turbo-rails' package and specify the target file as 'turbo.min.js', preload it
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
# Pin '@hotwired/stimulus' package and specify the target file as 'stimulus.min.js', preload it
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
# Pin '@hotwired/stimulus-loading' package and specify the target file as 'stimulus-loading.js', preload it
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
# Pin all JavaScript controllers from the 'app/javascript/controllers' directory under the 'controllers' namespace
pin_all_from 'app/javascript/controllers', under: 'controllers'
# Pin the 'trix' package
pin 'trix'
# Pin '@rails/actiontext' package and specify the target file as 'actiontext.esm.js'
pin '@rails/actiontext', to: 'actiontext.esm.js'
# Pin 'flowbite' package and specify the target URL
pin 'flowbite', to: 'https://ga.jspm.io/npm:flowbite@2.2.0/lib/esm/index.js'
# Pin '@popperjs/core' package and specify the target URL
pin '@popperjs/core', to: 'https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js'
# Pin '@notus.sh/cocooned' package and specify the target URL
pin '@notus.sh/cocooned', to: 'https://ga.jspm.io/npm:@notus.sh/cocooned@2.0.4/index.js'
