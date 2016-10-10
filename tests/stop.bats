# Copyright (C) Ashish Thakwani - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Ashish Thakwani <athakwani@gmail.com>, October 2016

setup()
{
  dupper exec -t elk start
}

@test "stop" {
  dupper exec -t elk stop

  process="$(dupper exec -t elk ps -eo args)"
  echo "$process"

  run dupper exec -t elk service elasticsearch status
  [ $status = 3 ]

  run dupper exec -t elk service nginx status
  [ $status = 3 ]

  [ ! $(echo "$process" | egrep logstash) ]
  [ ! $(echo "$process" | egrep kibana) ]
  [ ! $(echo "$process" | egrep topbeat) ]
}
