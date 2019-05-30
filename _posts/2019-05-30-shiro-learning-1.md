---
layout: post
title: "Shiro 源码学习-认证授权"
description: "shiro 认证授权及Realm和相关Filter的学习"
category: diary
tags: [Java,Lib]
---

## 简介


## Realm

Realm
AuthenticatingRealm
AuthorizingRealm
JdbcRealm
JndiLdapRealm
AbstractLdapRealm
ActiveDirectoryRealm

UML
![Realm相关类UML](http://www.xyula.com/assets/images/shiro-realm.png)


## 认证

UML
![认证相关类UML](http://www.xyula.com/assets/images/shiro-auththenticater.png)

Authenticator
AbstractAuthenticator
ModularRealmAuthenticator
AuthenticatingSecurityManager

AuthenticationStrategy
AbstractAuthenticationStrategy
AtLeastOneSuccessfulStrategy
FirstSuccessfulStrategy
AllSuccessfulStrategy

AuthenticationInfo
SaltedAuthenticationInfo
MergableAuthenticationInfo
SimpleAuthenticationInfo

CredentialsMatcher
SimpleCredentialsMatcher
HashedCredentialsMatcher


## 授权

UML
![认证相关类UML](http://www.xyula.com/assets/images/shiro-authorizer.png)

Authorizer
ModularRealmAuthorizer
AuthorizingSecurityManager

AuthorizationInfo
SimpleAuthorizationInfo

Permission
WildcardPermission
PermissionResolver
WildcardPermissionResolver


## Filter

UML
![认证相关类UML](http://www.xyula.com/assets/images/shiro-filter.png)

Filter
OncePerRequestFilter
AdviceFilter
PathMatchingFilter
AccessControlFilter
UserFilter
AuthenticationFilter
AuthenticatingFilter
FormAuthenticationFilter
AuthorizationFilter
PermissionsAuthorizationFilter

AbstractShiroFilter
ShiroFilter
SpringShiroFilter

PathConfigProcessor


## Subject & SecurityManager

UML
![认证相关类UML](http://www.xyula.com/assets/images/shiro-SecurityManager-Subject.png)


* `Subject` 是 shiro 重要的接口
* `DelegatingSubject` 实现了将`Subject`上大多数的方法委托给`SecurityManager`去处理的。
* `WebDelegatingSubject` shiro 提供的`Subject`的实现
* `SecurityManager` 是 shiro 上执行操作的接口
* `DefaultSecurityManager`
* `DefaultWebSecurityManager` shiro 上的一个默认实现，可以向其注入`SessionManager`，以实现 Session 的管理
* `ShiroFilterFactoryBean` 是shiro 提供给 spring 中需要配置的一个bean，提供`SecurityManager`和自定义`Filter`等的注入，被注入的`SecurityManager`会传递给`SpringShiroFilter`
* `FilterChainManager` 管理`ShiroFilterFactoryBean`中配置的自定义`Filter`
* `DefaultFilterChainManager` shiro 上的一个默认实现



# 参考

- [跟我学Shiro](https://blog.csdn.net/qq_26562641/article/details/53004617)


