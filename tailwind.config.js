module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './app/views/**/*/.html.erb',
    './node_modules/flowbite/**/*.js'
  ],
  theme: {
    extend: {},
  },
  plugins: [
    'tailwindcss: {}',
    'autoprefixer: {}',
    require('flowbite/plugin'),
  ]
}// Configuration file for Tailwind CSS

module.exports = {
  // Content files to process with Tailwind CSS
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './app/views/**/*/.html.erb',
    './node_modules/flowbite/**/*.js'
  ],

  // Theme extension (if any)
  theme: {
    extend: {},
  },

  // Plugins to use with Tailwind CSS
  plugins: [
    'tailwindcss: {}',  // Tailwind CSS plugin configuration
    'autoprefixer: {}',  // Autoprefixer plugin configuration
    require('flowbite/plugin'),  // Flowbite plugin
  ]
}