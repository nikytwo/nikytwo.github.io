---
layout: post
title: "EhCache 配置及使用"
description: "EhCache 配置及使用"
category: wiki
tags: [Java,DB]
---


## 简介

EhCache 是一个纯Java的进程内缓存框架，具有快速、精干等特点，是Hibernate中默认的CacheProvider。

* [项目主页](http://ehcache.org/)
* [项目文档](http://www.ehcache.org/documentation/user-guide/getting-started)

主要的特性有：

1. 快速.
2. 简单.
3. 多种缓存策略
4. 缓存数据有两级：内存和磁盘，因此无需担心容量问题
5. 缓存数据会在虚拟机重启的过程中写入磁盘
6. 可以通过RMI、可插入API等方式进行分布式缓存
7. 具有缓存和缓存管理器的侦听接口
8. 支持多缓存管理器实例，以及一个实例的多个缓存区域
9. 提供Hibernate的缓存实现
10. 等等


## 配置

### 基本配置文件

Ehcache默认的配置文件是ehcache.xml(没有该文件,Ehcache会到类路径下找ehcache-failsafe.xml文件。而ehcache-failsafe.xml被包含在jar包中)。
内容如下：

```xml
<ehcache xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="ehcache.xsd">
<!-- <diskStore path="c:\\mdcp_temp" />-->
 <cacheManagerEventListenerFactory class="" properties="" />

 <defaultCache>
        maxElementsInMemory="10000"
        eternal="false"
        timeToIdleSeconds="600"
        overflowToDisk="false"
 </defaultCache>

<cache>
        name="configCache"
        maxElementsInMemory="1000"
        maxElementsOnDisk="1000"
        eternal="true"
        timeToIdleSeconds="300"
        timeToLiveSeconds="1000"
        overflowToDisk="false"
< /cache>

</ehcache>
```

这里配置了一个名为configCache的缓存实例。参数说明如下：

* name : 元素名称即缓存实例的名称。
* maxElementsInMemory : 设定内存中保存对象的最大值。
* overflowToDisk : 设置当内存中缓存到达maxElementsInMemory指定值时是否可以写到硬盘上。
* eternal : 设置内存中的对象是否为永久驻留对象。如果是则无视timeToIdleSeconds和timeToLiveSeconds两个属性。
* timeToIdleSeconds : 设置某个元素消亡前的停顿时间。指元素创建以后，最后一次访问缓存的日期至失效之时的时间间隔。
* timeToLiveSeconds : 设置某个元素消亡前的生存时间。指元素自创建日期起至失效时的间隔时间。

上面的表示此缓存最多可以存活1000秒，如果期间超过300秒未访问,那么此缓存失效！

* memoryStoreEvictionPolicy：缓存满了之后的淘汰算法。默认策略是LRU（最近最少使用），你也可以设置为FIFO（先进先出）或是LFU（较少使用）.

**注意**：defaultCache不管用不用都是必须要配置的。

### 基本使用

```java
//初始化
// 使用默认配置文件创建CacheManager
//CacheManager manager = CacheManager.create();
CacheManager manager = new CacheManager("src/config/ehcache.xml");
//获取指定Cache对象
Cache configCache = manager.getCache("configCache");
//创建节点对象
Element element = new Element("key1","value1");
//保存节点到configCache
configCache.put(element);
//从configCache获取节点
Element element2 = configCache.getCache("key1");
Object  value = element2.getValue();
//更新节点
configCache.put(new Element("key1","value2"));
//删除节点
configCache.remove("key1");
```

### Spring集成配置

```xml
<bean id="cacheManager"
	class="org.springframework.cache.ehcache.EhCacheManagerFactoryBean">
	<property name="configLocation">
		<value>classpath:ehcache.xml</value>
	</property>
</bean>

<!-- levelOneCache 为在ehcache.xml中定义的Cache -->
<bean id="levelOneCache" class="org.springframework.cache.ehcache.EhCacheFactoryBean">
	<property name="cacheManager">
		<ref local="cacheManager" />
	</property>
	<property name="cacheName">
		<value>configCache</value>
	</property>
</bean>
```

### 利用Spring AOP和Ehcache实现线程级方法缓存

1.拦截器的实现

```java
public class CacheInterceptor implements MethodInterceptor {
	private Cache cache;

	/**
	 * @see  org.aopalliance.intercept.MethodInterceptor#invoke(org.aopalliance.intercept.MethodInvocation)
	 */
	public Object invoke(MethodInvocation invocation) throws Throwable {
		Method method = invocation.getMethod();
		String methodName = method.getName();
		Object[] arguments = invocation.getArguments();
		Object result = invocation.proceed();

		String targetName = method.getDeclaringClass().getName();
		String key = getCacheKey(targetName, methodName, arguments);

		Element element = cache.get(key);

		if (element == null) {

			result = invocation.proceed();
			System.out.println("第一次调用方法并缓存其值:" + result);
			cache.put(new Element(key, result));
		} else {
			result = element.getValue();
			System.out.println("从缓存中取得的值为：" + result);
		}
		return result;

	}

	/**
	 * 生成缓存中的KEY值。
	 */
	protected String getCacheKey(String targetName, String methodName, Object[] arguments) {
		StringBuffer sb = new StringBuffer();
		sb.append(targetName).append(".").append(methodName);
		if ((arguments != null) && (arguments.length != 0)) {
			for (int i = 0; i < arguments.length; i++) {
				sb.append(".").append(arguments[i]);
			}
		}
		return sb.toString();
	}

	public void setCache(Cache cache) {
		this.cache = cache;
	}

}
```

2.配置

```xml
<bean id="testService" class="org.mango.cache.ehcache.TestServiceImpl" />

<bean id="serviceMethodInterceptor" class="org.mango.cache.ehcache.CacheInterceptor">
	<property name="cache">
		<ref local="levelOneCache" />
	</property>
</bean>

<bean id="serviceAutoProxyCreator"
	class="org.springframework.aop.framework.autoproxy.BeanNameAutoProxyCreator">
	<property name="interceptorNames">
		<list>
			<value>serviceMethodInterceptor</value>
		</list>
	</property>
	<property name="beanNames">
		<value>*Service</value>
	</property>
</bean>
```


### 集群配置

    // todo


