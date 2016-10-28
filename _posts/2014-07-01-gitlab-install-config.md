---
layout: post
title: "Gitlab 安装配置"
description: "Gitlab 安装配置"
category: wiki
tags: [Git,Gitlab,Tool]
---


## 安装

#### CentOS 6

下载和安装

	wget https://downloads-packages.s3.amazonaws.com/centos-6.5/gitlab-7.0.0_omnibus-1.el6.x86_64.rpm
	sudo yum install openssh-server
	sudo yum install postfix # Select 'Internet Site', using sendmail or exim is also OK
	sudo rpm -i gitlab-7.0.0_omnibus-1.el6.x86_64.rpm

开启防火墙

	sudo lokkit -s http -s ssh

编辑配置文件

	sudo vi /etc/gitlab/gitlab.rb

初始化配置

	sudo gitlab-ctl reconfigure

检查运行情况

	sudo gitlab-ctl status

初始化用户和密码

* username:root

* password:5iveL!fe

卸载

	sudo gitlab-ctl uninstall
	sudo rpm -e gitlab

#### 目录结构

* `/opt/gitlab` Gitlab 的应用程序代码和依赖都存放在此.
* `/var/opt/gitlab` Gitlab-ctl reconfigure 将配置文件以及应用程序数据保存在这里.
* `/etc/gitlab` Gitlab 应用程序的配置文件存放在这里. These are the only files that you should ever have to edit manually.
* `/var/log/gitlab` Gitlab 的所有日志都存放在这里.

#### 启动与停止

启动

	sudo gitlab-ctl start

停止服务

	sudo gitlab-ctl stop

重启

	sudo gitlab-ctl restart


## 备份

运行以下命令:

	sudo gitlab-rake gitlab:backup:create

该命令将在 `/var/opt/gitlab/backups` 目录下创建一个 tar 的备份文件.备份文件名类似 `1393513186_gitlab_backup.tar`,其中 1393513186 是时间戳.

#### 定时备份

	sudo su -
	crontab -e

然后编辑该文件:

	0 2 * * * /opt/gitlab/bin/gitlab-rake gitlab:backup:create

每天凌晨2点进行备份.

#### 恢复备份

首先保证备份文件存在于 `/var/opt/gitlab/backups` 目录下.
然后指定你要恢复的备份文件的时间戳.

	# Stop processes that are connected to the database
	sudo gitlab-ctl stop unicorn
	sudo gitlab-ctl stop sidekiq

	# This command will overwrite the contents of your GitLab database!
	sudo gitlab-rake gitlab:backup:restore BACKUP=1393513186

	# Start GitLab
	sudo gitlab-ctl start

## 配置

Gitlab 几乎都是通过编辑文件 `/etc/gitlab/gitlab.rb` 来进行配置的.**修改完该文件后必须运行 `gitlab-ctl reconfigure` 来变更确认新配置**.

#### `gitlab.rb` 与 其他配置文件的对应

例如:

在 `gitlab.yml` 文件中有如下配置

	production: &base
	  gitlab:
		default_projects_limit: 10

转换为 `gitlab.rb` 时为

	gitlab_rails['gitlab_default_projects_limit'] = 10

又如:

修改备份目录以及备份保存时间

	gitlab_rails['backup_path'] = "/mnt/gitlab/backups"
	gitlab_rails['backup_keep_time'] = 604800	#(备份保留7天)


#### URL

编辑文件 `/etc/gitlab/gitlab.rb`

	external_url "http://gitlab.example.com"

#### 更改 git 的数据存放路径

编辑文件 `/etc/gitlab/gitlab.rb`

	git_data_dir "mnt/nas/git-data"

更改路径后的数据迁移问题参见[备份](#)

#### LDAP

#### HTTPS

编辑文件 `/etc/gitlab/gitlab.rb`

	external_url "https://gitlab.example.com"
	nginx['redirect_http_to_https'] = true

更改端口

增加默认ssl证书

#### email / SMTP

	gitlab_rails['smtp_enable'] = true
	gitlab_rails['smtp_address'] = "smtp.server"
	gitlab_rails['smtp_port'] = 456
	gitlab_rails['smtp_user_name'] = "smtp user"
	gitlab_rails['smtp_password'] = "smtp password"
	gitlab_rails['smtp_domain'] = "example.com"
	gitlab_rails['smtp_authentication'] = "login"
	gitlab_rails['smtp_enable_starttls_auto'] = true

#### 日志

	# Tail all logs; press Ctrl-C to exit
	sudo gitlab-ctl tail

	# Drill down to a sub-directory of /var/log/gitlab
	sudo gitlab-ctl tail gitlab-rails

	# Drill down to an individual file
	sudo gitlab-ctl tail nginx/gitlab_error.log

#### 数据库


## 相关错误处理

#### 无法使用 ssh 进行 push

提示输入 `git@serverip` 的密码。

使用 `ssh -vT git@serverip` 出现如下提示:

	 Next authentication method: password

处理办法:

使用 setroubleshoot 查询出错信息,然后根据提示处理.

	semanage fcontext -a -t ssh_home_t '/home/git/.ssh(/.*)?'
	restorecon -Rv /home/git/.ssh



***

## 参考

[Gitlab Omnibus Readme][omnibusLink]


***

[omnibusLink]: https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md

