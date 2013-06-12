#!/usr/bin/expect

set timeout 20

spawn "/redis/utils/install_server.sh"


expect "Please select the redis port for this instance:" { send "6379\r" }
expect "Please select the redis config file name" { send "/etc/redis/6379.conf\r" }
expect "Please select the redis log file name" { send "/var/log/redis_6379.log\r" }
expect "Please select the data directory for this instance" { send "/var/lib/redis/6379\r" }
expect "Please select the redis executable path" { send "/usr/local/bin/redis-server\r" }

interact
