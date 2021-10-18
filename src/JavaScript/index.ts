const { Elm } = require("../Main.elm");
import "./load_stylesheet";

let elmApp = Elm.Main.init({
  node: document.getRootNode(),
});
