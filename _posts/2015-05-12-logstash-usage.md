---
layout: post
title: "logstash 使用"
description: "logstash 使用"
category: Tool
tags: [日志]
---

# Info

Logstash 是一个应用程序日志、事件的传输、处理、管理和搜索的平台。
你可以用它来统一对应用程序日志进行收集管理，提供 Web 接口用于查询和统计。

Logstash 现在是 ElasticSearch 家族成员之一。
Logstash 本身提供了强大的存储、查询和分析日志的功能(实际是嵌入了 ElasticSearch 和 Kibana)。但当配 ElasticSearch(后端数据存储) 和 Kibana(前端展示) 使用时，它做的就是传输日志的苦事。

下图(来至1.3.*前的官方文档)展示 Logstash、ElasticSearch 和 Kibana(Web Interface) 的关系。

![](http://logstash.net/docs/1.3.3/tutorials/getting-started-centralized-overview-diagram.png)

这里主要使用了 redis 的 list data type，然后通过 BLPOP 来取出消息，shipper 会把消息传递到 redis 的 list 中，然后通过 indexer 从 redis 中取出消息，再导入导 ElasticSearch 中或者直接 stdout。
因此，redis 只是作为了传递者的角色，本身并不存储数据。

Logstash 本身没有分 shipper 以及 indexer 的，这两种角色只是配置不同。

# Required

* jre 7+
* 必需指定 JAVA_HOME

# Install

下载并解压

```sh
curl -O https://download.elasticsearch.org/logstash/logstash/logstash-{logstash_version}.tar.gz
tar -zxvf logstash-{logstash_version}.tar.gz
```

运行

```sh
cd logstash-{logstash_version}
bin/logstash -e 'input { stdin { } } output { stdout {} }'
```

上面例子，使用的是标准输入/输出。

或则通过配置文件启动

```sh
bin/logstash -f my.conf
```

其中 my.conf 文件内容为 `'input { stdin { } } output { stdout {} }'`

# Configuring

## 配置文件的结构

Logstash 的配置文件一般如下：

```yaml
# 这是注释
# 下面是配置内容
input {
	# 从哪里获取日志
  	...
}

filter {
	# 对获取的日志进行处理
	...
}

output {
	# 将处理后的日志输出至哪
	...
}
```

配置文件分3部分，每部分都可以配置一个或多个 Plugins(插件)，并通过 Plugins 来完成所需功能。
其中可以没有 filter 部分，并且 filter 部分的插件是按配置时的顺序执行的。

## Plugins

Logstash 提供了很多插件来完成不同的功能。
同时我们可以开发自己的插件（详见官方文档）来完成特定的功能。

常用插件：

### Input Plugins

* stdin: 从标准输入中获取日志
* file: 从文件中获取日志
* syslog
* eventlog: 从window日志中获取日志
* redis: 从redis中获取日志

### filter Plugins

- grok: 解析和结构化日志信息(从日志信息中提取有用的信息，如: Filed)。[help to build patterns](http://grokdebug.herokuapp.com)
- date: 解析日期
- drop: 丢弃特定的日志记录
- mutate
- clone
- multiline: 处理多行日志

### Output Plugins

- stdout: 将日志输出至标准输出
- elasticsearch: 将日志输出至elasticsearch
- file: 将日志输出至文件
- redis: 将日志输出至redis

### Codec Plugins

- plain
- json
- rubydebug
- multiline: 多行处理

其中 Codec Plugins 用于如何展示数据的，它是可以在 Input Plugins 和 Output Plugins 中使用。


## Filed(属性)

Logstash 将日志记录解析成多个 Filed 。
可以通过 Plugins 定义 Filed。
可以在配置文件中通过`[filedname]`和`[top-level field][nested field]`方式引用 Filed 。


## Conditionals(条件语句)

The conditional syntax is:

```yaml
if EXPRESSION {
  ...
} else if EXPRESSION {
  ...
} else {
  ...
}
```

You can use the following comparison operators:

* equality: ==,  !=,  <,  >,  <=, >=
* regexp: =~, !~
* inclusion: in, not in

The supported boolean operators are:

* and, or, nand, xor

The supported unary operators are:

* !




***

# 参考

* [logstash 初体验](http://jaseywang.me/2012/12/26/logstash-%E5%88%9D%E4%BD%93%E9%AA%8C/)
* [官方文档](http://www.elastic.co/guide/en/logstash/current/index.html)
* [官方文档-入门教程](http://logstash.net/docs/1.1.1/tutorials/getting-started-centralized)


