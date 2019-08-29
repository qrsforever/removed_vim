# 将本机的public key copy到目标机user@ip中authorized_keys
#  or ssh-copy-id lidong@remote.ssh.com
# /etc/hosts: remote.ssh.com 可以公网 or 公司大网等
# ssh -NfR 8383:localhost:22 lidong@remote.ssh.com (内网执行)
# ssh -p 8383 localhost (公司大网,公网执行)
# ss -antp

# 键盘使能
# xinput list
# xinput set-prop 12 "Device Enabled" 0

# ssh -L 127.0.0.1:8140:127.0.0.1:8140 dc2-user@117.51.150.168

if [ -d /system/vagrant ];
then
    export VAGRANT_DOTFILE_PATH=/system/vagrant
fi

# wine 中文乱码
alias wine='env LANG=zh_CN.UTF-8  wine '
alias wine64='env LANG=zh_CN.UTF-8  wine64 '

export http_proxy=''
export https_proxy=''
export ftp_proxy=''
export socks_proxy=''
