---
layout: post
title: "JUnit 使用"
description: "JUnit 使用"
category: wiki
tags: [Java,Test,Lib]
---


## 简介

项目主页: [http://junit.org/][homeLink]

JUnit是一个Java语言的单元测试框架。它由Kent Beck和Erich Gamma建立，逐渐成为源于Kent Beck的sUnit的xUnit家族中为最成功的一个。 JUnit有它自己的JUnit扩展生态圈。

多数Java的开发环境都已经集成了JUnit作为单元测试的工具。



## 使用

	public class Example {
		File output;
		@Before
		public void createOutputFile() {
			  output= new File(...);
		}
		@Test
		public void something() {
			  ...
		}
		@After
		public void deleteOutputFile() {
			  output.delete();
		}
	}


## 注解说明

#### @Before：

使用了该元数据的方法在每个测试方法执行之前都要执行一次。

#### @After：

使用了该元数据的方法在每个测试方法执行之后要执行一次。

注意：`@Before` 和 `@After` 标示的方法只能各有一个。
这个相当于取代了JUnit以前版本中的 `setUp` 和 `tearDown` 方法，当然你还可以继续叫这个名字，不过JUnit不会霸道的要求你这么做了。

#### @Test(expected=*.class)

在JUnit4.0之前，对错误的测试，我们只能通过 `fail` 来产生一个错误，并在try块里面 `assertTrue(true)` 来测试。现在，通过 `@Test` 元数据中的 `expected` 属性。`expected` 属性的值是一个异常的类型

#### @Test(timeout=xxx):

该元数据传入了一个时间（毫秒）给测试方法，

如果测试方法在制定的时间之内没有运行完，则测试也失败。

#### @ignore：

该元数据标记的测试方法在测试中会被忽略。
当测试的方法还没有实现，或者测试的方法已经过时，或者在某种条件下才能测试该方法（比如需要一个数据库链接，而在本地测试的时候，数据库并没有连接），那么使用该标签来标示这个方法。
同时，你可以为该标签传递一个String的参数，来表明为什么会忽略这个测试方法。
比如：`@ignore(“该方法还没有实现”)`，在执行的时候，仅会报告该方法没有实现，而不会运行测试方法。

#### @BeforeClass 和 @AfterClas :

只在测试用例初始化时执行 `@BeforeClass` 方法，当所有测试执行完毕之后，执行 `@AfterClass` 进行收尾工作。
在这里要注意一下，每个测试类只能有一个方法被标注为 `@BeforeClass` 或 `@AfterClass`，并且该方法必须是 `Public` 和 `Static` 的。

#### @RunWith :

`@RunWith` 是用来修饰类的，而不是用来修饰函数的.指定使用哪个Runer运行测试.
以下是常用的Runer.

* `@RunWith(Parameterized.class)` : 参数化测试.用 `@Parameters` 标注测试数据的集合.

* `@RunWith(Suite.class)` :
打包测试,将所有需要运行的测试类集中起来，一次性的运行完毕.
同时还需要另外一个标注 `@Suite.SuiteClasses`，来表明这个类是一个打包测试类。
我们把需要打包的类作为参数传递给该标注就可以了。


***

## 参考

[项目文档][wikiLink]


***

[homeLink]: http://junit.org/
[wikiLink]: https://github.com/junit-team/junit/wiki
