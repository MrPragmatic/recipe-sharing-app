const esbuild = require('esbuild');
const postcss = require('postcss');
const tailwindcss = require('tailwindcss');

const buildStyles = async (input) => {
    const result = await postcss([tailwindcss('./tailwind.config.js')])
        .process(input, { from: undefined });

    return result.css;
};

esbuild.build({
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
                    const contents = await buildStyles(args.path);
                    return { contents, loader: 'css' };
                });
            },
        },
    ],
}).catch(() => process.exit(1));