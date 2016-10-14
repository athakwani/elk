# Copyright (C) Ashish Thakwani - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Ashish Thakwani <athakwani@gmail.com>, October 2016

setup()
{
  dupper exec -t elk start --detached
}

@test "unjoin" {
  dupper exec -t elk unjoin

  process="$(dupper exec -t elk ps -eo args)"
  echo "$process"

  [ ! $(echo "$process" | egrep topbeat) ]
}

teardown()
{
  dupper exec -t elk stop
}
