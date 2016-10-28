---
layout: post
title: "SELinux 学习笔记"
description: "SELinux 学习笔记"
category: diary
tags: [Linux, SELinux]
---


# 简介

SELinux 是透过 MAC 的方式来控管程序，他控制的主体是程序(而并非"用户")， 而控制的目标则是该程序能否操作的"资源"！

# 运作模式

SELinux 相关定义说明:

* 主体(Subject):
SELinux 主要想要管理的就是程序，因此你可以将"主体"跟本章谈到的"程序"划上等号；

* 目标(Object):
主体能否操作的"目标"一般就是文档资源。因此这个目标可以与文档资源划上等号；

* 政策(Policy):
由于程序与文档资源数量庞大，因此 SELinux 会依据某些服务来制订基本的操作政策。这些政策内还会有详细的规则 (rule) 来指定不同的服务开放某些资源的存取与否。在目前的 CentOS 6.x 里面仅提供两个主要的政策如下，一般来说，使用预设 target 政策即可。

> * targeted：针对网络服务限制较多，针对本机限制较少，是预设的政策；
>
> * mls：完整的 SELinux 限制，限制方面较为严格。

* 安全性上下文(security context):
主体能不能操作目标除了要符合政策指定之外，主体与目标的"安全性上下文"还必须要一致。 这个"安全性上下文"有点类似文档资源的 rwx .

![SELinux 各组件关系][selinuxRelationship]


# 安全性上下文

查看"安全性上下文"

	ls -Z

"安全性上下文"主要用冒号分为三个字段

	Identify:role:type
	身份识别:角色:类型

* 身份识别:
相当于账号方面的身份识别！主要的身份识别则有底下三种常见的类型：

> * root：表示 root 的账号身份，如同上面的表格显示的是 root 家目录下的数据啊！
>
> * system_u：表示系统程序方面的识别，通常就是程序啰；
>
> * user_u：代表的是一般使用者账号相关的身份。

* 角色:
透过角色字段，我们可以知道这个数据是属于程序、文档资源还是代表使用者。一般的角色有：

> * object_r：代表的是文件或目录等文档资源，这应该是最常见的啰；
>
> * system_r：代表的就是程序啦！不过，一般使用者也会被指定成为 system_r 喔！

* 类型:
在预设的 targeted 政策中， Identify 与 Role 字段基本上是不重要的！重要的在于这个类型 (type) 字段！ 基本上，一个程序能不能读取到这个文档资源，与类型字段有关！而类型在"主体"与"目标"上的定义是不相同，分别是：

> * type: 在"目标"上"类型"任然为类型;
>
> * domain: 但在"主体"上它就为领域了!

domain 与 type 需要搭配,主体才能操作目标.

列子:

	-rwxr-xr-x. root root system_u:object_r:httpd_exec_t:s0 /usr/sbin/httpd
	drwxr-xr-x. root root system_u:object_r:httpd_sys_content_t:s0 /var/www/html

`/usr/sbin/httpd` 属于 `httpd_exec_t` 这个可以执行的类型，而 `/var/www/html` 则属于 `httpd_sys_content_t` 这个可以让 `httpd` 领域读取的类型。下图说明了这两者的关系！

![SELinux 的 domain 与 type 的关系][selinuxDomainType]

上图说明:

1. 首先，我们触发一个可执行的主体，那就是具有 `httpd_exec_t` 这个类型的 `/usr/sbin/httpd`

2. 该类型会让主体具有 `httpd` 这个领域，我们的政策针对这个领域已经制定了许多规则，其中包括这个领域可以读取的目标的类型；

3. 由于 `httpd domain` 被设定为可以读取 `httpd_sys_content_t` 这个类型的目标， 因此你的网页放置到 `/var/www/html/` 目录下，就能够被 `httpd` 那支程序所读取了；

4. 但最终能不能读到正确的资料，还得要看 rwx 是否符合 Linux 权限的规范！

上述的流程告诉我们几个重点:
第一个是政策内需要制订详细的 domain/type 相关性；
第二个是若文档资源的 type 设定错误， 那么即使权限设定为 rwx 全开的 777 ，该程序也无法读取文档资源的啦！


# 启动与关闭

SELinux 支持三种模式:

* enforcing: 强制模式,代表 SELinux 运作中,且已经正确的开始限制 domain/type 了;
* permissive: 宽容模式,代表 SELinux 运作中,不过仅会有警告讯息并不会实际限制 domain/type 的存取.这种模式可以运来作为 SELinux 的 debug 之用;
* disable: 关闭,SELinux 并没有运行.

	getenforce

可查看当前 SELinux 的模式.

配置文件: `/etc/selinux/config`

切换模式

	setenforce [0|1]

0: permissive

1: enforcing

**注意**:无法在disable模式下切换.

# 相关命令

* chcon

修改 "安全性上下文"类型

	chcon [-R] [-t type] [-u user] [-r role] /path/filename
	chcon [-R] --reference=/path/templatefile /path/targetfile

选项与参数：

-R  ：连同该目录下的次目录也同时修改；

-t  ：后面接"安全性上下文"的类型字段！例如 httpd_sys_content_t ；

-u  ：后面接身份识别，例如 system_u；

-r  ：后面街角色，例如 system_r；

--reference=范例文件：拿某个文档当范例来修改后续接的文档的类型！

范例:

	chcon -t net_conf_t /tmp/hosts
	chcon -t samba_share_t /share
	chcon --reference=/var/spool/mail /tmp/hosts

* restorecon

该命令用来复原 "安全性上下文"类型 的默认值,默认值存储在 `/etc/selinux/targeted/contexts`

	restorecon [-Rv] 文件或目录

选项与参数：

-R  ：连同次目录一起修改；

-v  ：将过程显示到屏幕上

* semanage

"安全性上下文"类型 的历史记录存储在 `/etc/selinux/targeted/contexts` 中,可以透过 semanage 来查询修改.

	semanage {login | user | port | interface | fcontext | translation } -l
	semanage fcontext -{a|d|m} [-Nfrst] file_spec

参数说明:
fcontext ：主要用在"安全性上下文"方面的用途， -l 为查询的意思；

-a ：增加的意思，你可以增加一些目录的默认"安全性上下文"类型设定；

-m ：修改的意思；

-d ：删除的意思。

范例:

	semanage fcontext -l | grep '/share'
	semanage fcontext -a -t samba_share_t "/share(/.*)?"

增加目录(可以使用正则表达式)的默认"安全性上下文"类型

	restorecon -Rv /share

恢复默认值,默认为 `samba_share_t`

# 其他工具

## 查询工具

安装

	yum install setools-console

该工具包含 `seinfo` `sesearch` 等命令.

* seinfo

用来查询 SELinux 政策规则

使用

	seinfo [-Atrub]

选项与参数：

-A  ：列出 SELinux 的状态、规则、身份识别、角色、类别等所有信息

-t  ：列出 SELinux 的所有类别 (type) 种类

-r  ：列出 SELinux 的所有角色 (role) 种类

-u  ：列出 SELinux 的所有身份识别 (user) 种类

-b  ：列出所有规则的种类

范例:

	seinfo
	seinfo -t | grep samba

* sesearch

查询详细规则信息

	sesearch [-all] [-s 主体类别] [-t 目标类别] [-b 规则种类]


选项与参数：

--all  ：列出该类别或布尔值的所有相关信息

-t  ：后面还要接类别，例如 -t httpd_t

-b  ：后面还要接布尔值的规则，例如 -b httpd_enable_ftp_server

范例:

	sesearch --all -t samba_share_t

## 修改工具

* getsebool

查询规则的状态(开启/关闭)

	getsebool -a [规则种类]

选项与参数：

-a  ：列出目前系统上面的所有布尔值条款设定为开启或关闭值

* setsebool

设置规则的状态(开启/关闭)

	setsebool [-P] 规则种类=[0|1]

选项与参数：

-P  ：直接将设定值写入配置文件,永远生效.

## 日志工具

* setroubleshoot

当 SELinux 产生错误是,setroubleshoot 会将相关错误信息与解决办法记录到 `/var/log/messages` 与 `/var/log/messages/*` 中

安装

	yum install setroubleshoot setroubleshoot-server

安装完后需重启 auditd

	/etc/init.d/auditd restart

查询错误信息

	cat /var/log/message | grep setroubleshoot

这里查询到的只是摘要信息,要查询详细信息及解决办法,需执行摘要信息提到的 `sealart` 命令.

	sealart -l 6c927892-2469-4fcc-8568-949da0b4cf8d

另外,可以配置 setroubleshoot 将错误信息发送指定的 email.编辑 `/etc/setroubleshoot/setroubleshoot.cfg`

	# 大约在 81 行左右，这行要存在才行！
	recipients_filepath = /var/lib/setroubleshoot/email_alert_recipients

	# 大约在 147 行左右，将原本的 False 修改成 True 先！
	console = True

然后编辑 `/var/lib/setroubleshoot/email_alert_recipients` 文件,增加 email.

	root@localhost
	your@email.address

最后重启 auditd


***

## 参考：

[SELinux 初探][selinux1]

[SELinux 管理原则][selinux2]



***

[selinux1]: http://vbird.dic.ksu.edu.tw/linux_basic/0440processcontrol.php#selinux
[selinux2]: http://vbird.dic.ksu.edu.tw/linux_server/0210network-secure_4.php
[selinuxRelationship]: {{ site.url }}/assets/images/selinuxRelationship.gif
[selinuxDomainType]: {{ site.url }}/assets/images/selinuxDomainType.gif



