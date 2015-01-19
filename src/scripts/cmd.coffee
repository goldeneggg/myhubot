# Description:
#   Example script for execting os cmd
#
# Dependencies:
#
# Configuration:
#   None
#
# Commands:
#   hubot c cal - Show output by "cal" command
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   goldeneggg

cp = require('child_process')

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)

  # topsy trend
  robot.respond /c cal/i, (msg) ->
    Log.showMatch msg

    cp.exec 'cal', (error, stdout, stderr) ->
      msg.send stdout
