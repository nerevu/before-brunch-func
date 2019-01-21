debug = require("debug")("before-brunch")
debounce = require "lodash.debounce"
partial = require "lodash.partial"

_runner = (func, warnOnly, options) =>
  msg = "run triggered by #{options.source}"

  if options.path
    msg = "#{msg} because of change in file: #{options.path}"

  debug msg

  new Promise (resolve, reject) =>
    func (err) =>
      if err
        debug "run error:"

        if warnOnly
          resolve false
        else
          reject err

      else
        debug "run successfully finished!"
        resolve true

module.exports = class Before
  brunchPlugin: true
  type: 'template'

  constructor: (config) ->
    params = config.plugins.before or {}
    @pattern = params.pattern or /^src/
    @warnOnly = if params.warnOnly? then params.warnOnly else false
    @firstCompileOnly = if params.firstCompileOnly? then params.firstCompileOnly else false

    if params.func
      runner = partial _runner, params.func, @warnOnly
      wait = params.wait or 500
      @runner = debounce runner, wait, {
        'leading': true
        'trailing': false
      }

    else if @warnOnly
      debug "You must supply a 'func' option"
    else
      throw "You must supply a 'func' option"

  preCompile: =>
    # before first metalsmith compile
    @runner {path: '', source: 'preCompile'}

  lint: (file) =>
    # js and css files
    unless @firstCompileOnly
      @runner {path: file.path, source: 'lint'}

  compileStatic: (file) =>
    # md and html files
    unless @firstCompileOnly
      @runner {path: file.path, source: 'compileStatic'}
