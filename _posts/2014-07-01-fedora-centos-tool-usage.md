---
layout: post
title: "Fedora/CentOS 相关工具使用"
description: "Fedora/CentOS 相关工具使用"
category: Tool
tags: [Linux]
---
{% include JB/setup %}


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






***


