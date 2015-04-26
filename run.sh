#!/bin/sh

function config_irc() {
  [ ${HUBOT_IRC_SERVER} ] || (echo "Not set HUBOT_IRC_SERVER env value"; return 1)

  export HUBOT_IRC_ROOMS=${HUBOT_CHANNELS}
  export HUBOT_IRC_NICK=${HUBOT_NICKNAME}
  export HUBOT_IRC_UNFLOOD=true
  return 0
}

function config_slack() {
  [ ${HUBOT_SLACK_TOKEN} ] || (echo "Not set HUBOT_SLACK_TOKEN env value"; return 1)
  [ ${HUBOT_SLACK_TEAM} ] || (echo "Not set HUBOT_SLACK_TEAM env value"; return 1)

  export HUBOT_SLACK_CHANNELS=${HUBOT_CHANNELS}
  export HUBOT_SLACK_BOTNAME=${HUBOT_NICKNAME}
  export HUBOT_SLACK_CHANNELMODE=whitelist
  return 0
}

[ ${HUBOT_CHANNELS} ] || (echo "Not set HUBOT_CHANNELS env value"; exit 1)
[ ${HUBOT_NICKNAME} ] || (echo "Not set HUBOT_NICKNAME env value"; exit 1)
[ ${HUBOT_GITHUB_TOKEN} ] || (echo "Not set HUBOT_GITHUB_TOKEN env value"; exit 1)

declare -r HUBOT_ADAPTER=${1:-""}
case ${HUBOT_ADAPTER} in
  "irc")
    config_irc
    ;;
  "slack")
    config_slack
    ;;
  *)
    echo "1st argument need to be Hubot adapter (irc, slack, ...)"
    exit 1
    ;;
esac
(( $? )) && exit 1

export PORT=9980

declare HUBOT_PID
echo "Start Hubot..."
while true
do
  ps | awk '{print $1}' | grep ${HUBOT_PID} > /dev/null

  if (( $? == 0 ))
  then
    echo "Hubot is running."
  else
    ./bin/hubot -a ${HUBOT_ADAPTER} --name ${HUBOT_IRC_NICK} 2>&1 &
    HUBOT_PID=$!

    wait ${HUBOT_PID}
    RET=$?
    echo "Hubot is end. PID: ${HUBOT_PID}"

    (( ${RET} == 0 )) && exit ${RET}
    (( ${RET} == 1 )) && (echo "Hubot returned error. return code: ${RET}"; exit ${RET})

    echo "Hubot is dead by return code: ${RET}, try restart"
  fi
done
