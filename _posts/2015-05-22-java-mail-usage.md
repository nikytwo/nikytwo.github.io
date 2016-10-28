---
layout: post
title: "Java Mail 使用"
description: "Java Mail 使用"
category: wiki
tags: [Java, Lib]
---

# Info

JavaMail 是 Java 语言封装了邮件协议包括 POP、SMTP以及IMAP 的接口，是属于 J2EE 的一部分。
通过使用 JavaMail API 可以完成邮件系统中的各种功能，例如收发邮件、邮件服务器开发等等。

## 相关 jar 包的介绍与关系

* `activation.jar`包 : 是`JavaMail`依赖的基础，所有实现`Java Mail API`接口的都需要此包(Java6已包含)。
* `javax.mail-api.jar`包 : `Java Mail API`接口包，只定义了接口，没有实现。
* `javax.mail.jar`包 : `JavaMail`官网提供的实现`Java Mail API`接口的包。
* `mail.jar`包 : 同`javax.mail.jar`包(版本较`javax.mail.jar`包低)。
* `commons-email.jar`包 : 对`JavaMail`中发送邮件进行再封装(不含收取邮件)，使用更简单，依赖于`mail.jar`包。
* 其他 : `JavaMail`官网中还提供了其他邮件协议的实现，如：`GIMAP`等。

# Install

## Maven

# 相关邮件协议介绍

# Usage

	// TODO



***

# 参考

* [官网](https://java.net/projects/javamail/pages/Home)
* [API](https://javamail.java.net/nonav/docs/api/)
* [JavaMail API详解](http://www.jspcn.net/htmlnews/1150019680500144.html)
* [邮件协议POP3/IMAP/SMTP服务的区别](http://blog.sina.com.cn/s/blog_73e6483b0101map3.html)
* [使用 JavaMail 实现邮件发送与收取](http://my.oschina.net/huangyong/blog/178641)
* [Email协议小贴](http://blog.csdn.net/mmzsyx/article/details/2656077)

