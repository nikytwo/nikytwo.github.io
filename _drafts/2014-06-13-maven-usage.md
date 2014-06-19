---
layout: post
title: "maven 使用"
description: "maven 使用"
category: Tool
tags: [Java, Maven]
---
{% include JB/setup %}


## 安装

* Unzip

* Add `M2_HOME` to the "Environment Variables"

* Add `M2` with the value %M2_HOME%\bin

* Optional:Add `MAVEN_OPTS` to specify JVM properties,e.g. the value -Xms256m -Xmx512m

* Update/Create `Path`, Prepend the value %M2% to add Maven available in the command line

* Make sure that `JAVA_HOME` exists

* Test: `mvn --version`

* 设置本地仓库路径：settings.xml 的 localRepository


## 基础

#### POM

就像 Make 的 Makefile,Ant 的 build.xml 一样,Maven 项目的核心是 pom.xml。

POM(Project Object Model,项目对象模型)定义了项目的基本信息,
用于描述项目如何构建,声明项目依赖,等等。

#### 何为坐标

Maven定义了这样一组规则:世界上任何一个构件都可以使用Maven坐标唯一标识,
Maven坐标的元素包括groupId、artifactId、version、packaging、classifier。
如：

	groupId=org.testng; artifactId=testng; version=5.8;classifier=jdk15

对应的是 Java5 平台上 TestNG 的 5.8 版本

#### 依赖



## 常用插件

Maven本质上是一个插件框架，它的核心并不执行任何具体的构建任务，所有这些任务都交给插件来完成，例如编译源代码是由maven- compiler-plugin完成的。
进一步说，每个任务对应了一个插件目标（goal），每个插件会有一个或者多个目标，例如maven- compiler-plugin的compile目标用来编译位于src/main/java/目录下的主源码，testCompile目标用来编译位于src/test/java/目录下的测试源码。

用户可以通过两种方式调用Maven插件目标。
第一种方式是将插件目标与生命周期阶段（lifecycle phase）绑定，这样用户在命令行只是输入生命周期阶段而已，例如Maven默认将maven-compiler-plugin的compile目标与compile生命周期阶段绑定，因此命令mvn compile实际上是先定位到compile这一生命周期阶段，然后再根据绑定关系调用maven-compiler-plugin的compile目标。
第二种方式是直接在命令行指定要执行的插件目标，例如mvn archetype:generate 就表示调用maven-archetype-plugin的generate目标，这种带冒号的调用方式与生命周期无关。

#### [maven-archetype-plugin][archetype]

Archtype指项目的骨架

* `mvn archetype:generate` => 生成一个很简单的项目骨架，帮助开发者快速上手。


#### [maven-help-plugin][help]

* `mvn help:system` => 打印所有可用的环境变量和Java系统属性

* `mvn help:effective-pom` => 打印项目的有效POM

* `mvn help:effective-settings` => 打印项目的有效settings


#### [maven-antrun-plugin][antrun]

让用户在Maven项目中运行Ant任务。
用户可以直接在该插件的配置以Ant的方式编写Target(`<tasks>...</tasks>`)，然后交给该插件的run目标去执行。
maven-antrun-plugin的run目标通常与生命周期绑定运行。


#### [maven-dependency-plugin][dependency]

maven-dependency-plugin最大的用途是帮助分析项目依赖

* `mvn dependency:list` => 列出项目最终解析到的依赖列表

* `mvn dependency:analyze` => 进一步的描绘项目依赖树

* `mvn dependency:tree` => 可以告诉你项目依赖潜在的问题，如果你有直接使用到的却未声明的依赖，该目标就会发出警告。

* `mvn dependency:copy-dependencies` => 将项目依赖从本地Maven仓库复制到某个特定的文件夹下面。


#### [maven-resources-plugin][resources]

Maven区别对待Java代码文件和资源文件，maven-compiler-plugin用来编译Java代码，maven-resources-plugin则用来处理资源文件。

默认的主资源文件目录是src/main/resources，用户若需要添加额外的资源文件目录，这个时候就可以通过配置maven-resources-plugin来实现。

另外还可以进行资源文件过滤.


#### [maven-surefire-plugin][surefire]

用于执行测试。

只要你的测试类遵循通用的命令约定（以Test结尾、以TestCase结尾、或者以Test开头），就几乎不用知晓该插件的存在。

然而在当你想要跳过测试、排除某些测试类、或者使用一些TestNG特性的时候，了解 [maven-surefire-plugin][surefire] 的一些配置选项就很有用了。


#### [exec-maven-plugin][exec]

它能让你运行任何本地的系统程序，在某些特定情况下，运行一个Maven外部的程序可能就是最简单的问题解决方案。

该插件还允许你配置相关的程序运行参数。

除了exec目标之外，[exec-maven-plugin][exec] 还提供了一个java目标，该目标要求你提供一个mainClass参数，然后它能够利用当前项目的依赖作为classpath，在同一个JVM中运行该mainClass。

有时候，为了简单的演示一个命令行Java程序，你可以在POM中配置好exec-maven-plugin的相关运行参数，然后直接在命令运行 `mvn exec:java` 以查看运行效果。


#### [jetty-maven-plugin][jetty]

在进行Web开发的时候，打开浏览器对应用进行手动的测试几乎是无法避免的，这种测试方法通常就是将项目打包成war文件，然后部署到Web容器中，再启动容器进行验证，这显然十分耗时。

为了帮助开发者节省时间，[jetty-maven-plugin][jetty] 应运而生，它完全兼容 Maven项目的目录结构，能够周期性地检查源文件，一旦发现变更后自动更新到内置的Jetty Web容器中。

做一些基本配置后（例如Web应用的 `contextPath` 和自动扫描变更的时间间隔），你只要执行 `mvn jetty:run` ，然后在IDE中修改代码，代码经IDE自动编译后产生变更，再由 [jetty-maven-plugin][jetty] 侦测到后更新至Jetty容器，这时你就可以直接测试Web页面了。

需要注意的是， [jetty-maven-plugin][jetty] 并不是宿主于Apache或Codehaus的官方插件，因此使用的时候需要额外的配置 `settings.xml` 的 `pluginGroups` 元素，将 `org.mortbay.jetty` 这个 `pluginGroup` 加入。


***

[archetype]: http://maven.apache.org/archetype/maven-archetype-plugin/
[antrun]: http://maven.apache.org/plugins/maven-antrun-plugin/
[dependency]: http://maven.apache.org/plugins/maven-dependency-plugin/
[help]: http://maven.apache.org/plugins/maven-help-plugin/
[resources]: http://maven.apache.org/plugins/maven-resources-plugin/
[surefire]: http://maven.apache.org/plugins/maven-surefire-plugin/
[exec]: http://mojo.codehaus.org/exec-maven-plugin/
[jetty]: http://wiki.eclipse.org/Jetty/Feature/Jetty_Maven_Plugin

