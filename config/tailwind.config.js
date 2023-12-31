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
      backgroundColor: {
        beige: "#FFF2D8",
        darkblue: "#113946",
        lightblue: '#b7d8e2'
      },
      colors: {
        beige: "#FFF2D8",
        lightgray: "#F5F5F5",
        darkblue: "#113946",
      },
      height: {
        'h10': '10%',
        'h20': '20%',
        'h60': '60%',
        'h70': '70%',
        'h80': '80%',
      },
      minHeight: {
        '80': '80%',
      },
      width: {
        'w20': '20%',
        'w30': '30%',
        'w40': '40%',
        'w55': '55%',
        'w80': '80%',
      },
      gridTemplateRows: {
        'cards': '2fr 1fr',
      },
      gridTemplateColumns: {
        'cards': '1fr 1fr',
      },
      scale: {
        '101': '1.01',
      },
      translate: {
        '300': '-300%',
      },
      keyframes: {
        burgerin: {
          '0%': { transform: 'translateY(-300%)' },
          '100%': { transform: 'translateY(0)' },
        },
        burgerout: {
          '0%': { transform: 'translateY(0)' },
          '100%': { transform: 'translateY(-300%)' },
        },
        diagone: {
          '0%': { transform: 'translateY(0)' },
          '100%': { transform: 'translateY(10px) rotate(45deg) scale(0.9)' },
        },
        diagoneout: {
          '0%': { transform: 'translateY(10px) rotate(45deg) scale(0.9)' },
          '100%': { transform: 'translateY(0) rotate(0) scale(1)' },
        },
        diagtwo: {
          '0%': { transform: 'translateY(0)' },
          '100%': { transform:  'rotate(-45deg) scale(0.9)' },
        },
        diagtwoout: {
          '0%': { transform: 'rotate(-45deg) scale(0.9)' },
          '100%': { transform: 'translateY(0) rotate(0) scale(1)' },
        },
        animatediv: {
          '0%': { transform: 'translateX(-100%)', opacity: 0 },
          '100%': { transform: 'translateX(0)', opacity: 1 },
        },
        animatep: {
          '0%': { transform: 'translateX(100%)', opacity: 0 },
          '100%': { transform: 'translateX(0)', opacity: 1 },
        },
        aboutpagediv: {
          '0%': { transform: 'translateY(10%)', opacity: 0 },
          '100%': { transform: 'translateY(0)', opacity: 1 },
        },
        flashdisappear: {
          '0%': { opacity: 1 },
          '100%': { opacity: 0 },
        }
      },
      animation: {
        // menu burger animation
        burgerin: 'burgerin 1s ease-in-out',
        burgerout: 'burgerout 1s ease-in-out forwards',
        diagone: 'diagone 150ms ease-in-out both',
        diagtwo: 'diagtwo 150ms ease-in-out both',
        diagoneout: 'diagoneout 150ms ease-in-out both',
        diagtwoout: 'diagtwoout 150ms ease-in-out both',
        // card animation on homepage
        animatediv: 'animatediv 1000ms ease-in-out both',
        animatep: 'animatep 1000ms ease-in-out both',
        aboutpagediv: 'aboutpagediv 500ms ease-in-out both',
        flashdisappear: 'flashdisappear 500ms ease-in-out both'
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
