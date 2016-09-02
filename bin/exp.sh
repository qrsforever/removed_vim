#!/usr/bin/expect 
set timeout 3
 
if { [llength $argv] < 1} { 
    puts "Usage:" 
    puts "$argv0 " 
    exit 1 
}
 
set port [lindex $argv 0]

set passwd "123456"

if { $port == "128" } {
    spawn ssh -fN -L 54128:10.142.128.117:22 lidong8@jump3.oss.letv.cn -p 50022
} else {
    spawn ssh -fN -L 54130:10.142.130.7:22 lidong8@jump3.oss.letv.cn -p 50022
}
 
expect { 
    "yes/no" { send "yes\r"; exp_continue }
    "password:" { send "$passwd\r"; exp_continue } 
}
