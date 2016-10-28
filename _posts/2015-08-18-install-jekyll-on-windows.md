---
layout: post
title: "在 Windows 中安装 Jekyll"
description: "在 Windows 中安装 Jekyll"
category: wiki
tags: [Markdown, Blog]
---

# Install Ruby

在 [RubyInstallers](http://rubyinstaller.org/downloads/) 下载并安装。

安装时，勾选 “Add Ruby executables to your PATH”，这样执行程序会被自动添加至 PATH 而避免不必要的头疼。

运行以下命令检测安装是否成功：

```Bash
ruby -v
```

# Install DevKit

DevKit 是一个在 Windows 上帮助简化安装及使用 `Ruby C/C++` 扩展如 `RDiscount` 和 `RedCloth` 的工具箱。详细的安装指南可以在程序的 [wiki](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit#installation-instructions) 页面阅读。

再次前往 [RubyInstallers](http://rubyinstaller.org/downloads/) 下载与ruby相对应的版本。

运行安装包并解压至某个文件夹(我的是D:/Devkit)，然后创建 `config.yml` 文件：

```Bash
cd D:\DevKit
ruby dk.rb init
```

然后会在解压的目录下创建一个 `config.yml` 文件，使用编辑器打开，并在末尾添加一行 `-D:/Ruby200-x64` (即ruby的安装路径)。

再输入如下命令进行安装：

```Bash
ruby dk.rb review
ruby dk.rb install
```

# Install Jekyll

运行以下命令：

```Bash
gem install jekyll
```

若出错无法链接，就试试 ruby 的国内镜像吧。

# Install pygments

**新版本的 Jekyll 已经包含了 pygments 的 ruby 版，但仍需要再安装 Python （依赖 Python）。**

## Install Python

在 [Python 官网](http://www.python.org/download/)下载并安装。
**Python 2 可能会更合适，因为 Python 3 可能不会正常工作。**

检验 Python 安装是否成功

```Bash
python -version
```

## Install pip

**python 2.7.9 和3.4以后的版本已经内置累pip程序，不需另外安装。**

**若已经使用 pygments 的 ruby 版，不需要这一步了。**

下载 [get-pip.py](https://bootstrap.pypa.io/get-pip.py) 脚本。
然后运行该脚本，如下：

```Bash
python get-pip.py
```

## Install pygments

**若已经使用 pygments 的 ruby 版，不需要这一步了。**

运行以下命令进行安装

```Bash
pip pygments
```


# 参考

- [在 Windows 上安装 Jekyll](http://cn.yizeng.me/2013/05/10/setup-jekyll-on-windows/)
- [Windows上安装Jekyll](http://blog.csdn.net/itmyhome1990/article/details/41982625)

