dockerode = require 'dockerode'

class Docker
  constructor: (@host, @port) ->
    @d = new dockerode({host: @host, port: @port})

  # handler = (containerInfo) -> ...function contents...
  listC: (handler) ->
    @d.listContainers (err, containers) ->
      containers.forEach(handler)

module.exports = (host, port) -> new Docker(host, port)
