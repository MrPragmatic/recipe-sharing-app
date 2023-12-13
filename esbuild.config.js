// Import required libraries
const esbuild = require('esbuild');
const postcss = require('postcss');
const tailwindcss = require('tailwindcss');

// Asynchronous function to process and build styles using PostCSS and Tailwind CSS
const buildStyles = async (input) => {
    const result = await postcss([tailwindcss('./tailwind.config.js')])
        .process(input, { from: undefined });

    return result.css;
};

// Use esbuild to build the JavaScript and CSS assets
esbuild.build({
    // Specify the entry point for JavaScript
    entryPoints: ['app/javascript/application.js'],
    // Bundle the JavaScript code
    bundle: true,
    // Specify the output file for the bundled JavaScript
    outfile: 'public/packs/application.js',
    // External dependencies to exclude from bundling
    external: ['@hotwired/turbo-rails'],
    // Specify the platform as 'node'
    platform: 'node',
    // Configure plugins for additional processing, e.g., PostCSS for CSS
    plugins: [
        {
            // PostCSS plugin setup
            name: 'postcss',
            setup: async (build) => {
                build.onLoad({ filter: /\.css$/ }, async (args) => {
                    // Process styles using the buildStyles function
                    const contents = await buildStyles(args.path);
                    // Return the processed CSS contents and set the loader to 'css'
                    return { contents, loader: 'css' };
                });
            },
        },
    ],
}).catch(() => process.exit(1));  // Catch any errors during the build process and exit with a non-zero status code