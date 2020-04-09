let mix = require('laravel-mix');

// Path to resources folder
const resources = 'public/resources';

// Set paths to all source & distribution folders
let src = {
    sass: `${resources}/sass`,
    js:   `${resources}/js/src`,
};
let dist = {
    css: `${resources}/css`,
    js:  `${resources}/js/dist`,
};

// Run Mix
mix
    .sass(`${src.sass}/cp.scss`,     dist.css)
    .sass(`${src.sass}/styles.scss`, dist.css)
    // .js(`${src.js}/scripts.js`, dist.js)
    .disableNotifications();
