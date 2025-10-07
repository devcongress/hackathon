const { execSync } = require("child_process");
const plutoniumGemPath = execSync("bundle show plutonium").toString().trim();
const plutoniumTailwindConfig = require(`${plutoniumGemPath}/tailwind.options.js`);
const tailwindPlugin = require("tailwindcss/plugin");

module.exports = {
  darkMode: plutoniumTailwindConfig.darkMode,
  plugins: [
    // add plugins here
  ].concat(
    plutoniumTailwindConfig.plugins.map(function(plugin) {
      switch (typeof plugin) {
        case "function":
          return tailwindPlugin(plugin);
        case "string":
          return require(plugin);
        default:
          throw Error(`unsupported plugin: ${plugin}: ${typeof plugin}`);
      }
    })
  ),
  theme: plutoniumTailwindConfig.merge(plutoniumTailwindConfig.theme, {
    extend: {
      colors: {
        primary: {
          50: "#E0F7FE", // Lightest shade for subtle backgrounds
          100: "#B3ECFD", // Light shade for secondary elements
          200: "#80DFFC", // Light shade for accents
          300: "#4DD2FB", // Mid-light shade for buttons or icons
          400: "#26C8FA", // Mid shade for hover states
          500: "#00AEEF", // Base cyan for primary elements
          600: "#009DD6", // Slightly darker for active states
          700: "#0089BC", // Darker shade for pressed states
          800: "#0075A3", // Dark shade for text or strong accents
          900: "#005A7D", // Darkest shade for high-contrast text
          950: "#003D54", // Very dark for backgrounds or large text
        },
      },
    },
  }),
  content: [
    `${__dirname}/app/**/*.{erb,haml,html,slim,rb}`,
    `${__dirname}/app/assets/stylesheets/**/*.css`,
    `${__dirname}/app/javascript/**/*.js`,
    `${__dirname}/packages/**/app/**/*.{erb,haml,html,slim,rb}`,
  ].concat(plutoniumTailwindConfig.content),
};
