module.exports = {
    plugins: [
        require('postcss-import'),
        require('tailwindcss'),
        require('postcss-nesting'),
        require('tailwindcss/nesting'),
        require('autoprefixer')
    ],
};