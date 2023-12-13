// Import the default theme configuration from Tailwind CSS
const defaultTheme = require('tailwindcss/defaultTheme');

// Export the Tailwind CSS configuration for the project
module.exports = {
  // Specify the files to process for generating the CSS
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
    "./node_modules/flowbite/**/*.js",
  ],

  // Define the theme customization
  theme: {
    extend: {
      // Extend the font family by adding 'Inter var' to the sans-serif font stack
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },

  // Include additional Tailwind CSS plugins
  plugins: [
    // Tailwind CSS forms plugin
    require('@tailwindcss/forms'),
    // Tailwind CSS aspect ratio plugin
    require('@tailwindcss/aspect-ratio'),
    // Tailwind CSS typography plugin
    require('@tailwindcss/typography'),
    // Tailwind CSS container queries plugin
    require('@tailwindcss/container-queries'),
    // Flowbite plugin for Tailwind CSS
    require('flowbite/plugin'),
  ],
};