---
layout: post
title: "PowerMock 使用"
description: "PowerMock 使用"
category: wiki
tags: [Java,Test,Lib]
---


## 1. 什么是 Mock

在做单元测试的时候，我们会发现我们要测试的方法会引用很多外部依赖的对象，比如：（发送邮件，网络通讯，远程服务, 文件系统等等）。

而我们没法控制这些外部依赖的对象。

为了解决这个问题，我们就需要用到Mock工具来模拟这些外部依赖的对象，来完成单元测试。


## 2. Mock 工具(for Java)

[jMock][jmock]

[EasyMock][easymock]

[Mockito][mockito] 优点:消除了对期望行为（expectations）的需要.

[PowerMock][powermock] 优点:能mock静态,final,私有方法等.

## 3. 使用

### 3.1. 依赖管理

	<dependencies>
	  <dependency>
		 <groupId>org.powermock</groupId>
		 <artifactId>powermock-module-junit4</artifactId>
		 <version>${powermock.version}</version>
		 <scope>test</scope>
	  </dependency>
	  <dependency>
		 <groupId>org.powermock</groupId>
		 <artifactId>powermock-api-mockito</artifactId>
		 <version>${powermock.version}</version>
		 <scope>test</scope>
	  </dependency>
	</dependencies>

其中 `powermock-api-mockito` 依赖于 `mockito-all` 包。
而 `powermock-core` 依赖于 `javassist`，`javassist` 包。

编写测试时，须如下：

	@RunWith(PowerMockRunner.class)
	@PrepareForTest( { YourClassWantToMock.class })	// 待模拟的类
	public class YourTestCase {
	...
	}


### 3.2. 模拟静态类，静态方法和 final 方法

	@RunWith(PowerMockRunner.class)
	@PrepareForTest(IdGenerator.class)
	public class MyTestClass {
	   @Test
	   public void demoStaticMethodMocking() throws Exception {
		   // 模拟静态方法的输出
		   mockStatic(IdGenerator.class);
		   when(IdGenerator.generateNewId()).thenReturn(2L);

		   // 待测试方法
		   new ClassUnderTest().methodToTest();

		   // 验证静态方法被调用(可选)
		   verifyStatic();
		   IdGenerator.generateNewId();
	   }
	}

### 3.3. 模拟构造函数

	@RunWith(PowerMockRunner.class)
	@PrepareForTest(DirectoryStructure.class)
	public class DirectoryStructureTest {
	   @Test
	   public void createDirectoryStructureWhenPathDoesntExist() throws Exception {
		   final String directoryPath = "mocked path";

		   // 模拟 File 类
		   File directoryMock = mock(File.class);

		   // 指示 PowerMockito 如何构造 File 对象.
		   whenNew(File.class).withArguments(directoryPath).thenReturn(directoryMock);

		   // 模式方法的输出
		   when(directoryMock.exists()).thenReturn(false);
		   when(directoryMock.mkdirs()).thenReturn(true);

		   // 待测试的方法,该方法内部会调用我们模拟的构造函数
		   assertTrue(new NewFileExample().createDirectoryStructure(directoryPath));

		   // 验证对象被创建(可选)
		   verifyNew(File.class).withArguments(directoryPath);
	   }
	}


### 3.4. 模拟私有方法

为了实现对类的私有方法的模拟操作，需要 `PowerMock` 提供的另外一项技术：**局部模拟**。

在使用局部模拟时，被创建出来的模拟对象依然是原系统对象。
虽然可以使用方法 `When().thenReturn()` 来指定某些具体方法的返回值，但是没有被用此函数修改过的函数依然按照系统原始类的方式来执行。

这种局部模拟的方式的强大之处在于，除开一般方法可以使用之外，私有方法一样可以使用。

被测试代码：

	public class PrivatePartialMockingExample {
		public String methodToTest() {
			return methodToMock("input");
		}

		private String methodToMock(String input) {
			return "REAL VALUE = " + input;
		}
	 }

为了保持单元测试的纯洁性，在测试方法 methodToTest()时，我们不希望受到私有函数 methodToMock()实现的干扰，为了达到这个目的，我们使用刚提到的局部模拟方法来实现 , 实现方式如下：

	@RunWith(PowerMockRunner.class)
	@PrepareForTest(PrivatePartialMockingExample.class)
	public class PrivatePartialMockingExampleTest {
		@Test
		public void demoPrivateMethodMocking() throws Exception {
			final String expected = "TEST VALUE";
			final String nameOfMethodToMock = "methodToMock";
			final String input = "input";

			PrivatePartialMockingExample underTest = spy(new PrivatePartialMockingExample());

			// 模拟静态方法
			when(underTest, nameOfMethodToMock, input).thenReturn(expected);

			assertEquals(expected, underTest.methodToTest());

			// 验证静态方法被调用
			verifyPrivate(underTest).invoke(nameOfMethodToMock, input);
		}
	}


### 3.5. 设置对象的private属性

需要使用 `whitebox` 向 `class` 或者对象中赋值。

如我们已经对接口尽行了mock，现在需要将此mock加入到对象中，可以采用如下方法：

	Whitebox.setInternalState(Object object, String fieldname, Object… value);

其中 `object` 为需要设置属性的静态类或对象。


### 3.6. 处理public void型的静态方法

	Powermockito.doNothing.when(T class2mock, String method, <T>… params>



***

# 参考

[PowerMock 简介](http://www.ibm.com/developerworks/cn/java/j-lo-powermock)

[玩花招的PowerMock](http://agiledon.github.io/blog/2013/11/21/play-trick-with-powermock)

[使用Powermock进行单元测试，以及常见问题的处理](http://www.cnblogs.com/jiyuqi/p/3564621.html)


[jmock]: http://jmock.org/
[easymock]: http://easymock.org/
[mockito]: http://code.google.com/p/mockito/
[powermock]: http://code.google.com/p/powermock/

