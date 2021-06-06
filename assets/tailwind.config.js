module.exports = {
  purge: {
    enabled: false,
    content: [
      '../**/*.html.eex',
      '../**/*.html.leex',
      '../**/views/**/*.ex',
      '../**/live/**/*.ex',
      './js/**/*.js',
    ],
  },
  darkMode: 'class', // false or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
