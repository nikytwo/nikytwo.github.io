---
layout: post
title: "JDK 命令行工具"
description: "JDK 命令行工具"
category: wiki
tags: [Java, Tool]
---

# Info

JDK 安装目录下的 bin 目录中的工具其实实现是在 tool.jar 中的。

# jps

类似 Linux 下的 ps，但只列出 Java 的进程。

参数说明：

* -q: 值输出进程 ID
* -m: 输出传递给 Java 进程（主函数）的参数
* -l: 输出主函数的完整路径
* -v: 显示传递给 JVM 的参数

# jstat

查看堆信息。

```
jstat -<option> [-t] [-h<line>] <vmid> [<interval> [count]]
```

选项 option 说明：

* -class: ClassLoader 相关信息
* -compiler: 显示 JIT 编译相关信息
* -gc: 显示 GC 大小及使用情况
* -gccapacity: 显示各代当前、最小、最大值
* -gccause: 显示 GC 原因（上一次和当前）
* -gcnew: 显示 GC 新生代信息
* -gcnewcapacity: 
* -gcold: 显示老年代和永久代信息
* -gcoldcapacity: 
* -gcpermcapacity: 
* -gcutil: 显示 GC 使用百分比
* -printcompilation: 输出 JIT 编译的方法信息

其他参数说明：

* -t: 显示程序运行时间
* -h: 周期输出数据多少行后再次输出表头信息
* interval: 采样间隔（秒）
* count: 采样次数

表头列说明（大小单位均为 KB）：

* Loaded: 载人类的数量
* Unloaded: 卸载类的数量
* S0C: s0 大小
* S1C: s1 大小
* S0U: s0 已使用空间
* S1U: s1 已使用空间
* EC: eden 大小
* EU: eden 已使用空间
* OC: 老年代大小
* OU: 老年代已使用空间
* PC: 永久代大小
* PU: 永久代已使用空间
* YGC: 新生代 GC 次数
* YGCT: 新生代 GC 时间
* FGC: 老年代 GC 次数
* FGCT: 老年代 GC 时间
* GCT: GC 总耗时
* LGCC: 上次 GC 原因
* GCC: 当前 GC 原因
* TT: 新生代晋升到老年代的年龄
* MTT: 新生代晋升到老年代的最大年龄
* DSS: 所需 survivor 区大小


# jinfo

// todo


# jmap

查看堆内存使用状况。

```
// 查看进程堆内存使用情况，包括使用的GC算法、堆配置参数和各代中堆内存使用情况
jmap -heap <pid>

// 查看堆内存中的对象数目、大小统计直方图，如果带上live则只统计活对象
jmap -histo[:live] <pid>

// 把进程内存使用情况dump到文件中，再用jhat分析查看
jmap -dump:format=b,file=<dumpFileName> <pid>
```

# jhat

分析堆内存

```
jhat [-port <num>] <hprofFileName>
```

# jstack

导出 java 程序的线程堆栈

```
jstack [-l] <pid>
```

-l: 打印锁的附加信息

可以配合使用的其他 linux 命令：

```
// 显示指定进程的线程信息（cpu使用率等）
top -Hp <pid>
// 10进制转16进制
printf "%x\n" <num>
```

# jstatd

// todo


# hprof

// todo


# 参考

- [Java程序性能优化](https://book.douban.com/subject/19969386/)


