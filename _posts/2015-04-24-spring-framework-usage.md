---
layout: post
title: "Spring Framework 使用"
description: "Spring Framework 使用"
category: Lib
tags: [Java]
---
{% include JB/setup %}


# Ioc

## context:annotation-config


# web mvc

## 请求处理流程

DispatcherServlet --> HandlerMapping --> 
DispatcherServlet --> HandlerAdapter --> 
Handler(Controller) --> HandlerAdapter(ModelAndView) --> 
DispatcherServlet(ModelAndView) --> ViewResolver --> 
DispatcherServlet --> View

* HandlerMapping 接口的实现类: SimpleUrlHandlerMapping,DefaultAnnotationHandlerMapping;
* HandlerAdapter 接口的实现类: AnnotationMethodHandlerAdapter;
* Controller 接口: 添加了 @Controller 注解的类就可以担任控制器的职责;
* ViewResolver 接口的实现类: UrlBaseViewResolver,InternalResourceViewResolver(加入了JSTL的支持);
* View 接口: JstlView;
* 其他相关接口/类: HandlerInterceptor(拦截器),LocalResolver(本地化解析),ThemeResolver(主题解析),MultipartResolver(文件上传解析),HandlerExceptionResolver(异常处理,实现类:SimpleMappingExceptionResolver),ModelAndView,RequestToViewNameTranslator,FlashMapManager;

## DispatcherServlet

主要用作职责调度工作，本身主要用于控制流程，主要职责如下：

1. 文件上传解析，如果请求类型是multipart将通过MultipartResolver进行文件上传解析；
2. 通过HandlerMapping，将请求映射到处理器（返回一个HandlerExecutionChain，它包括一个处理器、多个HandlerInterceptor拦截器）；
3. 通过HandlerAdapter支持多种类型的处理器(HandlerExecutionChain中的处理器)；
4. 通过ViewResolver解析逻辑视图名到具体视图实现；
5. 本地化解析；
6. 渲染具体的视图等；
7. 如果执行过程中遇到异常将交给HandlerExceptionResolver来解析。

**DispatcherServlet**中各个接口的默认Bean实现信息配置在`org.springframework.web.servlet`包中的`DispatcherServlet.properties`文件里。

### 配置

* web.xml 声明 **DispatcherServlet**

	<servlet>
		<servlet-name>chapter2</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
		<load-on-startup>1</load-on-startup>
	</servlet>
	<servlet-mapping>
		<servlet-name>chapter2</servlet-name>
		<url-pattern>/</url-pattern>
	</servlet-mapping>

该DispatcherServlet默认使用WebApplicationContext作为上下文，Spring默认配置文件为“/WEB-INF/[servlet名字]-servlet.xml”。

DispatcherServlet也可以配置自己的初始化参数，覆盖默认配置：

contextClass: 实现WebApplicationContext接口的类，当前的servlet用它来创建上下文。
如果这个参数没有指定， 默认使用XmlWebApplicationContext。

contextConfigLocation: 传给上下文实例（由contextClass指定）的字符串，用来指定上下文的位置。
这个字符串可以被分成多个字符串（使用逗号作为分隔符） 来支持多个上下文（在多上下文的情况下，如果同一个bean被定义两次，后面一个优先）。

namespace: WebApplicationContext命名空间。默认值是[server-name]-servlet。

因此我们可以添加初始化参数,如下:

	<servlet>
		<servlet-name>springServlet</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
		<init-param>
			<param-name>contextConfigLocation</param-name>
			<param-value>
				/WEB-INF/spring-mvc.xml
				/WEB-INF/spring-service.xml
				/WEB-INF/spring-data.xml
				/WEB-INF/spring-security.xml
			</param-value>
		</init-param>
		<load-on-startup>1</load-on-startup>
	</servlet>
	<servlet-mapping>
		<servlet-name>springServlet</servlet-name>
		<url-pattern>/</url-pattern>
	</servlet-mapping>

* web.xml 配置上下文载入器(旧版Servlet2.3容器使用`ContextLoaderListener`)

	<context-param>
	  <param-name>contextConfigLocation</param-name>
	  <param-value>
		  classpath:spring-common-config.xml,
		  classpath:spring-budget-config.xml
	  </param-value>
	</context-param>
	<listener>
		<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
	</listener>

如上配置是Spring集成Web环境的通用配置；一般用于加载除Web层的Bean（如DAO、Service等），以便于与其他任何Web框架集成。
contextConfigLocation：表示用于加载Bean的配置文件；
contextClass：表示用于加载Bean的ApplicationContext实现类，默认WebApplicationContext。

## 控制器

2.5之后 spring 默认推荐使用注解,而不再使用"接口继承"去实现控制器.

### 相关注解

* @Controller : 用于定义`controller`类;
* @RequestMapping : 请求到`controller`功能方法的映射规则;
* @RequestParam : 请求参数到`controller`功能处理方法参数上的绑定;
* @ModelAttribute : 请求参数到命令对象的绑定;
* @SessionAttributes : 用于声明session级别存储的属性，放置在`controller`类上，通常列出模型属性（如@ModelAttribute）对应的名称，则这些属性会透明的保存到session中;
* @InitBinder : 自定义数据绑定注册支持，用于将请求参数转换到命令对象属性的对应类型;
* @CookieValue : cookie数据到`controller`功能处理方法参数上的绑定;
* @RequestHeader : 请求头（header）数据到`controller`功能处理方法参数上的绑定;
* @RequestBody : 请求的body体的绑定（通过HttpMessageConverter进行类型转换）;
* @ResponseBody : `controller`功能处理方法的返回值作为响应体（通过HttpMessageConverter进行类型转换）;
* @ResponseStatus : 定义`controller`功能处理方法/异常`controller`返回的状态码和原因;
* @ExceptionHandler : 注解式声明异常`controller`;
* @PathVariable : 将URI模板中的变量绑定到`controller`功能处理方法的参数上，从而支持RESTful架构风格的URI;
* @MatrixVairable;

### 新的 HandlerMapping 和 HandlerAdapter

Spring 3.1 使用新的 @Contoller 和 @RequestMapping 注解支持类：处理器映射 RequestMappingHandlerMapping 和处理器适配器 RequestMappingHandlerAdapter 组合来代替 Spring2.5 开始的处理器映射 DefaultAnnotationHandlerMapping 和处理器适配器 AnnotationMethodHandlerAdapter.

### 相关配置

<context:component-scan> : 扫描并注入组件/Bean/控制器等

<mvc:annotation-driven /> : 相当于注册了DefaultAnnotationHandlerMapping和AnnotationMethodHandlerAdapter两个bean

<mvc:default-servlet-handler/> : 找不到的请求映射到默认的servlet

## 拦截器

### 常见应用场景

* 日志记录：记录请求信息的日志，以便进行信息监控、信息统计、计算PV（Page View）等。
* 权限检查：如登录检测，进入处理器检测检测是否登录，如果没有直接返回到登录页面；
* 性能监控：有时候系统在某段时间莫名其妙的慢，可以通过拦截器在进入处理器之前记录开始时间，在处理完后记录结束时间，从而得到该请求的处理时间（如果有反向代理，如apache可以自动记录）；
* 通用行为：读取cookie得到用户信息并将用户对象放入请求，从而方便后续流程使用，还有如提取Locale、Theme信息等，只要是多个处理器都需要的即可使用拦截器实现。
* OpenSessionInView：如Hibernate，在进入处理器打开Session，在完成后关闭Session。

…………本质也是AOP（面向切面编程），也就是说符合横切关注点的所有功能都可以放入拦截器实现。

### 接口

HandlerInterceptor

* preHandle 方法: 调用Controller前;
* postHandle 方法: 渲染视图前;
* afterCompletion 方法: 渲染视图完毕,且 preHandler 返回 true;

### 拦截器适配器

HandlerInterceptorAdapter

### 配置

	<bean class="org.springframework.web.servlet.handler.BeanNameUrlHandlerMapping">
		<property name="interceptors">
			<list>
				<ref bean="handlerInterceptor1"/>
				<ref bean="handlerInterceptor2"/>
				...
				<ref bean="handlerInterceptorn"/>
			</list>
		</property>
	</bean>

## 视图



***


