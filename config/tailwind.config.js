const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/**/*'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      animation: {
        'fadeIn': 'fadeIn .3s ease-in-out',
      },
      keyframes: {
        fadeIn: {
          '0%': { 
            opacity: '0',
            scale: '0.95'
          },
          '100%': { 
            opacity: '1',
            scale: '1'
          },
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
