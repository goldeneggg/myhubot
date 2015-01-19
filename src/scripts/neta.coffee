# Description:
#   Example script.
#

enterReplies = [
  "Welcome!",
]

leaveReplies = [
  "Bye!",
]

sushis = [
  "はまち",
  "中トロ",
  "えんがわ",
  "えび",
  "いか",
  "たこ",
  "いくら",
  "うに",
  "車エビ",
  "ほたて"
]

module.exports = (robot) ->
  # enter
  robot.enter (msg) ->
    msg.send msg.random enterReplies

  # leave
  robot.leave (msg) ->
    msg.send msg.random leaveReplies

  # respond examples
  robot.respond /sushi kure/i, (msg) ->
    msg.send msg.random sushis
