# Array utility class
class Arr
  constructor: ->

  random: (arr) ->
    idx = Math.floor(Math.random() * arr.length)
    arr[idx]

module.exports = new Arr
