
class util.Timer
  constructor: (@threshold=null) ->
    try
      @timer = performance
      @timer.now()
    catch err
      @timer = Date

    @_starts = {}
    @_timings = {}
    @_traces = {}

  @time: (f, n=1, cb) ->
    _timer = new util.Timer
    _timer.start()
    res = null
    for i in [0...n]
      if i == 0
        res = f()
      else
        f()
    _timer.stop()
    if cb?
      cb _timer
    res


  start: (name=null)->
    @_starts[name] = @timer.now()

  stop: (name=null) -> @end name

  end: (name=null) ->
    cost = -1
    start = @_starts[name]
    if start?
      cost = @timer.now() - start
      unless name of @_timings
        @_timings[name] = []
      @_timings[name].push cost

    @_starts[name] = null

    if @threshold? and cost > @threshold
      @_traces[name] = [] unless name of @_traces
      @_traces[name].push (new Error("#{name}\t#{cost}"))
    cost

  has: (name=null) -> name of @_timings

  names: ->
    _.keys @_timings

  timings: (name=null) -> 
    if @_timings[name]?
      @_timings[name]
    else
      []

  avg: (name=null) ->
    times = @timings name
    if times.length > 0
      d3.mean times
    else
      NaN

  count: (name=null) ->
    @timings(name).length

  sum: (name=null) ->
    times = @timings name
    if times.length > 0
      d3.sum times
    else
      NaN


  toString: (threshold=null)->
    ret = ""
    _.each @names(), (name) =>
      sum = @sum(name).toPrecision 4
      count = @count name
      max = d3.max(@timings(name)).toPrecision 4
      min = d3.min(@timings(name)).toPrecision 4
      if not(threshold?) or sum > threshold
        ret += "#{name}\t#{sum}/#{count}\t[#{min}, #{max}]\n"
    ret
