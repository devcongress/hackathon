const { execSync } = require("child_process");
const plutoniumGemPath = execSync("bundle show plutonium").toString().trim();
const plutoniumTailwindConfig = require(`${plutoniumGemPath}/tailwind.options.js`);
const tailwindPlugin = require("tailwindcss/plugin");

module.exports = {
  darkMode: plutoniumTailwindConfig.darkMode,
  plugins: [
    // add plugins here
  ].concat(
    plutoniumTailwindConfig.plugins.map(function (plugin) {
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
          50: "#E8F5E9", // Lightest shade for subtle backgrounds
          100: "#C8E6C9", // Light shade for secondary elements
          200: "#A5D6A7", // Light shade for accents
          300: "#81C784", // Mid-light shade for buttons or icons
          400: "#66BB6A", // Mid shade for primary actions
          500: "#4CAF50", // Base green for primary elements
          600: "#43A047", // Slightly darker for hover states
          700: "#388E3C", // Darker shade for active states
          800: "#2E7D32", // Dark shade for text or strong accents
          900: "#1B5E20", // Darkest shade for high-contrast text
          950: "#0D3B10", // Very dark for backgrounds or large text
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
