---
layout: post
title: "Yeoman 使用"
description: "Yeoman 使用"
category: tool
tags: [javascript]
---


# 1. Info

[Yeoman](http://yeoman.io/) 是一种构建 javascript 项目的脚手架。

是 Google 的团队和外部贡献者团队合作开发的，他的目标是通过Grunt（一个用于开发任务自动化的命令行工具）和Bower（一个HTML、CSS、Javascript和图片等前端资源的包管理器）的包装为开发者创建一个易用的工作流。

Yeoman 主要有三部分组成：

* yo（脚手架工具）;
* grunt（构建工具）;
* bower（包管理器）。

这三个工具是分别独立开发的，但是需要配合使用，来实现我们高效的工作流模式。


# 2. Require

* Node.js v0.10.x+
* npm v1.4.3+
* git

# 3. Install Yeoman 工具集

	sudo npm install --global yo bower grunt-cli

# 4. generator

一个 generator 能帮助构建项目目录，下载项目依赖等工作。

## 4.1. install a generator

	sudo npm install -g generator-***

# 5. 通过 generator scaffold 应用

## 5.1. 创建一个项目文件夹

	mkdir mytodo && cd mytodo

## 5.2. 通过 generator 建立应用的框架

	yo angular

## 5.3. 配置

运行上面的命令后，根据提示进行应用的配置。完成后应用的大体框架便出来了。

# 6. Preview 应用 in the browser

Yeoman 已经包含了我们构建本地服务的所需。

## 6.1. 运行服务

	grunt serve

服务的默认端口为：9000。
停止服务，请按 Ctrl+C。
但在我们开发应用的时候，我们不需要停止服务，然后在重启它以查看效果，grunt 会自动监控项目下文件的变化，并实时更新服务。

# 7. Start writing App

# 8. 使用 bower 安装 packages

## 8.1. 查询当前有哪些 packages

	bower list

## 8.2. 搜索 packages

	bower search package-name

## 8.3. 安装 packages

	bower install --save package-name

* `--save` 选项将新安装的依赖自动更新至 bower.json 文件。

安装成功后，在 bower_components 目录下将增加相应的 packages 文件夹。

bower 同时会将添加新依赖至相应 HTML 文件中。


# 9. 测试

## 9.0. 安装 Karma

	npm install grunt-karma --save-dev

## 9.1. 运行单元测试

	grunt test

## 9.2. 更新 Karma 配置文件

打开 karma.conf.ja 添加应用的相关依赖。

# 10. 构建与发布

	grunt

	grunt serve:dist


