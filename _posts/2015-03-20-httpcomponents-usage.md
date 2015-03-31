---
layout: post
title: "HttpComponents 使用"
description: "HttpComponents 使用"
category: Lib
tags: [Java]
---
{% include JB/setup %}

# 1. Info

HttpComponents 也就是以前的httpclient项目，可以用来提供高效的、最新的、功能丰富的支持 HTTP 协议的客户端/服务器编程工具包，并且它支持 HTTP 协议最新的版本和建议。
不过现在的 HttpComponents 包含多个子项目，有：

* HttpComponents Core
* HttpComponents Client
* HttpComponents AsyncClient
* Commons HttpClient

以下列出的是 HttpClient 提供的主要的功能，要知道更多详细的功能可以参见 HttpClient 的[主页][1]。

* 实现了所有 HTTP 的方法（GET,POST,PUT,HEAD 等）
* 支持自动转向
* 支持 HTTPS 协议
* 支持代理服务器等
* 支持Cookie


# 2. 安装

使用Maven管理

	<dependency>
		<groupId>org.apache.httpcomponents</groupId>
		<artifactId>httpclient</artifactId>
		<version>${httpcomponents.version}</version>
	</dependency>
	<dependency>
		<groupId>org.apache.httpcomponents</groupId>
		<artifactId>httpmime</artifactId>
		<version>${httpcomponents.version}</version>
	</dependency>


# 3. 使用

## 3.1 基本使用

略。。。


## 3.2 Fluent方式

`HttpClient`在4.2版本开始增加了Fluent方式来使用，使代码更简洁。

	URI uri = URI.create("http://www.sina.com");
	Request request = Request.Post(uri).bodyForm(
			Form.form().add("username", "zhangsan")
				.add("pasword", "pwd")
				.build());
	request.addHeader("User-Agent", "Ahopedog/5.0 (Linux NT 5.1; rv:5.0) Gecko/20100101 FireDog/5.0");
	request.setHeader("Accept-Charset", "GB2312,utf-8;q=0.7,*;q=0.7");


***

# 参考

* [Java开源框架类库介绍(一)--HttpComponents](http://blog.csdn.net/jariwsz/article/details/22822973)
* [官网][1]


[1]: http://hc.apache.org/index.html
