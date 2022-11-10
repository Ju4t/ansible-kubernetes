#!/bin/bash

#批量复制公匙到服务器
#记得先执行这条命令生成公匙：ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
user=root
password=CHENGME
hosts="
192.168.8.61
192.168.8.62
192.168.8.63
192.168.8.71
192.168.8.72
192.168.8.73
"

for host in $hosts
  do
    echo ============= $host =============
    expect <<-EOF
    set timeout 3
    spawn ssh-copy-id -f "$user@$host"
    expect {
      "yes/no" { send "yes\n"; exp_continue }
      "password:" { send "$password\n"; }
    }
    expect off;
EOF
done