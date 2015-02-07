---
layout: post
title: "Linux 基础"
description: "Linux 基础"
category: Learning
tags: [Linux]
---
{% include JB/setup %}

# 1. 基本命令

## 1.1. 使用帮助

### whatis & info

`whatis` 查看命令的简要说明，要更详细的信息则使用 `info` 。

	whatis command

	info command

	// 正则匹配(适用于只记住部分命令的场合)
	whatis -w "loca*"

### man

查询命令的详细说明文档。

	man command

在man的帮助手册中，将帮助文档分为了9个类别，对于有的关键字可能存在多个类别中，我们就需要指定特定的类别来查看；（一般我们查询bash命令，归类在1类中）

man页面所属的分类标识(常用的是分类1和分类3)

> 1. 用户可以操作的命令或者是可执行文件
> 2. 系统核心可调用的函数与工具等
> 3. 一些常用的函数与数据库
> 4. 设备文件的说明
> 5. 设置文件或者某些文件的格式
> 6. 游戏
> 7. 惯例与协议等。例如Linux标准文件系统、网络协议、ASCⅡ，码等说明内容
> 8. 系统管理员可用的管理条令
> 9. 与内核有关的文件

	// 查询特定分类
	man 3 printf

根据命令中部分关键字来查询命令

	// 在说明文档标题及内容中查询关键字
	man -k keyword [keyword...]

	// 查找GNOME的config配置工具命令(分类1)
	man -k gnome config | grep 1


### which

查看程序的binary文件所在路径

	// 查找make程序安装路径
	which make

### whereis

查看程序的搜索路径

	whereis command

当系统中安装了同一软件的多个版本时，不确定使用的是哪个版本时，这个命令就能派上用场。


## 1.2. 目录和文件处理

### ls

列出目录下的内容.

	ls -l

### mkdir

建立目录.

	mkdir dirname

### cd

更换工作目录.

	cd dirname

### pwd

显示当前工作目录.

### cp

拷贝文件及目录

### mv

移动(重命名)文件

### touch

### rm

删除文件或目录

	rm -r dirname

### chgrp

### chown

修改文件属性

	chown [-R] username[:group] filename

`-R` 递归修改目录下的多有文件

### chmod

修改文件权限

其中:

> - u = owner
> - g = group
> - o = other
> - a = all


例子:

	chmod 700 .bashrc

	chmod a-x /etc/bashrc

	chmod ugo-x .bashrc

	chmod -x .bashrc



## 1.3. 文本处理

## 1.4. 系统管理

## 1.5. 文件系统

### du

查看目录或文件所占用磁盘空间大小.

### df

检查文件系统的磁盘空间占有情况.

### fdisk

### mkfs

### /etc/fstab

mount/umount

	mount /dev/dvd /mnt/dvd


# 2. 用户权限

### 2.1. 基本命令
/etc/passwd

/etc/shadow

/etc/group

- useradd

- usermod

- userdel

- passwd

- groupadd

- groupmod

- groupdel

- gpasswd


### sudo

/etc/sudoers

su


# 3. 帮助与查询

locate

find

grep

# 4. 管理监控

### who

显示谁登录了系统.

	who|w OPTION]

参数说明:

-a, --all : 显示全部

-b, --boot : 登录时间

-H, --heading : 打印列名

-u, --users : 列出登录的用户

### top

提供一个当前系统实时的动态视图.默认显示系统中CPU使用率最高的任务,并每5秒刷新一次.

	top

热键说明:

t : 显示摘要信息开关.

m : 显示内存信息开关.

A : 分类显示系统不同资源的使用大户.有助于快速识别系统中资源消耗多的任务.

f : 添加/删除所要显示的列.

o : 调整所要显示的列的顺序.

r : 调整一个正在运行的进程的 Nice 值.

k : 结束一个正在运行的进程.

z : 彩色/黑白显示开关.

### vmstat

使用vmstat命令可以得到关于进程、内存、内存分页、堵塞IO、traps及CPU活动的信息。

	vmstat 3
	// 显示内存使用详细信息
	vmstat -m
	// 显示内存活动/不活动的信息
	vmstat -a

### uptime

uptime命令过去只显示系统运行多久。现在，可以显示系统运行多久、当前有多少的用户登录、在过去的1，5，15分钟里平均负载时多少。

### ps

显示当前所有运行的程序.

	ps [options]

### free

显示内存使用情况.

	free [options]

参数说明:

-t, --total : 显示合计行.




# 5. 网络安全

## 5.1. 设置

所有网络配置完成后，都需要重启网络服务：

	service network restart 或/etc/init.d/network restart

### 网卡配置

网卡配置文件位于 /etc/sysconfig/network-scripts 目录下。
一块网卡对应一个网卡配置文件，配置文件命名规则：

	ifcfg-网卡类型+网卡的序列号

由于以太网卡类型是eth，网卡的序列号从0开始，所以第一块网卡的配置文件名称为ifcfg-eth0，第二块网卡为ifcfg-eth1，以此类推。

	DEVICE=eth0 #物理设备名
	TYPE=Ethernet #网卡的类型
	HWADDR=00:02:B3:0B:64:22 #该网卡的MAC地址
	IPADDR=192.168.1.10 #IP地址
	NETMASK=255.255.255.0 #掩码值
	NETWORK=192.168.1.0 #网络地址(可不要)
	BROADCAST=192.168.1.255 #广播地址（可不要）
	GATEWAY=192.168.1.1 #网关地址
	ONBOOT=yes # [yes|no]（启动时是否激活设备）
	USERCTL=no #[yes|no]（非root用户是否可以控制该设备）
	BOOTPROTO=static #[none|static|bootp|dhcp]（引导时不使用协议|静态分配|BOOTP协议|DHCP协议）

### DNS 配置

配置文件位于 /etc/resolv.conf

	nameserver 202.109.14.5 #主DNS
	nameserver 219.141.136.10 #次DNS
	search localdomain

### ifconfig 命令

	ifconfig eth0 192.168.0.10 将采用默认子网掩码
	ifconfig eth0 192.168.0.10 netmask 255.255.255.252 (手动定义子网掩码)
	ifconfig eth0 up(激活网卡）
	ifconfig eth0 down(关闭网卡）

### route 命令

	route add -net 192.168.1.0 netmask 255.255.255.0 eth0 (添加一条到192.168.1.0网络的路由条目)
	route del -net 192.168.1.0 netmask 255.255.255.0 （删除路由条目）
	route -C 查看缓冲表
	route -n 查看本地路由表
	traceroute 路由跟踪

### 其他配置文件

/etc/hosts(本地主机ip地址映射,可以有多个别名）。

/etc/services(端口号与标准服务之间的对应关系）。

/etc/sysconfig/network（设置主机名，网关，域名）。

	HOSTANME=zjw.com(主机名）（需要重启计算机才有效）
	GATEWAY=192.168.1.1（网关）



# 6. Other

### cat

### rpm

执行安装包。
分二进制包（Binary）以及源代码包（Source）两种。二进制包可以直接安装在计算机中，而源代码包将会由RPM自动编译、安装。源代码包经常以src.rpm作为后缀名。

参数说明:

-i,--install : 安装

-v,--verbose : 显示详细信息

-e,--erase : 卸载

-q : 查询

-a,--all : 查询/检验所有包

--nodeps : 忽略包依赖关系强行安装

范例:

	rpm -q samba
	rpm -qa | grep httpd
	rpm -ql httpd


### tree

### crontab

crond 是 linux 用来定期执行程序的命令。
当安装完成操作系统之后，默认便会启动此任务调度命令。
crond 命令每分锺会定期检查是否有要执行的工作，如果有要执行的工作便会自动执行该工作。

linux 任务调度的工作主要分为以下两类：

1. 系统执行的工作：系统周期性所要执行的工作，如备份系统数据、清理缓存;

2. 个人执行的工作：某个用户定期要做的工作，例如每隔10分钟检查邮件服务器是否有新信，这些工作可由每个用户自行设置.

### 相关目录文件

	/etc/cron.deny

该文件中所列的用户不允许使用 Crontab 命令.

	/etc/cron.allow

该文件中所列的用户允许使用 Crontab 命令.

	/var/spool/cron/

是所有用户的 crontab 文件.

### 命令格式

	crontab [ -u user ] file
	crontab [ -u user ] { -l | -r | -e } [-i] [-s]

参数含义:

-u user : 设置指定用户 user 的调度内容.不使用时,默认当前用户.

file : 将所有的 Crontab 文件的内容先存放在 file 中，再用 crontab file 的方式来设置调度。

-l : 显示用户的 Crontab 文件的内容.

-i : 删除用户的 Crontab 文件前给提示

-r : 从 Crontab 目录中删除用户的 Crontab 文件.

-e : 编辑用户的 Crontab 文件.默认为 vi,可以通过以下命令更改:

	EDITOR=vi
	export EDITOR

Crontab 文件内容格式如下:

	f1 f2 f3 f4 f5 program

其中 f1 是表示分钟(0-59)，f2 表示小时(0-23)，f3 表示一个月份中的第几日(0-31)，f4 表示月份(1-12)，f5 表示一个星期中的第几天(0-7,0,7都表示星期天)。program 表示要执行的程序。

当 f1 为 * 时表示每分钟都要执行 program，f2 为 * 时表示每小时都要执行程序，其余类推.

当 f1 为 a-b 时表示从第 a 分钟到第 b 分钟这段时间内要执行，f2 为 a-b 时表示从第 a 到第 b 小时都要执行，其余类推.

当 f1 为 */n 时表示每间隔 n 分钟执行一次，f2 为 */n 表示每间隔 n 小时执行一次，其余类推.

当 f1 为 a, b, c,... 时表示第 a, b, c,... 分钟要执行，f2 为 a, b, c,... 时表示第 a, b, c...个小时要执行，其余类推.

例子 :

每月每天上午7点的第 0 分钟执行一次 /bin/ls :

	0 7 * * * /bin/ls

在 12 月内, 每天的早上 6 点到 12 点中，每隔 3 分钟执行一次 /usr/bin/backup :

	0 6-12/3 * 12 * /usr/bin/backup

周一到周五每天下午 5:00 寄一封信给 alex@domain.name :

	0 17 * * 1-5 mail -s "hi" alex@domain.name  /dev/null 2>&1


### tar

	tar [必要参数] [选择参数] [文件]

参数说明:

-c : 建立新的压缩文件

-f : 指定文件

-t : 显示压缩文件的内容

-x : 从压缩文件中提取文件

-v : 显示操作过程

范例:

	# 将文件 foo 和 bar 压缩为 archive.tar
	tar -cf archive.tar foo bar

	# 显示 archive.tar 中的所有文件
	tar -tvf archive.tar

	# 解压 archive.tar
	tar -xf archive.tar

### createrepo

用于生成 yum 仓库所必须的一些信息，这些信息都存放在 repodata/ 目录底下

	createrepo /path/packages

***

# 参考

[Linux基础][http://linuxtools-rst.readthedocs.org/zh_CN/latest/base/index.html]

[鸟哥的Linux私房菜][http://vbird.dic.ksu.edu.tw/]

[Linux 命令行][http://billie66.github.io/TLCL/index.html]

[Linux就是这个范儿][]

