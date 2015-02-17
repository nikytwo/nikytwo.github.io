---
layout: post
title: "AngularJS 基础"
description: "AngularJS 基础"
category: Lib
tags: [javascript]
---
{% include JB/setup %}


## 作用域

作用域是用来检测模型的改变和为表达式提供执行上下文的。
它是分层组织起来的，并且层级关系是紧跟着DOM的结构的。

## 控制器

它的主要工作内容是构造模型，并把模型和回调方法一起发送到视图。
视图可以看做是作用域在模板(HTML)上的“投影(projection)”。
而作用域是一个中间地带，它把模型整理好传递给视图，把浏览器事件传递给控制器。
控制器和模型的分离非常重要，因为：

* 控制器是由Javascript写的。Javascript是命令式的，命令式的语言适合用来编写应用的行为。控制器不应该包含任何关于渲染代码（DOM引用或者片段）。
* 视图模板是用HTML写的。HTML是声明是的，声明式的语言适合用来编写UI。视图不应该包含任何行为。
* 因为控制器和视图没有直接的调用关系，所以可以使多个视图对应同一个控制器。这对“换肤(re-skinning)”、适配不同设备（比如移动设备和台式机）、测试，都非常重要。

## 模型

模型就是用来和模板结合生成视图的数据。模型必须在作用域中时可以被引用，这样才能被渲染生成视图。

## 视图

视图的生命周期由作为一个模板开始，它将和模型合并并最终渲染到浏览器的DOM中。

模型是视图变化的唯一动因。

## 指令

## Filters

## 模块和注入器

每个AngularJS应用都有一个唯一的注入器。
注入器提供一个通过名字查找对象实例的方法。
它将所有对象缓存在内部，所以如果重复调用同一名称的对象，每次调用都会得到同一个实例。
如果调用的对象不存在，那么注入器就会让实例工厂(instance factory)创建一个新的实例。

一个模块就是一种配置注入器实例工厂的方式，我们也称为“提供者(provider)”。

