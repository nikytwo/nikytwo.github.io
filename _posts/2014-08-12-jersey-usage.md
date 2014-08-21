---
layout: post
title: "Jersey使用"
description: "Jersey使用"
category: Lib
tags: [Java, REST]
---
{% include JB/setup %}


## Info

Jersey是JAX-RS（JSR311）开源参考实现用于构建RESTful Web service。
此外Jersey还提供一些额外的API和扩展机制，所以开发人员能够按照自己的需要对Jersey进行扩展。

[软件首页][lnkHome]

[软件文档][lnkDoc]

## 依赖

### 兼容性

Jersey 2.6 => java se 1.6+
Jersey 2.7 => java se 1.7+

### 使用

* 在应用服务器中使用

```xml
	<dependency>
		<groupId>org.glassfish.jersey.containers</groupId>
		<!-- if your container implements Servlet API older than 3.0, use "jersey-container-servlet-core"  -->
		<artifactId>jersey-container-servlet</artifactId>
		<version>2.11</version>
	</dependency>
	<!-- Required only when you are using JAX-RS Client -->
	<dependency>
		<groupId>org.glassfish.jersey.core</groupId>
		<artifactId>jersey-client</artifactId>
		<version>2.11</version>
	</dependency>
```

## JAX-RS 应用

[JAX-RS解析][lnkJaxRS]

### Root Resource Classes

Root Resource Classes 是使用 @Path 标注并且有一个方法被 @Path 或 HTTP 方法(@Get,@Put,@Post,@Delete等)标注.

#### @Path

#### @Get,@Put,@Post,@Delete...(Http 方法)

#### @Produces

#### @Consumes

### 参数注解(@*Param)

* @DefaultValue

* @QueryParam

* @PathParam

* @MatrixParam

* @HeaderParam

* @cookieParam

* @FormParam

* @BeanParam

### 子资源

### Root Resource classes 的生命周期

### 注入规则

### @Context 的使用


## 应用部署与运行时

### HTTP Server

### 基于 Servlet 的部署

#### Servlet 2.x Container

#### Servlet 3.x Container


***

## 参考

[JAX-RS解析][lnkJaxRS]

[使用 Jersey 和 Apache Tomcat 构建 RESTful Web 服务][lnkJerseySample]


***

[lnkHome]: https://jersey.java.net/
[lnkDoc]: https://jersey.java.net/documentation/latest/index.html
[lnkJaxRS]: http://warm-breeze.iteye.com/blog/1578271
[lnkJerseySample]: https://www.ibm.com/developerworks/cn/web/wa-aj-tomcat/

