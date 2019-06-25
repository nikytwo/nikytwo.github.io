---
layout: post
title: "Shiro 源码分析-01"
description: "shiro 认证授权及Realm和相关Filter的学习"
category: diary
tags: [Java,Lib]
---

## 简介

Apache Shiro是Java的一个安全框架。目前，使用Apache Shiro的人越来越多，对比Spring Security，可能没有Spring Security做的功能强大，但是在实际工作时可能并不需要那么复杂的东西，所以使用小而简单的Shiro就足够了。

Shiro可以帮助我们完成：认证、授权、加密、会话管理、与Web集成、缓存等。这不就是我们想要的嘛，而且Shiro的API也是非常简单；其基本功能点如下图所示：

![shiro基本功能](http://www.xyula.com/assets/images/shiro-model.png)

下图是从应用程序角度观察Shiro完成的工作：

![shiro 调用链](http://www.xyula.com/assets/images/shiro-2.png)

可以看到：应用代码直接交互的对象是Subject，也就是说Shiro的对外API核心就是`Subject`。
`SecurityManager`管理`Subject`并执行相关安全操作。
`Realm`则负责提供安全相关的数据。

下面会逐一介绍


## Realm

`Realm` 是 Shiro 的一个重要抽象概念。
它向Shiro提供安全数据（如用户、凭证、角色、权限），来确认身份是否合法、是否能进行操作等。


`Realm`相关类的 UML 如下图:

![Realm相关类UML](http://www.xyula.com/assets/images/shiro-realm.png)

* `Realm` 基接口，提供获取认证信息(用户、凭证)的方法
* `AuthenticatingRealm` 封装了用户的认证过程，通过覆盖其虚方法`doGetAuthenticationInfo`可实现自己的认证信息获取；也可注入`credentialsMatcher`实现自定义的凭证校验，如`HashedCredentialsMatcher`等。
* `AuthorizingRealm` 封装了角色和权限相关操作，通过覆盖其虚方法`doGetAuthorizationInfo`可获取自定义的授权信息。
* `JdbcRealm` Shiro 提供的一个数据库相关的`Realm`实现
* `JndiLdapRealm` Shiro 提供的与 LDAP 相关的`Realm`实现
* `ActiveDirectoryRealm` Shiro 提供的与活动目录相关的`Realm`实现

* `AuthenticationInfo` 认证信息(用户、凭证)
* `SaltedAuthenticationInfo` 带盐的认证信息(用户、凭证)
* `MergableAuthenticationInfo` 可以合并的认证信息(用户、凭证)，用于处理多个`Realm`时，将`AuthenticationInfo`进行合并输出
* `SimpleAuthenticationInfo` Shiro 提供的(实现了上面两个接口的)一个实现

* `CredentialsMatcher` 凭证验证接口
* `SimpleCredentialsMatcher`
* `HashedCredentialsMatcher` 加密凭证验证器，可以通过注入`hashAlgorithmName`来设置加密类型(如：MD5)



## 认证

认证相关类 UML 如下图：

![认证相关类UML](http://www.xyula.com/assets/images/shiro-auththenticater.png)

* `Authenticator` 认证器，对用户凭证/token进行认证
* `AbstractAuthenticator` 提供认证监听器，对认证结果进行监听
* `ModularRealmAuthenticator` Shiro 提供的，真正用于认证的类，将认证过程委托给`Realm`，当有多个`Realm`时，使用了策略模式进行认证。
* `AuthenticatingSecurityManager` 继承`SecurityManager`，创建`ModularRealmAuthenticator`以提供认证方法。

* `AuthenticationStrategy` 认证策略模式的接口
* `AtLeastOneSuccessfulStrategy` Shiro 提供的认证策略之一，默认使用
* `FirstSuccessfulStrategy` Shiro 提供的认证策略之一
* `AllSuccessfulStrategy` Shiro 提供的认证策略之一


## 授权

授权相关类 UML 如下图：

![授权相关类UML](http://www.xyula.com/assets/images/shiro-authorizer.png)

* `Authorizer` 鉴权器，对用户-角色或用户-资源进行鉴权，即检查用户是否属于某个角色，或检查用户是否有某项资源的权限
* `ModularRealmAuthorizer` Shiro 提供的，真正用于鉴权的类，其将鉴权过程委托给`Realm`
* `AuthorizingSecurityManager` 继承`SecurityManager`，创建`ModularRealmAuthorizer`以提供鉴权方法。

* `AuthorizationInfo` 角色、权限信息
* `SimpleAuthorizationInfo` Shiro 提供的`AuthorizationInfo`的实现

* `Permission` 权限接口，实现该接口的类可以相互比对是否一致，即鉴别权限是否一致。
* `WildcardPermission` Shiro 提供的`Permission`的实现，可以对带通配符的权限比对。
* `PermissionResolver` 将字符串转换为`Permission`对象的接口
* `WildcardPermissionResolver`


## Filter

Filter相关类 UML 如下图：

![Filter相关类UML](http://www.xyula.com/assets/images/shiro-filter.png)

* `Filter` servlet 定义的接口
* `OncePerRequestFilter` 每个请求只拦截一次
* `AdviceFilter` 提供类似 AOP 功能
* `PathMatchingFilter` 提供了基于Ant风格的请求路径匹配功能及拦截器参数解析的功能，如“roles[admin,user]”自动根据“，”分割解析到一个路径参数配置并绑定到相应的路径
* `AccessControlFilter` 提供了访问控制的基础功能。isAccessAllowed：表示是否允许访问，onAccessDenied：表示当访问拒绝时是否已经处理了
* `AuthenticationFilter` 需认证`Filter`，若用户未认证，会跳转至指定 URL
* `AuthenticatingFilter` 认证`Filter`，对认证进行拦截
* `FormAuthenticationFilter` Shiro 提供的表单认证`Filter`
* `UserFilter` Shiro 提供的`Filter`，判断是否是登录的用户
* `AuthorizationFilter` 权限`Filter`，若用户没有权限，会跳转至指定 URL 或返回401
* `PermissionsAuthorizationFilter` Shiro 提供的权限`Filter`，对是否有权限进行拦截

* `AbstractShiroFilter`
* `ShiroFilter` 是整个Shiro的入口点
* `SpringShiroFilter` Shiro 针对 spring 提供的入口点

* `PathConfigProcessor`


## Subject & SecurityManager

相关类 UML 如下图：

![相关类UML](http://www.xyula.com/assets/images/shiro-SecurityManager-Subject.png)


* `Subject` 是 shiro 重要的接口，对外的API核心
* `DelegatingSubject` 实现了将`Subject`上大多数的方法委托给`SecurityManager`去处理的。
* `WebDelegatingSubject` shiro 提供的`Subject`的实现
* `SecurityManager` 是 shiro 上执行所有安全操作的接口，且它管理着所有Subject，并负责与其他组件进行交互。
* `DefaultSecurityManager`
* `DefaultWebSecurityManager` shiro 上的一个默认实现，可以向其注入`SessionManager`，以实现 Session 的管理
* `ShiroFilterFactoryBean` 是shiro 提供给 spring 中需要配置的一个bean，提供`SecurityManager`、`Filter`和`Realm`等的注入，被注入的`SecurityManager`会传递给`SpringShiroFilter`
* `FilterChainManager` 管理`ShiroFilterFactoryBean`中配置的自定义`Filter`
* `DefaultFilterChainManager` shiro 上的一个默认实现



# 参考

- [跟我学Shiro](https://blog.csdn.net/qq_26562641/article/details/53004617)
- [跟着大宇学Shiro](https://blog.csdn.net/yanluandai1985/article/details/79216141)


