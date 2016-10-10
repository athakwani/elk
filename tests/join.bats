# Copyright (C) Ashish Thakwani - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Ashish Thakwani <athakwani@gmail.com>, October 2016

load common

setup()
{
  if [[ $(uname -s) == "Darwin" ]]; then
    _master="$(ifconfig en0 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')"
  elif [[ $(uname -s) == "Darwin" ]]; then
    _master="$(ifconfig eth0 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')"
  fi

  __host="$DOCKER_HOST"
  if [[ "${__host}" != "" ]]
  then
    _extract_ip _master ${__host}
  fi

  dupper exec -t elk join $_master
}

@test "join" {
  process="$(dupper exec -t elk ps -eo args)"
  echo "$process"
  echo "$process" | egrep topbeat   

  hosts="$(dupper exec -t elk cat /etc/hosts)"
  echo "$hosts"
  echo "$hosts" | egrep elk   
}

teardown()
{
  dupper exec -t elk unjoin
}
