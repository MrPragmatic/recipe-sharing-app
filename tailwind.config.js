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
}