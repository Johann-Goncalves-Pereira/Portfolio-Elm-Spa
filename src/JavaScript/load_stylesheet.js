function requireAll(r) {
  r.keys().forEach(r);
}

requireAll(require.context("../Stylesheet", true, /\.*/));
