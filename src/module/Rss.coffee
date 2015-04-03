parser = require 'parse-rss'

class Rss
  constructor: ->

  # key and feedurl
  rdfs:
    "dqn": "http://blog.livedoor.jp/dqnplus/index.rdf"
    "hima": "http://himasoku.com/index.rdf"
    "htnn": "http://b.hatena.ne.jp/entrylist?sort=hot&threshold=&mode=rss"
    "htnh": "http://b.hatena.ne.jp/hotentry?sort=hot&threshold=&mode=rss"
    "htnni": "http://b.hatena.ne.jp/entrylist/it?sort=hot&threshold=&mode=rss"
    "htnhi": "http://b.hatena.ne.jp/hotentry/it.rss"
    "hngo": "http://hnapp.com/rss?q=go%20score%3E50"
    "hndocker": "http://hnapp.com/rss?q=docker%20score%3E50"
    "hnlinux": "http://hnapp.com/rss?q=linux%20score%3E50"
    "hnzsh": "http://hnapp.com/rss?q=zsh%20score%3E50"
    "hndevops": "http://hnapp.com/rss?q=devops%20score%3E30"
    "hnpay": "http://hnapp.com/rss?q=payment%20score%3E50"
    "hnfund": "http://hnapp.com/rss?q=fund%20score%3E30"
    "hnbc": "http://hnapp.com/rss?q=bitcoin%20score%3E50"
    "hngoogle": "http://hnapp.com/rss?q=google%20score%3E50"
    "hnamazon": "http://hnapp.com/rss?q=amazon%20score%3E50"
    "hnruby": "http://hnapp.com/rss?q=ruby%20score%3E50"
    "hnrails": "http://hnapp.com/rss?q=rails%20score%3E50"
    "hncoreos": "http://hnapp.com/rss?q=coreos%20score%3E50"
    "hn": "http://hnapp.com/rss?q=score%3E500"
    "changelog": "http://feeds.5by5.tv/changelog"
    "iteb": "http://feeds.feedburner.com/IT-eBooks"
    "stogo": "http://stackoverflow.com/feeds/tag?tagnames=go&sort=newest"
    "stodocker": "http://stackoverflow.com/feeds/tag?tagnames=docker&sort=newest"
    "stovag": "http://stackoverflow.com/feeds/tag?tagnames=vagrant&sort=newest"
    "stovim": "http://stackoverflow.com/feeds/tag?tagnames=vim&sort=newest"
    "stozsh": "http://stackoverflow.com/feeds/tag?tagnames=zsh&sort=newest"
    "stotmux": "http://stackoverflow.com/feeds/tag?tagnames=tmux&sort=newest"
    "storb": "http://stackoverflow.com/feeds/tag?tagnames=ruby&sort=newest"
    "storails": "http://stackoverflow.com/feeds/tag?tagnames=rails&sort=newest"
    "myp": "http://www.percona.com/blog/feed/"
    "postd": "http://postd.cc/feed/"
    "coreos": "https://coreos.com/atom.xml"
    "docker": "http://blog.docker.com/feed/"

  getFeedUrl: (key) ->
    if @rdfs[key]? then @rdfs[key] else null

  # feedsHandler = (err, feeds) -> ...function contents...
  loadFeed: (key, feedsHandler) ->
    rdf = @getFeedUrl(key)
    if rdf?
      parser rdf, feedsHandler

module.exports = new Rss
