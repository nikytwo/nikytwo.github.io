---
layout: post
title: "Linux 共享工具 Samba 使用"
description: "Linux 共享工具 Samba 使用"
category: Learning
tags: [Linux]
---
{% include JB/setup %}


安装

	yum install samba

开启防火墙

	lokkit -s samba

若是 Fedora ubuntu 等请使用 FirewallD 软件进行设置.

添加共享目录

	mkdir /share

修改目录的 SELinux 的 Security Context Type

	chcon -t samba_share_t /share

编辑配置文件

	vi /etc/samba/smb.conf

检查配置文件是否正确

	testparm

添加访问用户,该用户必须在系统中存在.

	pdbedit -a -u user

修改用户密码

	smbpasswd user

重启服务

	/etc/init.d/smb restart
	或 service smb restart
	/etc/init.d/nmb restart
	或 service nmb restart

设置开机自启动

	chkconfig smb on
	chkconfig nmb on


查询共享内容

	smbclient -L //127.0.0.1 -U user%password

挂载

首先要下载安装 `cifs-utils`

	yum install cifs-utils

再进行挂载

	mount -t cifs //192.168.1.1/share /mnt/share -o username=user




***

