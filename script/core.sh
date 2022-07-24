#!/bin/bash

#该项目会在把程序运行错误的core文件生产在/tmp/core
#且重启有效。
#执行完之后要执行一下  ulimit -c 查看一下是否成功
#不成功的话执行一下ulimit -c unlimited

#设置开机自动启动
sed -i '/ulimit -c unlimited/d' /etc/profile
echo 'ulimit -c unlimited' >> /etc/profile

#设置生成core文件的路径
if [ ! -d /tmp/core ];then
	mkdir /tmp/core
fi

sed -i '/kernel.core_pattern/d' /etc/sysctl.conf
echo 'kernel.core_pattern = /tmp/core/core-%e-%p-%t' >> /etc/sysctl.conf


source /etc/profile
sysctl -p

ulimit -c unlimited

