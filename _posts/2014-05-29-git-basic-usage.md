---
layout: post
title: "Git 基本操作"
description: "Git 基本操作"
category: Tool
tags: [Git]
---
{% include JB/setup %}


## 配置

用户信息

	git config --global user.name "xxx xxx"
	git config --global user.email "xxxx@example.com"

这两条配置很重要,每次 Git 提交时都会引用这两条信息,说明是谁提交了更新,所以会随更新内容一起被永久纳入历史记录


## 创建新库

在文件夹中执行:

	git init

则,git 将在该文件夹中创建一个空的仓库。


## 克隆仓库

执行如下命令以创建一个本地仓库的克隆版本:

	git clone /path/to/repository

如果是远端服务器上的仓库,可以用以下命令(视服务器协议而定):

	git clone username@host:/path/to/repository

或

	git clone https://sitename/path/repository.git
	git clone git://sitename/path/repository.git

如果你熟悉其他的 VCS 比如 Subversion，你可能已经注意到这里使用的是 clone 而不是 checkout。
这是个非常重要的差别，Git 获取的是项目历史的所有数据（每一个文件的每一个版本），克隆之后，服务器上有的数据，本地也都有。
实际上，即便服务器的磁盘发生故障，用任何一个克隆出来的客户端都可以重建服务器上的仓库，回到当初克隆时的状态。

## 工作目录/暂存区/本地库

对于任何一个文件,在 Git 内都只有三种状态:已修改,已暂存和已提交。

三种状态分别对应三个区域:工作目录（working dir）,暂存区（staging area）,本地仓库（git dir）

![Local Operations][gitLocalOperations]


## 工作流程

Git 基本工作流程如下:

1. 运行命令`git checkout branchname`,将从本地仓库中检出 `branchname` 分支的文件到工作目录,然后就可进行修改了.

2. 运行命令`git add filename ` 或 `git add *`,将新增的和修改的文件保存到暂存区(若要把删除的也记录入 git ,可运行 `git add -A`).

3. 运行命令`git commit -m "提交信息"`,将暂存区的文件提交至本地仓库,**但还没到远端仓库**.


## 推送

提交本地仓库后,执行如下命令将本地仓库内容提交到远端程仓库:

	git push origin master

可以把 `master` 换成你想推送的任何分支.

可以使用以下命令为本地仓库添加远端仓库:

	git remote add origin 远端仓库地址

如此就能将本地仓库推送到服务器上去了.

如果你使用了 `git clone 远端仓库地址` 命令克隆生成本地仓库的,git 自动为你增加一个名为 `origin` 的远端仓库.


## 分支

分支是用来从开发主线上分离开来的,然后在不影响主线的同时继续工作.
**Git 鼓励在工作流程中频繁使用分支与合并**，哪怕一天之内进行许多次都没有关系。
在你创建仓库的时候，master 是“默认的”分支。
在其他分支上进行开发，完成后再将它们合并到主分支上。

![git branch working][gitBranchWorking03]

创建一个叫做"iss91v2"的分支,并切换过去:

	git checkout -b iss91v2

切换回主分支:

	git checkout master

删除"iss91v2"分支:

	git branch -d iss91v2

除非你将分支推送到远端仓库，不然该分支就是 不为他人所见的:

	git push origin iss91v2


## 更新与合并

要更新你的本地仓库至最新改动，执行：

	git pull

该操作会合并你的工作目录和远端的改动(与 `git fetch` 有别)。

要合并其他分支到你的当前分支（例如 master），执行：

	git merge branchname

在这两种情况下，git 都会尝试去自动合并改动。
遗憾的是，这可能并非每次都成功，并可能出现冲突。
这时候就需要你修改这些文件来手动合并这些冲突。
改完之后，你需要执行如下命令以将它们标记为合并成功：

	git add filename

在合并改动之前，你可以使用如下命令预览差异：

	git diff source_branch target_branch

使用图形化的比较工具可得到更好的效果。


## 打标签

为软件发布创建标签是推荐的（比如 v1.0 等等）。
执行如下命令创建一个叫做 v1.0 的标签：

	git tag v1.0 1b2e1d63ff

1b2e1d63ff 是你想要标记的提交 ID 的前 10 位字符。
可以使用下列命令获取提交 ID：

	git log

你也可以使用提交 ID 前几位，只要它的指向具有唯一性。


## 替换本地改动

假如你操作失误（当然，这最好永远不要发生），你可以使用如下命令替换掉本地改动：
	git checkout -- filename

此命令会使用 HEAD 中的最新内容替换掉你的工作目录中的文件。
但已添加到暂存区的改动以及新文件不受此影响。

假如你想丢弃你在本地的所有改动与提交，可以到服务器上获取最新的版本历史，并将你本地主分支指向它：

	git fetch origin
	git reset --hard origin/master


***

# 参考:

* [Git 社区参考书](http://book.git-scm.com/)

* [git - 简明指南](http://rogerdudler.github.io/git-guide/index.zh.html)




***

[gitLocalOperations]: {{ site.url }}/assets/images/git-local-operations.png
[gitBranchWorking03]: {{ site.url }}/assets/images/git-branch-working03.png


