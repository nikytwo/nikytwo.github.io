---
layout: post
title: "WebMagic 网络爬虫使用"
description: "WebMagic 网络爬虫使用"
category: Lib
tags: [Java]
---

# 1. info
项目主页:[http://webmagic.io/](http://webmagic.io/)

# 2. vs Scrapy

## 2.1. Selector
两个框架都有`Selector`对象,不同在于,`WebMagic`返回的是`Selectable`对象,而`Scrapy`返回的是`SelectorList`可迭代对象.

开始使用`Scrapy`时还不是很理解为什返回可迭代对象的,当使用`WebMagic`爬取表格时,发现它只能按列爬取,而不能按行爬取,当需要对行进行再处理时,`WebMagic`就显得很麻烦了.
而因为`Scrapy`返回的时可迭代对象,所以是可以按行进行处理的.

```java
// WebMagic 只能一列一列处理
Page.getHtml.xpath("//tr/td[1]")
Page.getHtml.xpath("//tr/td[2]")

// Scrapy 能一行一行处理
trs = response.xpath("//tr")
for tr in trs:
	tr.xpath("td")
	...
```

WebMagic 0.5.2 已经多了个`Selectable.nodes()`方法,可以返回可迭代的对象了.但仍然有些错误存在.

## 2.2. 


***

# A. 参考

* [官方中文文档](http://webmagic.io/docs/zh/)
