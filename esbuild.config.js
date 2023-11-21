const postcssPlugin = require('esbuild-plugin-postcss');
const tailwindcss = require('tailwindcss');

const buildStyles = async () => {
    const result = await postcssPlugin({
        plugins: [
            tailwindcss('./tailwind.config.js'),
            // Add other postcss plugins if needed
        ],
    }).process('@import "app/assets/stylesheets/application.css"', {
        from: undefined,
    });

    return result.css;
};

require('esbuild').build({
    entryPoints: ['app/javascript/application.js'],
    bundle: true,
    outfile: 'public/packs/application.js',
    external: ['@hotwired/turbo-rails'],
    platform: 'node',
    plugins: [
        {
            name: 'postcss',
            setup: async (build) => {
                build.onLoad({ filter: /\.css$/ }, async (args) => {
                    const contents = await buildStyles();
                    return { contents, loader: 'css' };
                });
            },
        },
    ],
}).catch(() => process.exit(1));