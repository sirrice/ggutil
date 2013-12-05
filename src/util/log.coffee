_ = require("underscore")

class util.Log
  @DEBUG = 0
  @INFO = 1
  @WARN = 2
  @ERROR = 3
  @loggers = {}
  @defaults = {}

  # static verisons for...
  @logLevel: (level, args...) ->
    @logger().logLevel level, args...
  @log: (args...) -> @logger().log args...
  @debug: (args...) -> @logLevel @DEBUG, args...
  @info: (args...) -> @logLevel @INFO, args...
  @warn: (args...) -> @logLevel @WARN, args...
  @err: (args...) -> @logLevel @ERROR, args...
  @error: (args...) -> @logLevel @ERROR, args...

  @setDefaults: (defaults) ->
    @defaults = defaults
    _.each @loggers, (log, name) =>
      log.level = @lookupLevel name, log.level

  @lookupLevel: (logname, level=@ERROR) ->
    logname = logname.toLowerCase()
    prefixlen = -1
    _.each @defaults, (defaultLevel, nameprefix) ->
      nameprefix = nameprefix.toLowerCase()
      if (nameprefix.length > prefixlen and
          logname.search("^"+nameprefix) >= 0)
        level = defaultLevel
        prefixlen = nameprefix.length

    level

  @reset: -> util.Log.loggers = {}

  @logger: (logname="", prefix, level=util.Log.ERROR) ->
    prefix = logname unless prefix?
    loggers = util.Log.loggers
    level = @lookupLevel logname, level
    loggers[logname] = {} unless logname of loggers
    unless prefix of loggers[logname]
      logger = new util.Log logname, prefix, level
      loggers[logname][prefix] = logger
    return loggers[logname][prefix]

  constructor: (@logname, @prefix, @level=util.Log.ERROR) ->
    @prefix = @logname unless @prefix?
    callable = (args...) -> callable.debug args...
    _.extend callable, @
    return callable

  # pass through
  log: (args...) ->
    @logLevel @level, args...

  logLevel: (level, args...) ->
    if level >= @level
      prefix = switch level
        when util.Log.DEBUG then "D"
        when util.Log.DEBUG then "I"
        when util.Log.WARN then "W"
        when util.Log.ERROR then "E"
        else "?"
      prefix = "#{prefix} "
      if @prefix != ""
        prefix = "#{prefix}[#{@prefix}]:\t"
      args.unshift prefix
      console.log args...

  debug: (args...) -> @logLevel util.Log.DEBUG, args...
  info: (args...) -> @logLevel util.Log.INFO, args...
  warn: (args...) -> @logLevel util.Log.WARN, args...
  err: (args...) -> @logLevel util.Log.ERROR, args...
  error: (args...) -> @logLevel util.Log.ERROR, args...





