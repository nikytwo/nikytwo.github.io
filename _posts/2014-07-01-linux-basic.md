---
layout: post
title: "Linux 基础"
description: "Linux 基础"
category: Learning
tags: [Linux]
---
{% include JB/setup %}

# 目录文件

ls

mkdir

mv

cp

mount/umount

	mount /dev/dvd /mnt/dvd


# 用户权限

chmod

# 帮助与查询

man

locate

which

whereis

find

grep


# 网络安全

## 设置

# Other

cat

## rpm

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


tree

## crontab

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


## tar

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

## createrepo

用于生成 yum 仓库所必须的一些信息，这些信息都存放在 repodata/ 目录底下

	createrepo /path/packages

