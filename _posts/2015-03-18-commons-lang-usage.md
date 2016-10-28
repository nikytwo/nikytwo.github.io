---
layout: post
title: "Commons-Lang 使用"
description: "Commons-Lang 使用"
category: wiki
tags: [Java,Lib]
---


# 1. Info

项目主页:[Commons-Lang](http://commons.apache.org/proper/commons-lang/) : 

Commons项目中用来处理Java基本对象方法的工具类包，可以简化很多平时经常要用到的写法，例如判断字符串是否为空等等。

3.0 开始jar改为`Commons-lang3`


# 2. 结构

3.0 之前共有如下8个包:

* `org.apache.commons.lang` 主要是一些高度重用的`Util`类;
* `org.apache.commons.lang.builder` 包含了一组用于产生每个Java类中都常使用到的toString()、hashCode()、equals()、compareTo()等等方法的构造器;
* `org.apache.commons.lang.enum` 已不建议使用;
* `org.apache.commons.lang.enums` 代替 `lang.enum` 包,用于处理枚举;
* `org.apache.commons.lang.exception` 用于处理Java标准API中的exception，为1.4之前版本提供Nested Exception功能;
* `org.apache.commons.lang.math` 用于处理数字;
* `org.apache.commons.lang.mutable` 于包装值型变量;
* `org.apache.commons.lang.reflect`	Accumulates common high-level uses of the java.lang.reflect APIs.
* `org.apache.commons.lang.text` Provides classes for handling and manipulating text, partly as an extension to java.text.
* `org.apache.commons.lang.time` 提供处理日期和时间的功能。

3.0 增加如下包:

# 3. 常用类

* `ArrayUtils` – 用于对数组的操作，如添加、查找、删除、子数组、倒序、元素类型转换等；
* `BitField` – 用于操作位元，提供了一些方便而安全的方法；
* `BooleanUtils` – 用于操作和转换boolean或者Boolean及相应的数组；
* `CharEncoding` – 包含了Java环境支持的字符编码，提供是否支持某种编码的判断；
* `CharRange` – 用于设定字符范围并做相应检查；
* `CharSet` – 用于设定一组字符作为范围并做相应检查；
* `CharSetUtils` – 用于操作CharSet；
* `CharUtils` – 用于操作char值和Character对象；
* `ClassUtils` – 用于对Java类的操作，不使用反射；
* `ObjectUtils` – 用于操作Java对象，提供null安全的访问和其他一些功能；
* `RandomStringUtils` – 用于生成随机的字符串；
* `SerializationUtils` – 用于处理对象序列化，提供比一般Java序列化更高级的处理能力；
* `StringEscapeUtils` – 用于正确处理转义字符，产生正确的Java、JavaScript、HTML、XML和SQL代码；
* `StringUtils` – 处理String的核心类，提供了相当多的功能；
* `SystemUtils` – 在java.lang.System基础上提供更方便的访问，如用户路径、Java版本、时区、操作系统等判断；
* `Validate` – 提供验证的操作，有点类似assert断言；
* `WordUtils` – 用于处理单词大小写、换行等。
* `HashCodeBuilder` – 用于辅助实现Object.hashCode()方法；
* `Fraction` - 处理分数的类；
* `NumberUtils` - 处理数值的类；
* `DateFormatUtils` – 提供格式化日期和时间的功能及相关常量；
* `DateUtils` – 在Calendar和Date的基础上提供更方便的访问；
* `DurationFormatUtils` – 提供格式化时间跨度的功能及相关常量；
* `FastDateFormat` – 为java.text.SimpleDateFormat提供一个的线程安全的替代类；
* `StopWatch` – 是一个方便的计时器。

# 4. 类详细说明

## 4.1. StringUtils

* `IsEmpty/IsBlank` - 检查字符串是否包含文本
* `Trim/Strip` - 移除首/尾的空格(Trim移除字符编码小于等于32的字符)
* `Equals` - 比较两个字符串(null-safe)
* `startsWith` - check if a String starts with a prefix null-safe
* `endsWith` - check if a String ends with a suffix null-safe
* `IndexOf/LastIndexOf/Contains` - null-safe index-of checks
* `IndexOfAny/LastIndexOfAny/IndexOfAnyBut/LastIndexOfAnyBut` - index-of any of a set of Strings
* `ContainsOnly/ContainsNone/ContainsAny` - does String contains only/none/any of these characters
* `Substring/Left/Right/Mid` - null-safe substring extractions
* `SubstringBefore/SubstringAfter/SubstringBetween` - substring extraction relative to other strings
* `Split/Join` - splits a String into an array of substrings and vice versa
* `Remove/Delete` - removes part of a String
* `Replace/Overlay` - Searches a String and replaces one String with another
* `Chomp/Chop` - removes the last part of a String
* `AppendIfMissing` - 向字符串添加后缀字符,如果后缀不存在
* `PrependIfMissing` - 向字符串添加前缀字符,如果前缀不存在
* `LeftPad/RightPad/Center/Repeat` - 使用指定字符串填充
* `UpperCase/LowerCase/SwapCase/Capitalize/Uncapitalize` - changes the case of a String
* `CountMatches` - counts the number of occurrences of one String in another
* `IsAlpha/IsNumeric/IsWhitespace/IsAsciiPrintable` - checks the characters in a String
* `DefaultString` - protects against a null input String
* `Reverse/ReverseDelimited` - reverses a String
* `Abbreviate` - 使用省略号缩减字符串
* `Difference` - compares Strings and reports on their differences
* `LevenshteinDistance` - the number of changes needed to change one String into another


***

# A. 参考

* [JavaDoc](http://tool.oschina.net/apidocs/apidoc?api=commons-lang)
* [Commons Lang](http://thaim.iteye.com/blog/1315685)
* [Commons-Lang包介绍](http://my.oschina.net/lifestylist/blog/364905)
* [commons-lang开源API 收藏](http://my.oschina.net/willSoft/blog/33453)


