function requireAll(r) {
  r.keys().forEach(r);
}

requireAll(require.context("../Stylesheet", true, /\.*/));
// requireAll(require.context("../Stylesheet/components/", true, /\.*/));
// requireAll(require.context("../Stylesheet/components/kelpie", true, /\.*/));
// requireAll(require.context("../Stylesheet/Playground", true, /\.*/));
