---
layout: post
title: "观察者模式的学习与思考"
description: "观察者模式的学习与思考"
category: Thinking
tags: [Pattern]
---

## 定义

定义和图就免了，直接上代码。

多数网上关于观察者模式的文章的代码都是类似这样的：

```java
// 观察者接口
interface Observer {
    public void update();
}

// 被观察者接口
interface Subject {
    public void attach(Observer observer);
    public void detach(Observer observer);
    public void notify();
}

// 观察者实现
class ConcreteObserver implements Observer {
    @Override
    public void update() {
		...
    }
}

//被观察者实现
class ConcreteSubject implements Subject {
    List<Observer> observers = new ArrayList<Observer>();

    @Override
    void attach(Observer observer) {
		observers.add(observer);
    }

    @Override
    void detach(Observer observer) {
		observers.remove(observer);
    }

    @Override
    void notify() {
        for (Observer observer : observers) {
            observer.update();
        }
    }
}
```

客户端代码:

```java
// 创建被观察者
ConcreteSubject subject1 = new ConcreteSubject();
ConcreteSubject subject2 = new ConcreteSubject();
ConcreteSubject subject3 = new ConcreteSubject();
// 创建观察者
Observer observer1 = new ConcreteObserver();
Observer observer2 = new ConcreteObserver();

// 进行观察
subject1.attach(observer1);
subject2.attach(observer1);
subject1.attach(observer2);
subject3.attach(observer2);

// 被观察者行为改变，发出通知
subject1.doSomething();
subject1.notify();
subject2.doSomething();
subject2.notify();
subject3.doSomething();
subject3.notify();
```

## 问题1

观察者模式的关键要素有那些？或如何识别/使用观察者模式？

直接指出关键要素有点困难，那就先看看哪些不是必须的吧。

1. `Subject`接口是必需的吗？删除它，然后在运行客户端代码。仍然可以。
2. 必须使用聚合的`Observer`吗，这要看业务了。
3. `actach`和`detach`方法也不是必需的，完全可以使用`get`和`set`，或则使用 Ioc 注入等。
只要能向被观察者注册/反注册就可以了。
4. 观察者的实现也可以移动到业务/客户端代码中。

最后剩下的代码是这样的：

```java
// 观察者接口
interface Observer {
    public void update();
}

// 被观察者实现
class ConcreteSubject {
    @Override
    void notify() {
        observer.update();
    }
}
```

观察者模式关键要素:

1. 定义所有观察者的契约（即接口）;
2. 被观察者通知观察者进行处理,也可以说回调观察者的接口函数。

## 问题2

在提出问题2前，先在简化代码中增加另外的观察者接口，如下：

```java
interface Observer1 {
    public void preUpdate();
}

interface Observer2 {
    public void updating();
}

interface Observer3 {
    public void updated();
}

class ConcreteSubject {
    @Override
    void notify() {
		...
        observer.preUpdate();
		...
        observer.updating();
		...
        observer.updated();
		...
    }
}
```

如果做过`Java`的`Swing`开发的，是不是觉得很像事件监听器。


## 问题3

将代码变形一下：

```java
interface Observer {
    public void update();
}

class ConcreteSubject {
    @Override
    void notify() {
        Observer observer = new Observer() {
            @Override
            void update() {
				...
            }
        }
        observer.update()
    }
}
```

如果做过`javascript`开发的，是不是觉得很像回调函数。


## 问题4

函数式编程中的观察者模式。

还是先上代码：

```python
def notify(do):
    do()

def update():
    print("function")

notify(update)
```

	// TODO


## 最后的问题

到底观察者模式长啥样？

	// TODO

模式不应死记硬背，而要灵活运用。不能为了模式而模式。

模式的背后是面向对象。

面向对象为的是松耦合，降低各个对象/模块间的依赖。

# 参考

- [观察者模式详解（包含观察者模式JDK的漏洞以及事件驱动模型）](http://blog.csdn.net/pi9nc/article/details/9106239)
- [设计模式：观察者模式](http://www.cnblogs.com/li-peng/archive/2013/02/04/2892116.html)
- [设计模式学习笔记-观察者模式](http://www.cnblogs.com/wangjq/archive/2012/07/12/2587966.html)
- [观察者模式及Java实现例子](http://www.cnblogs.com/mengdd/archive/2013/02/07/2908929.html)

