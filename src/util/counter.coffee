class util.Counter

  constructor: (data) ->
    @o = {}
    _.each data, (v, k) => @inc k

  inc: (key, v=1) ->
    unless key of @o
      @o[key] = 0
    @o[key] += v

  get: (key) -> 
    @o[key] or 0

  each: (f) -> _.map @o, f

  toString: ->
    lines = _.map @o, (v, k) -> "#{k}\t#{v}"
    lines.join('\n')


