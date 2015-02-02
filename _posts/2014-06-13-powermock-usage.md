---
layout: post
title: "PowerMock 使用"
description: "PowerMock 使用"
category: Lib
tags: [Java,Test]
---
{% include JB/setup %}


## 什么是 Mock

在做单元测试的时候，我们会发现我们要测试的方法会引用很多外部依赖的对象，比如：（发送邮件，网络通讯，远程服务, 文件系统等等）。

而我们没法控制这些外部依赖的对象。

为了解决这个问题，我们就需要用到Mock工具来模拟这些外部依赖的对象，来完成单元测试。


## Mock 工具(for Java)

[jMock][jmock]

[EasyMock][easymock]

[Mockito][mockito] 优点:消除了对期望行为（expectations）的需要.

[PowerMock][powermock] 优点:能mock静态,final,私有方法等.

## 使用

### 编写测试前

编写测试时，须如下：

	@RunWith(PowerMockRunner.class)
	@PrepareForTest( { YourClassWithEgStaticMethod.class })
	public class YourTestCase {
	...
	}



	// TODO 待整理




***


[jmock]: http://jmock.org/
[easymock]: http://easymock.org/
[mockito]: http://code.google.com/p/mockito/
[powermock]: http://code.google.com/p/powermock/

