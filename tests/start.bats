# Copyright (C) Ashish Thakwani - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Ashish Thakwani <athakwani@gmail.com>, October 2016

setup()
{
  dupper exec -t elk start --detached
}

@test "start" {
  process="$(dupper exec -t elk ps -eo args)"
  echo "$process"
  dupper exec -t elk service elasticsearch status
  dupper exec -t elk service nginx status
  echo "$process" | egrep logstash
  echo "$process" | egrep kibana 
  echo "$process" | egrep topbeat   

  netstats="$(dupper exec -t elk netstat -ntl)"
  echo "$netstats" | egrep "tcp        0      0 127.0.0.1:5601          0.0.0.0:\*               LISTEN"
  echo "$netstats" | egrep "tcp        0      0 0.0.0.0:80              0.0.0.0:\*               LISTEN" 
  echo "$netstats" | egrep "tcp6       0      0 ::1:9200                :::\*                    LISTEN"
  echo "$netstats" | egrep "tcp6       0      0 127.0.0.1:9200          :::\*                    LISTEN"
  echo "$netstats" | egrep "tcp6       0      0 :::5044                 :::\*                    LISTEN"
  echo "$netstats" | egrep "tcp6       0      0 ::1:9300                :::\*                    LISTEN"
  echo "$netstats" | egrep "tcp6       0      0 127.0.0.1:9300          :::\*                    LISTEN"

  hosts="$(dupper exec -t elk cat /etc/hosts)"
  echo "$hosts"
  echo "$hosts" | egrep elk   
  
  ports_config=$(docker inspect  --format "{{ .HostConfig.PortBindings }}" elk | tr -d '\r')
  [ "$ports_config" = "map[5044/tcp:[{ 5044}] 80/tcp:[{ 80}]]" ]

}

teardown()
{
  dupper exec -t elk stop
}
