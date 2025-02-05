module.exports = {
    content: [
        './public/*.html',
        './app/**/*.html.erb',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js',
        './node_modules/flowbite/**/*.js',
    ],
    theme: {
        extend: {},
    },
    plugins: [
        require('flowbite/plugin'),
    ],
}
