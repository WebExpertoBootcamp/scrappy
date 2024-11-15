const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        primary: '#14532D', // Agrega el color primario
      },
      keyframes: {
        borderAnimation: {
          '0%, 100%': { borderColor: 'transparent' },
          '50%': { borderColor: 'red' },
        },
      },
      animation: {
        borderAnimation: 'borderAnimation 1s infinite alternate',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
