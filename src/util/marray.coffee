
# Array that tracks its empty indicies to resue them
class util.MArray extends Array
  constructor: ->
    super
    @emptyidxs = []

  rm: (o) ->
    idx = _.indexOf @, o
    @rmIdx idx

  rmIdx: (idx) ->
    if idx >= 0 and idx < @length
      @[idx] = null
      @emptyidxs.push idx

  add: (o) ->
    if @emptyidxs.length > 0
      idx = @emptyidxs.pop()
      @[idx] = o
    else
      idx = @length
      @push o
    idx


