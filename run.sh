#!/bin/sh

function config_irc() {
  if [ ! ${HUBOT_IRC_SERVER} ]
  then
    echo "Not set HUBOT_IRC_SERVER env value"
    return 1
  fi

  export HUBOT_IRC_ROOMS=${HUBOT_CHANNELS}
  export HUBOT_IRC_NICK=${HUBOT_NICKNAME}
  export HUBOT_IRC_UNFLOOD=true
  return 0
}

function config_slack() {
  if [ ! ${HUBOT_SLACK_TOKEN} ]
  then
    echo "Not set HUBOT_SLACK_TOKEN env value"
    return 1
  elif [ ! ${HUBOT_SLACK_TEAM} ]
  then
    echo "Not set HUBOT_SLACK_TEAM env value"
    return 1
  fi

  export HUBOT_SLACK_CHANNELS=${HUBOT_CHANNELS}
  export HUBOT_SLACK_BOTNAME=${HUBOT_NICKNAME}
  export HUBOT_SLACK_CHANNELMODE=whitelist
  return 0
}

if [ ! ${HUBOT_CHANNELS} ]
then
  echo "Not set HUBOT_CHANNELS env value"
  exit 1
fi

if [ ! ${HUBOT_NICKNAME} ]
then
  echo "Not set HUBOT_NICKNAME env value"
  exit 1
fi

if [ ! ${HUBOT_GITHUB_TOKEN} ]
then
  echo "Not set HUBOT_GITHUB_TOKEN env value"
  exit 1
fi

if [ $# -ne 1 ]
then
  echo "1st argument need to be Hubot adapter (irc, slack, ...)"
  exit 1
fi

HUBOT_ADAPTER=$1
if [ ${HUBOT_ADAPTER} = "irc" ]
then
  config_irc
elif [ ${HUBOT_ADAPTER} = "slack" ]
then
  config_slack
else
  echo "${HUBOT_ADAPTER} is invalid"
  exit 1
fi

if [ $? -ne 0 ]
then
  exit 1
fi

# port for http listenter
export PORT=9980

HUBOT_PID="NOTHING"
echo "Start Hubot..."
while true
do
  ps | awk '{print $1}' | grep ${HUBOT_PID} > /dev/null

  if [ $? -eq 0 ]
  then
    echo "Hubot is running."
  else
    ./bin/hubot -a ${HUBOT_ADAPTER} --name ${HUBOT_IRC_NICK} 2>&1 &
    HUBOT_PID=$!

    wait ${HUBOT_PID}
    RET=$?
    echo "Hubot is end. PID: ${HUBOT_PID}"

    if [ ${RET} -eq 0 ]
    then
      exit ${RET}
    elif [ ${RET} -eq 1 ]
    then
      echo "Hubot returned error. return code: ${RET}"
      exit ${RET}
    else
      echo "Hubot is dead by return code: ${RET}, try restart"
    fi
  fi
done
