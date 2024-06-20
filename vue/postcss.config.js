const customPrefixer = require('./custom-prefixer');

module.exports = {
  plugins: [
    require('tailwindcss'),
    require('autoprefixer'),
    customPrefixer
  ],
};
