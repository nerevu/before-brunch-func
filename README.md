## before-brunch-func
Want to run a javascript function every time [brunch](http://brunch.io) compiles? Easy.

## Usage

Add `"before-brunch-func": "x.y.z"` to `package.json` of your brunch app.
Or `npm install before-brunch-func --save`.

Then in your `config.coffee` just add to the `func` parameter, a function that
accepts an `errback` as its only argument . E.g.

```coffeescript
beforeFunc = (errback) ->
  console.log 'hello world'
  errback false
```

For example, you might want to build [metalsmith](https://metalsmith.io) before each compile.

```coffeescript
metalsmith = require './metalsmith'

exports.config =
  …
  plugins:
    before:
      func: metalsmith.build.bind(metalsmith)
      pattern: /^src/  # default
      warnOnly: false  # default
      firstCompileOnly: false  # default
```
