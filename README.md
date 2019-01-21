## before-brunch-func
Want to run a javascript function every time [brunch](http://brunch.io) compiles? Easy.

## Usage

Add `"before-brunch-func": "x.y.z"` to `package.json` of your brunch app.
Or `npm install before-brunch-func --save`.

Then in your `config.coffee` just add any function that accepts an `errback` as its only
argument to the `func` parameter. E.g.

```coffeescript
beforeFunc = (errback) ->
  # do stuff
  errback false
```

For example, you might want to build [metalsmith](https://metalsmith.io) before each compile.

```coffeescript
exports.config =
  …
  plugins:
    before:
      func: metalsmith.build.bind(metalsmith),
      pattern: /^src/, // default
      warnOnly: false,  // default
      firstCompileOnly: false  // default
```
