---
layout: post
title: "Fedora/CentOS 相关工具使用"
description: "Fedora/CentOS 相关工具使用"
category: Tool
tags: [Linux]
---


## yum

#### 常用操作

	yum search someword

	yum list|grouplist packagename [installed]

	yum install packagename

	yum erase|remove packagename

#### downloadonly 插件

* 安装

该插件用于下载 `yum` 里的软件安装。
最新的版本已内置该插件，无需安装。

	# 较旧的版本
	yum install yum-downloadonly

	# 较新的版本
	yum install yum-plugin-doenloadonly

* 配置

见 `/etc/yum/pluginconf.d/downloadonly.conf` 文件。

* 使用

	yum install --downloadonly --downloaddir=./path packagename


## 查询相关 locate/which/whereis/find/grep

* 安装

	yum install mlocate which grep


## 防火墙相关 lokkit/iptables

例子：

	sudo lokkit -s http -s ssh
	sudo lokkit -p 2443:tcp


## genisoimage / mkisofs

	genisoimage [参数] [-o isofile] pathspec [pathspec ...]

参数说明:

-o : 指定映像文件名称

-r : 使用Rock Ridge Extensions(支持文件名字母大小写、符号字符以及长文件名)，并开放全部文件的读取权限。

-J : 使用Joliet格式(可显示 64个字符 ，并可使用中文，但是不能被MAC机所读取)的目录与文件名称。


## [git-cvs](https://www.kernel.org/pub/software/scm/git/docs/git-cvsimport.html)

cvs 迁移至 git 工具.

安装

	yum install git-cvs

设置 CVSROOT 并登录

	export CVSROOT=pserver:username@serverip:/home/cvs
	cvs login

导出

	git cvsimport -v project_name -C project_name

参数说明

-v : 显示详细信息.

-C : 到处目录名称,没有则新建.

-d : CVSROOT

**乱码问题**

	vi /etc/sysconfig/i18n

将编码转成 cvs 服务器的编码,然后同时将终端编码(putty等)的编码也转换成相同编码.


## ffmpeg/mencoder

音视频转换工具。

安装：

	yum install ffmpeg libvpx
	yum install mencoder

使用：

	ffmpeg -i /path/video.vob /path/video.avi


***


