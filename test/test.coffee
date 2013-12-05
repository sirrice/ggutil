require "./env"
us = require "underscore"
assert = require "assert"

util.Log.setDefaults {'util.Textsize':0}

el = d3.select(document).select('body')


getstring = (n) ->
  us.times(n, (idx) -> String(Math.random())).join("").substr(0, n)

console.log util.Textsize.textSize getstring(10), {}, el[0][0]
console.log util.Textsize.textSize getstring(100), {}, el[0][0]

console.log util.Textsize.fontSize getstring(10), 200, 200, {}, el[0][0]
console.log util.Textsize.fontSize getstring(20), 200, 200, {}, el[0][0]
console.log util.Textsize.fontSize getstring(100), 200, 200, {}, el[0][0]

