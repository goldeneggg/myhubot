# functions using msg object
module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  H = require('../module/Http')(robot.logger)
  Str = require('../module/Str')
  Arr = require('../module/Arr')

  domainOtter = "http://otter.topsy.com"

  sendm = (m, msg, room) ->
    if room?
      Log.debug "room"
      robot.messageRoom room, m
    else
      Log.debug "send"
      msg.send m

  # stock
  stock: (code, msg, room = null) ->
    cheerio = require 'cheerio'

    url = "http://stocks.finance.yahoo.co.jp/stocks/detail/?code=#{code}"
    Log.debug "url = #{url}"

    callback = (body) ->
      $ = cheerio.load body

      prefixQuery = "div.forAddPortfolio > table.stocksTable > tr"
      name = $(prefixQuery + ' > th > h1').text()
      price = Str.trimBlanks($(prefixQuery + ' > td.stoksPrice').text())
      change = $(prefixQuery + ' > td.change > span.yjMSt').text()

      m = "#{name}: #{price} 円 (前日比 #{change})"
      sendm m, msg, room

    H.get url, callback

  # topsy
  tpsTrend: (offset, locale, msg, room = null, isFirst = false, isRandom = false) ->
    now = Math.floor(new Date())
    call = now - 6500000
    url = domainOtter + "/top.js?thresh=top100&offset=#{offset}&perpage=10&call_timestamp=#{call}&apikey=09C43A9B270A470B8EB8F2946A9369F3&_=#{now}" + locale
    Log.debug "url = #{url}"

    getTpsTrendMsg = (r) ->
      "(#{r.target.trackback_total}) [#{Str.formatUnixTs(r.firstpost_date)}] #{r.content}\n     tb: #{r.trackback_permalink} by @#{r.trackback_author_nick})\n"

    callback = (json) ->
      m = ""
      if isFirst
        Log.debug "first"
        m = getTpsTrendMsg(json.response.list[0])
      else if isRandom
        Log.debug "random"
        r = Arr.random(json.response.list)
        m = getTpsTrendMsg(r)
      else
        Log.debug "list"
        for r in json.response.list
          m += getTpsTrendMsg(r)

      sendm m, msg, room

    H.get url, callback, true

  tpsSearch: (win, offset, lang, q, msg, room = null, isFirst = false, isRandom = false) ->
    now = Math.floor(new Date())
    call = now - 6500000
    url = domainOtter + "/search.js?q=#{q}&window=#{win}&offset=#{offset}&perpage=10&call_timestamp=#{call}&apikey=09C43A9B270A470B8EB8F2946A9369F3&_=#{now}" + lang
    Log.debug "url = #{url}"

    getTpsSearchMsg = (r) ->
      "(#{r.trackback_total}) [#{Str.formatUnixTs(r.firstpost_date)}] #{r.content}\n     tb: #{r.trackback_permalink} by @#{r.trackback_author_nick})\n"

    callback = (json) ->
      m = ""
      if isFirst
        Log.debug "first"
        m = getTpsSearchMsg(json.response.list[0])
      else if isRandom
        Log.debug "random"
        r = Arr.random(json.response.list)
        m = getTpsSearchMsg(r)
      else
        Log.debug "list"
        for r in json.response.list
          m += getTpsSearchMsg(r)

      sendm m, msg, room

    H.get url, callback, true

  parseRss: (key, msg, room = null, isFirst = false, isRandom = false) ->
    getRssMsg = (f) ->
      "[#{Str.formatDate(f.pubDate)}] #{f.title} #{f.link}\n"

    handler = (err, feeds)=>
      if err
        msg.send "rss parse error #{err}"

      m = ""
      if isFirst
        Log.debug "first"
        m = getRssMsg(feeds[0])
      else if isRandom
        Log.debug "random"
        f = Arr.random(feeds)
        m = getRssMsg(f)
      else
        Log.debug "list"
        for f in feeds
          m += getRssMsg(f)

      sendm m, msg, room

    Rss = require('../module/Rss')
    Rss.loadFeed(key, handler)

  # github
  ghTrend: (since, l, msg, room = null) ->
    cheerio = require 'cheerio'

    url = "https://github.com/trending?since=#{since}" + l
    Log.debug "url = #{url}"

    callback = (body) ->
      $ = cheerio.load body
      m = ""
      $('ol.repo-list > li').each (i, e) ->
        $$ = cheerio.load e
        repo = "https://github.com" + $$('h3.repo-list-name > a').attr('href')
        desc = Str.trimBlanks $$('p.repo-list-description').text()
        meta = Str.trimBlanks $$('p.repo-list-meta').text()
        star = Str.trim meta.replace(/stars.+/g, '').split('•')[1]
        repoInfo = "#{repo} - #{desc} (#{star} stars)"
        m = m + "\n" + repoInfo

      sendm m, msg, room

    H.get url, callback

  ghDev: (since, msg, room = null) ->
    cheerio = require 'cheerio'

    url = "https://github.com/trending/developers?since=#{since}"
    Log.debug "url = #{url}"

    callback = (body) ->
      m = ""

      $ = cheerio.load body
      $('ol.user-leaderboard-list > li').map (i, e) ->
        $$ = cheerio.load e
        user = $$('div.leaderboard-list-content > h2.user-leaderboard-list-name > a')

        # user info
        url = "https://github.com" + user.attr('href')
        userText = Str.trimBlanks(user.text()).replace(/\s+/, '')

        # what has the user been contributing?
        repo = $$('div.leaderboard-list-content > a.repo-snipit')
        repoUrl = "https://github.com" + repo.attr('href')
        repoText = Str.trimBlanks(repo.text()).replace(/(\s){2,}/, '#').split('#')[1]
        devInfo = "#{url} - #{userText} [#{repoUrl} : #{repoText}]"
        m = m + "\n" + devInfo

      sendm m, msg, room

    H.get url, callback

  # exchange
  exchange: (from, to, msg, room = null) ->
    url = "http://rate-exchange.appspot.com/currency?from=#{from}&to=#{to}"
    Log.debug "url = #{url}"

    callback = (json) ->
      sendm "#{json.from} => #{json.to} rate is #{json.rate}", msg, room

    H.get url, callback, true

  # bitcoin
  bcTick: (currency, msg, room = null) ->
    callback = (json) ->
      sendm "Now #{json.last} #{currency}. 24h avg: #{json['24h_avg']}, volume: #{json.volume_btc}(#{json.volume_percent}%)", msg, room
    H.bcTick currency, callback
