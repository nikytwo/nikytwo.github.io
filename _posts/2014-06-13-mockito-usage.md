---
layout: post
title: "Mockito 使用"
description: "Mockito 使用"
category: Lib
tags: [Java,Test]
---


## 什么是 Mock

在做单元测试的时候，我们会发现我们要测试的方法会引用很多外部依赖的对象，比如：（发送邮件，网络通讯，远程服务, 文件系统等等）。

而我们没法控制这些外部依赖的对象。

为了解决这个问题，我们就需要用到Mock工具来模拟这些外部依赖的对象，来完成单元测试。


## Mock 工具(for Java)

[jMock][jmock]

[EasyMock][easymock]

[Mockito][mockito] 优点:消除了对期望行为（expectations）的需要.

[PowerMock][powermock] 优点:能mock静态,final,私有方法等.



## 模拟对象

模拟 `LinkedList` 的对象

	LinkedList mockedList = mock(LinkedList.class);

此时调用 `get` 方法，是会返回 `null` ，因为还没有对方法调用的返回值做模拟

	System.out.println(mockedList.get(999));

## 模拟方法调用的返回值

模拟获取第一个元素时，返回字符串 `first`

	when(mockedList.get(0)).thenReturn("first");

此时打印输出 `first`

	System.out.println(mockedList.get(0));


## 模拟方法调用抛出异常

模拟获取第二个元素时，抛出 `RuntimeException`

	when(mockedList.get(1)).thenThrow(new RuntimeException());

此时将会抛出 `RuntimeException`

	System.out.println(mockedList.get(1));

没有返回值类型的方法也可以模拟异常抛出

	doThrow(new RuntimeException()).when(mockedList).clear();

## 模拟方法调用的参数匹配

`anyInt()` 匹配任何int参数，这意味着参数为任意值，其返回值均是 `element`

	when(mockedList.get(anyInt())).thenReturn("element");

此时打印是 `element`

	System.out.println(mockedList.get(999));

更灵活的参数匹配，请参见 [Mockito Matchers](http://mockito.googlecode.com/svn/tags/latest/javadoc/org/mockito/Matchers.html)

## 验证方法调用或调用次数

调用 `addList` ,其中 `addList` 方法内部调用了 `List` 的 `add` 方法

	mockService.addList("once");

验证 `add` 方法是否被调用了

	verify(mockedList).add("once");

验证 `add` 方法是否被调用了一次

	verify(mockedList, times(1)).add("once");
	verify(mockedList, never()).add("twice");

还可以通过 `atLeast(int i)` 和 `atMost(int i)` 来替代 `time(int i)` 来验证被调用的次数最小值和最大值；`never()` 验证从未调用。


## 验证方法执行顺序

`Service` 对象内部先后调用 `List` 对象的 `add` 方法两次.

	List firstMock = mock(List.Class);
	List secondMock = mock(List.Class);

	firstMock.add("first");
	secondMock.add("second");

创建 `InOrder` 对象来验证执行顺序.

	InOrder inOrder = InOrder(firstMock, secondMock);
	inOrder.verify(firstMock).add("first");
	inOrder.verify(secondMock).add("second");


## 验证超时

使用 `timeout(int i)` 来验证超时,但不能和 `InOrder` 一起使用.

	verify(mock, timeout(200)).someMethod();

验证超时调用2次.

	verify(mock, timeout(200).times(2)).someMethod();

验证超时调用至少2次.

	verify(mock, timeout(200).atLeast(2)).someMethod();

自定义验证模型

	// TODO 待研究
	verify(mock, new Timeout(100, yourOwnVerificationMode)).someMethod();


## Spy

**局部模拟**

在使用局部模拟时，被创建出来的模拟对象依然是原系统对象。
虽然可以使用方法 `When().thenReturn()` 来指定某些具体方法的返回值，但是没有被用此函数修改过的函数依然按照系统原始类的方式来执行。


## callRealMethod

也是**局部模拟**，但行为与 `spy` 相反。


## 使用注解 @Mock, @Captor, @Spy, @InjectMocks

可以使用 `@Mock` 注解来简化 Mock 对象的创建.

	@Mock private List mockList;

可以使用 `@Captor` 简化 `ArgumentCaptor` 的创建.

	// TODO 待添加实例.

可以使用 `@Sqy` 代替 `spy(Object)`

	@Spy List spyList = new ArrayList();

可以使用 `@InjectMocks` 注解自动注入被测试的对象.

	@InjectMocks private Service mockService;

**注意**: 使用以上注解都必须在(基)类中或 test runner 中初始化.

	MockitoAnnotations.initMocks(testClass);



***

## 参考:

[Mockito JavaDoc](http://mockito.googlecode.com/svn/tags/latest/javadoc/org/mockito/Mockito.html)

[Mockito入门](http://blog.csdn.net/huoshuxiao/article/details/6107835)


***

[jmock]: http://jmock.org/
[easymock]: http://easymock.org/
[mockito]: http://code.google.com/p/mockito/
[powermock]: http://code.google.com/p/powermock/

