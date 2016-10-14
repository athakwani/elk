# Copyright (C) Ashish Thakwani - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Ashish Thakwani <athakwani@gmail.com>, October 2016


setup()
{
  dupper exec -t elk get-cert
  dupper exec -t elk join 127.0.0.1
}

@test "join" {
  skip
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
