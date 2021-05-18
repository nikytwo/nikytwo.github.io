---
layout: post
title: "Netty事件传播及源码分析"
description: "从源码角度详细介绍了Netty中ChannelPipeline的事件，以及如何传播的"
category: diary
tags: [Java,Lib]
---

Netty高性能的背后，蕴含着优秀的设计。
今天我们从源码角度详细介绍Netty中ChannelPipeline的事件，以及这些事件是如何在ChannelPipeline中传播的。


## ChannelPipeline

ChannelPipeline是负责管理ChannelHandler的有序容器。
其内部维护着一个由ChannelHandlerContext做为节点的**双向链表**。
Netty上的事件便是通过这个链表进行传播的。

首先，一图胜千言
![ChannelPipeline事件与传播][netty_pipeline]

ChannelPipeline需要注意以下几个关键点：
* Netty事件分为入站事件(inbound_event)和出站事件(outbound_event)，**入站事件由 InboundHandler 处理，出站事件由 OutboundHandler 处理**。
* 事件通过ChannelHandlerContext进行传播，**入站事件顺序传播，出站事件逆序传播**。
* 事件是**显示触发**的。（handler处理事件后，若要传递给下一个handler，必须显示调用ChannelHandlerContext里的方法）

其中，
入站事件包括：
* firefireChannelRegistered
* fireChannelUnregistered
* fireChannelActive
* fireChannelInactive
* fireChannelRead
* fireChannelReadComplete
* fireUserEventTriggered
* fireChannelWritabilityChanged
* fireExceptionCaught

出站事件包括：
* bind
* connect
* disconnect
* close
* deregister
* read
* write
* flush
* writeAndFlush

> handler里可以触发任意的事件，即在InboundHandler里可以触发出站事件，而OutboundHandler里也可以触发入站事件。但注意不要出现事件的死循环。

更进一步的，我们从源码上去解读ChannelPipeline的几个要点：
* ChannelPipeline实例化后便提供了**一个头节点和一个尾节点的双向链表**。
```java
    protected DefaultChannelPipeline(Channel channel) {
        this.channel = ObjectUtil.checkNotNull(channel, "channel");
        succeededFuture = new SucceededChannelFuture(channel, null);
        voidPromise =  new VoidChannelPromise(channel, true);

        tail = new TailContext(this);   //尾节点
        head = new HeadContext(this);   //头节点

        // 通过前驱与后续引用，形成一个双向链表
        head.next = tail;
        tail.prev = head;
    }
```
* 头节点被**标记为outbound**和inboud，尾节点**标记为inboud**。(在下面的ChannelHandlerContext会介绍其作用)
* 头节点的入站处理程序会触发新的入站事件，出站处理程序会**调用unsafe对象的操作**(将数据输出到Sokect)。
* 尾节点的入站处理程序是**空处理或回收资源操作**，出站处理程序触发新的出站事件。
```java
    HeadContext(DefaultChannelPipeline pipeline) {
        super(pipeline, null, HEAD_NAME, true, true);   // outbound=true
        unsafe = pipeline.channel().unsafe();   // 出站事件传播到了头节点后，便调用该unsafe对象上的方法
        setAddComplete();
    }

    TailContext(DefaultChannelPipeline pipeline) {
        super(pipeline, null, TAIL_NAME, true, false);  // inboud=true
        setAddComplete();
    }

    protected void onUnhandledInboundMessage(Object msg) {
        try {
            logger.debug(
                    "Discarded inbound message {} that reached at the tail of the pipeline. " +
                            "Please check your pipeline configuration.", msg);
        } finally {
            ReferenceCountUtil.release(msg);    // 释放引用，当引用为0时，便可回收内存空间
        }
    }

    protected void onUnhandledInboundChannelReadComplete() {    // 空处理
    }

    @Override
    public void write(ChannelHandlerContext ctx, Object msg, ChannelPromise promise) throws Exception {
        unsafe.write(msg, promise);     // 通过unsafe将数据输出
    }

```
* 在Channel和ChannelPineline上的事件会**传递给头节点(入站)或尾节点(出站)**。(再配合其他节点的handler，就可以形成了从头到尾（或从尾到头）依次传播的事件)
```java
    @Override
    public final ChannelPipeline fireChannelActive() {
        AbstractChannelHandlerContext.invokeChannelActive(head); //触发head节点入站事件
        return this;
    }

    @Override
    public final ChannelFuture writeAndFlush(Object msg) {
        return tail.writeAndFlush(msg); // 触发tail节点出站事件
    }
```
* addXXX(ChannelHandler)会实例化一个含handler的ChannelHandlerContext对象，并插入链表。
* addFirst在**头节点后**插入新节点，addLass在**尾节点前**插入新节点。

```java

    private AbstractChannelHandlerContext newContext(EventExecutorGroup group, String name, ChannelHandler handler) {
        return new DefaultChannelHandlerContext(this, childExecutor(group), name, handler); // 实例化含handler的ChannelHandlerContext对象
    }

    private void addFirst0(AbstractChannelHandlerContext newCtx) {
        AbstractChannelHandlerContext nextCtx = head.next;
        newCtx.prev = head;
        newCtx.next = nextCtx;
        head.next = newCtx;     // 新节点插入头结点后面
        nextCtx.prev = newCtx;
    }

    private void addLast0(AbstractChannelHandlerContext newCtx) {
        AbstractChannelHandlerContext prev = tail.prev;
        newCtx.prev = prev;
        newCtx.next = tail;
        prev.next = newCtx;
        tail.prev = newCtx;     // 新节点插入尾节点前面
    }
```

## ChannelHandlerContext

ChannelHandlerContext是ChannelPipeline双向链表中的节点。
它是连接ChannelHandler和ChannelPipeline的**桥梁**。有了它ChannelHandler才有机会响应并处理ChannelPipeline中的事件。

其源码不复杂，其中ChannelHandlerContext的findContextInbound/findContextOutbound 是实现**入站事件传递给InboundHandler**，**出站事件传递给OutboundHandler**的关键。
其实现也比较简单，就是判断context的后续(入站事件)/前驱(出站事件)节点对应的handler实现是否是inbound/outbound，如果不是则遍历下一个节点，直至尾节点/头节点。

而在上面的分析中，我们已经知道尾节点实例化时，inbound被设置为ture，头节点实例时，outbound被设置为ture。
这便形成的遍历的**终止**条件。

```java
    private AbstractChannelHandlerContext findContextInbound() {
        AbstractChannelHandlerContext ctx = this;
        do {
            ctx = ctx.next;
        } while (!ctx.inbound); //直到尾节点，因为尾节点inbound在Pipeline中被定义为Ture
        return ctx;
    }

    private AbstractChannelHandlerContext findContextOutbound() {
        AbstractChannelHandlerContext ctx = this;
        do {
            ctx = ctx.prev;
        } while (!ctx.outbound);//直到头节点，因为头节点outbound在Pipeline中被定义为Ture
        return ctx;
    }
```

***

正是由于Netty这些优秀的设计，才使得其高性能下，仍然被灵活使用。
因此也被大家所接受并深爱着。 



***

[netty_pipeline]: {{ site.url }}/assets/images/netty_pipeline.png