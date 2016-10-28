---
layout: post
title: "JAXB 使用"
description: "JAXB 使用"
category: wiki
tags: [Java,Xml,json,Lib]
---


## Info

Jaxb是JavaEE的规范.全称Java Architecture for XML Binding.
可以根据XML Schema产生Java类的技术.JAXB也提供了将XML实例文档反向生成Java对象树的方法，并能将Java对象树的内容重新写到XML实例文档.
JAXB 2.0是JDK 1.6的组成部分。JAXB 2.2.3是JDK 1.7的组成部分。在实际使用不需要引入新的jar.

[项目主页](https://jaxb.java.net/)


## Class & Interface

* AXBContext类，是应用的入口，用于管理XML/Java绑定信息。

* Marshaller接口，将Java对象序列化为XML数据。

* Unmarshaller接口，将XML数据反序列化为Java对象。

	JAXBContext jc = JAXBContext.newInstance("com.acme.foo");
	Unmarshaller u = jc.createUnmarshaller();
	Object element = u.unmarshal( new File("foo.xml"));
	Marshaller m = jc.createMarshaller();
	m.marshal(element, ...);

## 常用注解

* @XmlType

@XmlType用在class类的注解，常与@XmlRootElement，@XmlAccessorType一起使用。它有三个属性：name、propOrder、namespace，经常使用的只有前两个属性。

	@XmlType(name = "basicStruct", propOrder = {
		"intValue",
		"stringArray",
		"stringValue"
	)

* @XmlElement

@XmlElement将java对象的属性映射为xml的节点，在使用@XmlElement时，可通过name属性改变java对象属性在xml中显示的名称。

* @XmlRootElement

@XmlRootElement用于类级别的注解，对应xml的跟元素，常与 @XmlType 和 @XmlAccessorType一起使用。

	@XmlType
	@XmlAccessorType(XmlAccessType.FIELD)
	@XmlRootElement
	public class Address {}

* @XmlAttribute

@XmlAttribute用于把java对象的属性映射为xml的属性,并可通过name属性为生成的xml属性指定别名。

* @XmlAccessorType

@XmlAccessorType用于指定由java对象生成xml文件时对java对象属性的访问方式。常与@XmlRootElement、@XmlType一起使用。它的属性值是XmlAccessType的4个枚举值

* @XmlAccessorOrder

@XmlAccessorOrder用于对java对象生成的xml元素进行排序。

* @XmlTransient

@XmlTransient用于标示在由java对象映射xml时，忽略此属性。

* @XmlJavaTypeAdapter

@XmlJavaTypeAdapter常用在转换比较复杂的对象时，如map类型或者格式化日期等。使用此注解时，需要自己写一个adapter类继承XmlAdapter抽象类，并实现里面的方法。

	//xxx为自己定义的adapter类
	@XmlJavaTypeAdapter(value=xxx.class)

* @Temporal(TemporalType.XXXX)

JPA中的时间处理注解,非JAXB

* @XmlElementWrapper

@XmlElementWrapper注解表示生成一个包装 XML 表示形式的包装器元素。 此元素主要用于生成一个包装集合的包装器 XML 元素。

```xml
	int[] names;

	// XML Serialization Form 1 (Unwrapped collection)
	<names> ...</names>
	<names> ...</names>

	// XML Serialization Form 2 ( Wrapped collection )
	<wrapperElement>
	<names> value-of-item </names>
	<names> value-of-item </names>
		   ....
	</wrapperElement>
```


