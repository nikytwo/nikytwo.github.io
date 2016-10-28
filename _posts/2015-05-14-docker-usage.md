---
layout: post
title: "Docker 使用"
description: "Docker 使用"
category: wiki
tags: [Tool]
---

# Info

# Install

## Fedora/CentOS

针对 Fedora 和 CentOS 7 之前的版本。
如果安装了`docker`(此`docker`非本文所指的`docker`) ，需要先卸载:

```sh
sudo yum -y remove docker
```

安装`docker`：

```sh
# 本文所指的 docker 的安装包为 docker-io
sudo yum -y install docker-io
# CentOS7 安装包已改名为 docker
sudo yum -y install docker
```

启动`docker`进程（需要先启动才能进行相关操作）

```sh
# Fedora
sudo systemctl start docker
# CentOS
sudo service docker start
```

设置开机自启

```sh
# Fedora
sudo systemctl enable docker
# CentOS
sudo chkconfig docker on
```

用户授权

```sh
sudo usermod -a -G docker <username>
```


## Ubuntu

## Windows


# 常用命令

直接输入`docker`返回所有的可用命令。
或则使用`man`查找帮助。

## docker run

选项：

* -t
* -i
* -d : 让 Docker 容器在后台以守护态（Daemonized）形式运行。
* -p : 指定容器端口绑定到主机端口，可以使用多次配置多个端口。
* -P : 随机映射一个 49000~49900 的端口到内部容器开放的网络端口。
* --name : 命名容器
* --link : 将父/子容器连接起来。在容器之间打开一个安全连接隧道而不需要暴露任何端口。
* -v : 给容器内添加一个数据卷/挂载本地目录，可以使用多次配置多个数据卷。
* --volumes-from : 挂载其他容器上的数据卷，可以使用多次配置多个。

## docker images

## docker start

## doker stop

## docker ps

## docker port

## docker logs

## docker search

## docker commit

## docker tag

## docker top

## docker build

## docker attach

进入容器进行操作

## docker import/export

## docker save/load


# Dockerfile

# docker-registry(私有仓库)



***

# 参考

* [Docker中文指南](http://www.widuu.com/chinese_docker/index.html)
* [Docker —— 从入门到实践](http://dockerpool.com/static/books/docker_practice/index.html)
