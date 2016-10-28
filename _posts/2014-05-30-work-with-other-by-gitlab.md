---
layout: post
title: "Gitlab 多人协同开发"
description: "Gitlab 多人协同开发"
category: Thinking
tags: [Git]
---


## gitlab 工作流程

gitlab help中建议的工作流程如下图.

![gitlab workflow][gitlabWorkflow]

1. 开发成员拷贝管理员建立好的项目到自己本地。

2. 创建自己的分支。

3. 在自己的分支上写代码，并提交。

4. 推送到远程服务器，分支是自己的分支。

5. 在Commit页面上浏览分支。

6. 创建一个合并请求。

7. 团队的管理员或者领导者审查并且决定是否合并员工提交的分支到主分支上。


## gitlab 角色与权限

gitlab help 中给出的角色与权限如下图.

![gitlab permissions][gitlabPermissions]

其中

* Master 对应团队的管理员/领导者.

* Developer 对应开发成员


## 分支模型

参考"[一个成功的Git分支模型][gitBranchingModel]".
建立如下的分支模型

![git branch model][gitBranchModel]

* master 分支
* develop 分支
* feature 分支
* release 分支
* hotfix 分支

## gitlab 配置

建立 develop 分支

项目属性设置,锁定分支

合并分支(不建议使用gitlab的自动合并功能)

## 模拟操作

	// TODO 待整理




***

# 参考

* [gitlab多人协同工作](http://herry2013git.blog.163.com/blog/static/219568011201341111240751/)

* [一个成功的Git分支模型][gitBranchingModel]


***

[gitlabWorkflow]: {{ site.url }}/assets/images/gitlab-workflow.png
[gitlabPermissions]: {{ site.url }}/assets/images/gitlab-permissions.png
[gitBranchModel]: {{ site.url }}/assets/images/git-branch-model.png
[gitBranchingModel]: http://www.juvenxu.com/2010/11/28/a-successful-git-branching-model/

