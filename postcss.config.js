// const postcss = require("postcss");
const doiuse = require("doiuse");
const autoprefixer = require("autoprefixer");
const postcssCustomMedia = require("postcss-custom-media");

const OpenProps = require("open-props");
const postcssJitProps = require("postcss-jit-props");

module.exports = {
  plugins: [
    autoprefixer,
    doiuse,
    postcssCustomMedia(),
    postcssJitProps(OpenProps),
  ],
};
