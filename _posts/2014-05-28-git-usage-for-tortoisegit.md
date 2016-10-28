---
layout: post
title: "TortoiseGit 下 Git 基本操作"
description: "TortoiseGit 下 Git 基本操作"
category: wiki
tags: [Git]
---


## TortoiseGit 常用菜单

当你在任一目录点击右键时, TortoiseGit 会出现两种菜单:

* 你所点击的目录不是一个 git 的工作目录,则出现如下图1所示菜单.

![git 菜单1][gitMenu1]

图1

* 你所点击的目录是一个 git 工作目录时,则出现如下图2所示的菜单.

![git 菜单2][gitMenu2]

图2


## 配置

#### 配置用户

点击图1或图2中的 settings ,打开如下窗口.

![git 用户配置][gitConfigUser]

按照上图进行设置,然后"确定"即可.

#### 配置ssh key

TortoiseGit 使用扩展名为ppk的密钥，而不是ssh-keygen生成的rsa密钥。
也就是说使用ssh-keygen -C "username@email.com" -t rsa产生的密钥在TortoiseGit中不能用。
而基于 github 或 gitlab 的开发必须要用到rsa密钥，因此需要用到TortoiseGit的putty key generator工具来生成密钥，配置步骤如下：

1.运行TortoiseGit开始菜单中的puttygen程序，如下图示

![putty key 生成器][gitPuttygen]

2.点击“Generate”按钮，鼠标在上图的空白地方来回移动直到进度条完毕，就会自动生一个随机的key，如下图示

![putty key 生成][gitPuttygen2]

如有需要，可以为密钥设置对应的访问密码，就是修改上图中“Key passphrase”和“Confirm passphrase”的值。

3.将上图中多行文本框的内容全选、复制，并粘贴到github/gitlab账户的 SSH public key中。

4.点击上图中的“Save private key”按钮,将生成的key保存为适用于TortoiseGit的私钥（扩展名为.ppk）。

5.运行TortoiseGit开始菜单中的Pageant程序，程序启动后将自动停靠在任务栏中，双击该图标![putty key ico][gitKeylistIco]，弹出key管理列表，如下图示

![putty key 管理器][gitSSHKeylist]

6.点击上图中的“Add Key”按钮，将第4步保存的ppk私钥添加进来，关闭对话框即可

7.经上述配置后，你就可以使用TortoiseGit进行push、pull操作了。

若没有设置 ssh key,则每次推送代码时,都会提示输入 github/gitlab 的用户和密码。

## 创建新库

在空文件夹下点击右键,然后选择图1中的 "Git Create repository here..."即可.

## 克隆仓库

在空文件夹下点击右键,然后选择图1中的 "Git Clone ..."将打开如下图的窗口.

![git 克隆仓库][gitClone]

其中 URL 为仓库源地址, Directory 为新建仓库的所在路径.

## 工作流程

基本工作流程如下:

#### 1. 检出与切换

从本地仓库中检出或切换至 `develop` 分支的文件到工作目录进行修改:在图2中点击"Switch/Checkout...",打开如下图的窗口.

![git 切换分支][gitBranch]

然后选择你想要切换的分支/标签,点击OK.

该界面亦可创建分支.

**git 鼓励在工作流程中频繁使用分支与合并.即当要进行代码修改时,应该建立一个分支,当代码完成后再将该分支合并回主分支.**

#### 2. 提交
将暂存区的文件提交至本地仓库(在"Tortoisegit"中运行"Commit"操作会同时执行"git add"操作):在图2中点击"",打开如下窗口.

![git 提交][gitCommit2]

在"Message"处输入提交相关信息的描述,然后点击OK.

**git 建议:在编写提交信息时,第一行应为标题,概括提交内容,然后空一行,再在第3行处进行详细描述.**

**注意:该操作并不提交到远端仓库**.要提交到远端仓库,请看下面的"推送".


## 推送

将本地的变更提交到远端仓库:在图2中点击"Push",打开如下图窗口.

![git 推送选择][gitPushSelect]

其中:

Local 为本地的分支名称.

Remote 为远端仓库的分支名称.

选择"Push all branches"后会将本地所有分支推送到远端仓库.

Remote 为远端仓库,可通过"Manage"按钮进行设置,点击该按钮(或者在图1/图2中选择 "setting")会出现如下图的窗口.

![git 远端仓库设置][gitRemote]

可在这里定义远端仓库.

所有选项选择完后,点击OK,即开始向远端仓库推送数据,如下图.

![git 推送数据][gitPush]

## 更新与合并

要更新你的本地仓库至最新或从远程仓库拉取项目代码到本地库,可在图2中点击"Pull"或"Fetch",打开如下图窗口进行操作.

![git 拉取][gitPull]

**"Pull"操作会合并你的工作目录和远端的改动。**
**而"Fetch"不会合并,但会丢弃你在本地的所有改动与提交。**

要合并其他分支到你的当前分支（例如 master）:在图2中点击"Merge",打开如下窗口进行操作.

![git 合并][gitMerge]

在这两种情况下，git 都会尝试去自动合并改动。
遗憾的是，这可能并非每次都成功，并可能出现冲突（conflicts）。
这时候就需要你修改这些文件来手动合并这些冲突（conflicts）。
改完之后，你需要执行 `git add` 以将它们标记为合并成功.

## 标签

在图2中点击"Create Tag...",打开如下图窗口

![git 标签][gitTag]

## 历史

在图2中点击"Show log",可显示项目的历史信息,如下图.

![git Show log][gitLog]

### 进行比较

右键点击历史信息中的记录可以进行比较,如下图.

![git diff][gitdiff]


## 常用操作界面

在图2中点击"git Sync...",打开如下窗口.

![git 常用操作][gitSyn]

该窗口包含了 git 的常用操作,如 `Pull`,`Push`,`log`,`Commit`等.


***

参考

[TortoiseGit密钥的配置](http://rongjih.blog.163.com/blog/static/335744612010619111042465/)


***

[gitMenu1]: {{ site.url }}/assets/images/gitMenu1.jpg
[gitMenu2]: {{ site.url }}/assets/images/gitMenu2.jpg
[gitConfigUser]: {{ site.url }}/assets/images/gitConfigUserEmail.jpg
[gitClone]: {{ site.url }}/assets/images/gitClone.jpg
[gitBranch]: {{ site.url }}/assets/images/gitBranch.jpg
[gitCommit]: {{ site.url }}/assets/images/gitCommit.jpg
[gitCommit2]: {{ site.url }}/assets/images/gitCommit2.jpg
[gitdiff]: {{ site.url }}/assets/images/gitdiff.jpg
[gitLog]: {{ site.url }}/assets/images/gitLog.jpg
[gitPush]: {{ site.url }}/assets/images/gitPush.jpg
[gitPull]: {{ site.url }}/assets/images/gitPull.jpg
[gitRemote]: {{ site.url }}/assets/images/gitRemote.jpg
[gitSyn]: {{ site.url }}/assets/images/gitSyn.jpg
[gitPushSelect]: {{ site.url }}/assets/images/gitPushSelect.jpg
[gitPushPassword]: {{ site.url }}/assets/images/gitPushPassword.jpg
[gitMerge]: {{ site.url }}/assets/images/gitMerge.jpg
[gitPuttygen]: {{ site.url }}/assets/images/gitPuttygen.gif
[gitPuttygen2]: {{ site.url }}/assets/images/gitPuttygen2.jpg
[gitSSHKeylist]: {{ site.url }}/assets/images/gitSSHKeylist.jpg
[gitKeylistIco]: {{ site.url }}/assets/images/gitKeylistIco.jpg
[gitTag]: {{ site.url }}/assets/images/gitTag.jpg
