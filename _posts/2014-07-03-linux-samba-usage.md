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

首先要安装 samba-client

	yum install samba-client

再进行查询

	smbclient -L //127.0.0.1 -U user%password

挂载

首先要下载安装 `cifs-utils`

	yum install cifs-utils

再进行挂载

	mount -t cifs //192.168.1.1/share /mnt/share -o username=user,password=passwd,uid=500,gid=500,dir_mode=0777,file_mode=0777

其中

username,password 为登录用户与密码;

uid,gid 为挂载目录所属用户和组;

dir_mode,file_mode 指定挂载目录的权限.

开机自动挂载

	vi /etc/fstab

然后在最末行添加

	//ipaddress/share    /mnt/share  cifs    default,username=user,password=passwd    0 0

或者

	vi /etc/rc.local

然后添加`mount`命令：

	mount -t cifs //192.168.1.1/share /mnt/share -o username=user,password=passwd,uid=500,gid=500,dir_mode=0777,file_mode=0777

当通过mount.cifs命令对windows下的文件进行映射时，若文件太大，便会产生错误：`mount error(12): Cannot allocate memory`。

解决方法是：

修改注册表 HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters\IRPStackSize项的值大于等于15，若IRPStackSize项不存在，就新建一个DWORD值，点击弹出窗口的的进制为十进制，值写个18就ok了，还要重启一下。





***

