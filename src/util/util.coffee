#<< util/uniquequeue
#<< util/textsize

_ = require 'underscore'




class util.Util

  @hashCode: (s) ->
    f = (a,b)->
      a=((a<<5)-a)+b.charCodeAt(0)
      a&a
    s.split("").reduce(f ,0)

  # reach into object o using path
  #
  # @return value at path, or null
  @reach: (o, path) ->
    for col in path
      break unless o?
      o = o[col]
    o

  @ggklass: (ggpackage) ->
    cmd = "return ('gg' in window)? window.#{ggpackage} : #{ggpackage}"
    Function(cmd)()

  @isValid: (v) -> not(_.isNull(v) or _.isNaN(v) or _.isUndefined(v))

  # @param f returns an array [key, val]
  #        that sets the map's key, value pair
  @o2map: (o, f=((v, idx)->[v,v])) ->
    ret = {}
    _.each o, (args...) ->
      pair = f args...
      ret[pair[0]] = pair[1] if pair?
    ret

  @sum: (arr, f, ctx) -> 
    if f? and _.isFunction f
      arr = _.map arr, f, ctx
    _.reduce arr, ((a,b) -> a+b), 0

  @findGood: (list) ->
    ret = _.find list, (v)->v != null and v?
    if typeof ret is "undefined"
        if list.length then _.last(list) else undefined
    else
        ret

  @findGoodAttr: (obj, attrs, defaultVal=null) ->
    unless obj?
      return defaultVal
    attr = _.find attrs, (attr) -> obj[attr] != null and obj[attr]?
    if typeof attr is "undefined" then defaultVal else obj[attr]

  @isType: (instance, partype) ->
      c = instance
      while c?
          if c.constructor.name is partype.name
              return yes
          unless c.constructor.__super__?
              return no
          c = c.constructor.__super__

  @subSvg: (svg, opts, tag="g") ->
    el = svg.append(tag)
    left = findGood [opts.left, 0]
    top = findGood [opts.top, 0]
    el.attr("transform", "translate(#{left},#{top})")
    _.each opts, (val, attr) ->
      el.attr(attr, val) unless attr in ['left', 'top']
    el

  @repeat: (n, val) -> _.times(n, (->val))

  @min: (arr, f, ctx) ->
    arr = _.reject arr, (v) ->
      _.isNaN(v) or _.isNull(v) or _.isUndefined(v)
    _.min arr, f, ctx

  @max: (arr, f, ctx) ->
    arr = _.reject arr, (v) ->
      _.isNaN(v) or _.isNull(v) or _.isUndefined(v)
    _.max arr, f, ctx

  @cross: (xs, ys) ->
    pairs = []
    for x in xs
      for y in ys
        pairs.push [x, y]
    pairs

  @dateFromISOString: (string) ->
    regexp = "([0-9]{4})(-([0-9]{2})(-([0-9]{2})(T([0-9]{2}):([0-9]{2})(:([0-9]{2})(\.([0-9]+))?)?(Z|(([-+])([0-9]{2}):([0-9]{2})))?)?)?)?"
    d = string.match new RegExp(regexp)

    offset = 0
    date = new Date d[1], 0, 1

    date.setMonth d[3]-1 if d[3]
    date.setDate d[5] if d[5]
    date.setHours d[7] if d[7]
    date.setMinutes d[8] if d[8]
    date.setSeconds d[10] if d[10]
    if d[12]
      date.setMilliseconds(Number("0."+d[12])*1000) 
    if d[14]
      offset = Number(d[16]) * 60 + Number(d[17])
      offset *= if d[15] == '-' then 1 else -1

    offset -= date.getTimezoneOffset()
    time = Number(date) + offset * 60 * 1000
    date.setTime Number(time)
    date




findGood = util.Util.findGood
findGoodAttr = util.Util.findGoodAttr

_.mixin
  toJSON: util.Json.toJSON
  fromJSON: util.Json.fromJSON
  ggklass: util.Util.ggklass
  isValid: util.Util.isValid
  o2map: util.Util.o2map
  sum: util.Util.sum
  mmin: util.Util.min
  mmax: util.Util.max
  findGood: util.Util.findGood
  findGoodAttr: util.Util.findGoodAttr
  isType: util.Util.isSubclass
  subSvg: util.Util.subSvg
  repeat: util.Util.repeat
  #mapToFunction: util.Aesmap.mapToFunction
  #mappingToFunctions: util.Aesmap.mappingToFunctions
  cross: util.Util.cross
  reach: util.Util.reach
  hashCode: util.Util.hashCode
  dateFromISOString: util.Util.dateFromISOString

  textSize: util.Textsize.textSize
  exSize: util.Textsize.exSize
  fontsize: util.Textsize.fontSize
