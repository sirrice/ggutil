require "./env"
us = require "underscore"
assert = require "assert"

util.Log.setDefaults {'util.Textsize':0}
util.Log.setDefaults {'util.layout':0}

el = d3.select(document).select('body')


boxes = _.times 100, (i) ->
  x = Math.random() * 100
  y = Math.random() * 50
  w = 20
  h = 10
  [[x, x+w],[y, y+h]]
newboxes = util.layout.Anneal.anneal boxes, 1.0
for box in boxes
  console.log box

throw Error
getstring = (n) ->
  us.times(n, (idx) -> String(Math.random())).join("").substr(0, n)

console.log util.Textsize.textSize getstring(10), {}, el[0][0]
console.log util.Textsize.textSize getstring(100), {}, el[0][0]

console.log util.Textsize.fontSize getstring(10), 200, 200, {}, el[0][0]
console.log util.Textsize.fontSize getstring(20), 200, 200, {}, el[0][0]
console.log util.Textsize.fontSize getstring(100), 200, 200, {}, el[0][0]

