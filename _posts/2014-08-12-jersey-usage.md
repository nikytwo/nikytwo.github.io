---
layout: post
title: "Jersey使用"
description: "Jersey使用"
category: wiki
tags: [Java,REST,Lib]
---


## 1. Info

Jersey是JAX-RS（JSR311）开源参考实现用于构建RESTful Web service。
此外Jersey还提供一些额外的API和扩展机制，所以开发人员能够按照自己的需要对Jersey进行扩展。

[软件首页][lnkHome]

[软件文档][lnkDoc]

## 2. 依赖

### 2.1. 兼容性

Jersey 2.6 => java se 1.6+

Jersey 2.7 => java se 1.7+

### 2.2. 使用

* 在应用服务器(Servlet 容器)中使用

```

	<dependency>
		<groupId>org.glassfish.jersey.containers</groupId>
		<!-- if your container implements Servlet API older than 3.0, use "jersey-container-servlet-core"  -->
		<artifactId>jersey-container-servlet</artifactId>
		<version>2.11</version>
	</dependency>
	<!-- Required only when you are using JAX-RS Client -->
	<dependency>
		<groupId>org.glassfish.jersey.core</groupId>
		<artifactId>jersey-client</artifactId>
		<version>2.11</version>
	</dependency>

```

* Other

	// TODO 待整理

## 3. JAX-RS 应用

[JAX-RS解析][lnkJaxRS]

### 3.1. Root Resource Classes

Root Resource Classes 是使用 @Path 标注并且有一个方法被 @Path 或 HTTP 方法(@Get,@Put,@Post,@Delete等)标注.

#### 3.1.1. @Path

@Path 注解是一个相对的 URI 路径.如:

	@Path("/users/{username}")

将响应这个 URL: `http://example.com/users/Galileo`

为了获取 username 的值,可以在请求方法的参数中使用 @PathParam 注解.


	@Path("/users/{username}")
	public class UserResource {

		@GET
		@Produces("text/xml")
		public String getUser(@PathParam("username") String userName) {
			...
		}
	}

可以使用正则表到时来限定(username)参数.

	@Path("users/{username: [a-zA-Z][a-zA-Z_0-9]*}")

若 username 不匹配,将响应404页面.

#### 3.1.2. @Get,@Put,@Post,@Delete...(Http 方法)

@GET, @PUT, @POST, @DELETE 和 @HEAD 是 JAX-RS 中定义的资源方法注解,它们与 HTTP 里的方法是一一对应的.

即使没有明确标注,JAX-RS 运行时也会默认自动支持 HEAD 和 OPTIONS 方法.

#### 3.1.3. @Produces

@Produces 可以应用与类和方法上.其用于指明将要返回给客户端的资源表述的 MIME 媒体类型.


	@Path("/myResource")
	@Produces("text/plain")
	public class SomeResource {
		@GET
		public String doGetAsPlainText() {
			...
		}

		@GET
		@Produces("text/html")
		public String doGetAsHtml() {
			...
		}
	}

上例中,方法中的媒体类型将覆盖类中定义的.

可以对方法指定多个媒体类型.

	@GET
	@Produces({"application/xml", "application/json"})
	public String doGetAsXmlOrJson() {
		...
	}

可以指定媒体类型的 quality 因子.

	@GET
	@Produces({"application/xml; qs=0.9", "application/json"})
	public String doGetAsXmlOrJson() {
		...
	}

如果客户端同时接受"application/xml"和"application/json",在此例,服务器会返回"application/json",因为"application/xml"的 quality 因子比较低.

#### 3.1.4. @Consumes

@Consumes 用来指定可以接受客户端发送过来的 MIME 媒体类型，同样可以用于类或者方法，也可以指定多个 MIME 媒体类型.

	@POST
	@Consumes("text/plain")
	public void postClichedMessage(String message) {
		// Store the message
	}

注意:资源方法的返回值为 void,这表示客户端接受到的响应状态码将为204.

### 3.2. 参数注解(@*Param)

* @PathParam

可以获取URI中指定规则的参数.

* @QueryParam

用于获取GET请求中的查询参数.

* @DefaultValue

可以为参数设置默认值.

* @MatrixParam

* @HeaderParam

* @cookieParam

* @FormParam

从POST请求的表单参数中获取数据.

* @BeanParam

当请求参数很多时，比如客户端提交一个修改用户的PUT请求，请求中包含很多项用户信息。这时可以用@BeanParam

	public class MyBeanParam {
		@PathParam("p")
		private String pathParam;

		@MatrixParam("m")
		@Encoded
		@DefaultValue("default")
		private String matrixParam;

		@HeaderParam("header")
		private String headerParam;

		private String queryParam;

		public MyBeanParam(@QueryParam("q") String queryParam) {
			this.queryParam = queryParam;
		}

		public String getPathParam() {
			return pathParam;
		}
		...
	}

	//Injection of MyBeanParam as a method parameter:
	@POST
	public void post(@BeanParam MyBeanParam beanParam, String entity) {
		final String pathParam = beanParam.getPathParam(); // contains injected path parameter "p"
		...
	}

### 3.3. 子资源

	@Singleton
	@Path("/printers")
	public class PrintersResource {

		@GET
		@Produces({"application/json", "application/xml"})
		public WebResourceList getMyResources() { ... }

		@GET @Path("/list")
		@Produces({"application/json", "application/xml"})
		public WebResourceList getListOfPrinters() { ... }

		@GET @Path("/jMakiTable")
		@Produces("application/json")
		public PrinterTableModel getTable() { ... }

		@GET @Path("/jMakiTree")
		@Produces("application/json")
		public TreeModel getTree() { ... }

		@GET @Path("/ids/{printerid}")
		@Produces({"application/json", "application/xml"})
		public Printer getPrinter(@PathParam("printerid") String printerId) { ... }

		@PUT @Path("/ids/{printerid}")
		@Consumes({"application/json", "application/xml"})
		public void putPrinter(@PathParam("printerid") String printerId, Printer printer) { ... }

		@DELETE @Path("/ids/{printerid}")
		public void deletePrinter(@PathParam("printerid") String printerId) { ... }
	}

如果请求的 URL 为"printers",则上面没有使用 @Path 注解的方法将被调用.如果请求的 URL 为"printers/list",则自资源方法 getListOfPrinters 将被调用.

	@Path("/item")
	public class ItemResource {
		@Context UriInfo uriInfo;

		@Path("content")
		public ItemContentResource getItemContentResource() {
			return new ItemContentResource();
		}

		@GET
		@Produces("application/xml")
			public Item get() { ... }
		}
	}

	public class ItemContentResource {

		@GET
		public Response get() { ... }

		@PUT
		@Path("{version}")
		public void put(@PathParam("version") int version,
						@Context HttpHeaders headers,
						byte[] in) {
			...
		}
	}

如果请求的 URL 为"item/content",则 getItemContentResource 将被调用.

	@Path("/item")
	public class ItemResource {

		@Path("/")
		public ItemContentResource getItemContentResource() {
			return new ItemContentResource();
		}
	}

请求为"/item/locator"或为"/item",getItemContentResource 都会被调用.

@Singletion

	import javax.inject.Singleton;

	@Path("/item")
	public class ItemResource {
		@Path("content")
		public Class<ItemContentSingletonResource> getItemContentResource() {
			return ItemContentSingletonResource.class;
		}
	}

	@Singleton
	public class ItemContentSingletonResource {
		// this class is managed in the singleton life cycle
	}

programmatic resource model

	import org.glassfish.jersey.server.model.Resource;

	@Path("/item")
	public class ItemResource {

		@Path("content")
		public Resource getItemContentResource() {
			return Resource.from(ItemContentSingletonResource.class);
		}
	}

### 3.4. Root Resource classes 的生命周期

默认的生命周期是每个请求的,即对应每个请求都会有一个实例被创建.

生命周期

* 默认生命周期 @RequestScoped(or none)

* Per-lookup @PerLookup

* Singleton	@Singleton

### 3.5. 注入规则

### 3.6. @Context 的使用

可以通过@Context 注释获取ServletConfig、ServletContext、HttpServletRequest、HttpServletResponse和HttpHeaders等对象.

## 4. 应用部署与运行时

### 4.1. JAX-RS Application 模型

JAX-RS 提供了一个部署无关的虚类 Application 用以发布 root 资源和 provider classes. Web Service 可以继承这个类来发布自己的 root 资源和 provider classes.

	public class MyApplication extends Application {
		@Override
		public Set<Class<?>> getClasses() {
			Set<Class<?>> s = new HashSet<Class<?>>();
			s.add(HelloWorldResource.class);
			return s;
		}
	}

Jersey 也实现了自己的 Application 类 ResourceConfig.该类可以直接实例化或继承并在构造函数中进行配置来发布资源.

	// 下面的 Application 会在部署时扫描"org.foo.rest"和"org.bar.rest"包中的 JAX-RS 组件
	public class MyApplication extends ResourceConfig {
		public MyApplication() {
			packages("org.foo.rest;org.bar.rest");
		}
	}

### 4.2. Classpath Scanning 配置

	// TODO 待整理


### 4.3. HTTP Server 部署

Java base HTTP servers 展示了一种简单灵活的方式来部署 Jersey 应用.Jersey 自定义的工厂方法可以返回正确的 HTTP server 实例.

#### 4.3.1. JDK HTTP Server

	URI baseUri = UriBuilder.fromUri("http://localhost/").port(9998).build();
	ResourceConfig config = new ResourceConfig(MyResource.class);
	HttpServer server = JdkHttpServerFactory.createHttpServer(baseUri, config);

需要的依赖

	<dependency>
		<groupId>org.glassfish.jersey.containers</groupId>
		<artifactId>jersey-container-jdk-http</artifactId>
		<version>2.11</version>
	</dependency>

#### 4.3.2. Simple server

	URI baseUri = UriBuilder.fromUri("http://localhost/").port(9998).build();
		ResourceConfig config = new ResourceConfig(MyResource.class);
		SimpleContainer server = SimpleContainerFactory.create(baseUri, config);

需要的依赖

	<dependency>
		<groupId>org.glassfish.jersey.containers</groupId>
		<artifactId>jersey-container-simple-http</artifactId>
		<version>2.11</version>
	</dependency>

#### 4.3.3. Jetty HTTP Server

	URI baseUri = UriBuilder.fromUri("http://localhost/").port(9998).build();
	ResourceConfig config = new ResourceConfig(MyResource.class);
	Server server = JettyHttpContainerFactory.createServer(baseUri, config);

需要的依赖

	<dependency>
		<groupId>org.eclipse.jetty</groupId>
		<artifactId>jetty-server</artifactId>
		<version>2.11</version>
	</dependency>



### 4.4. 基于 Servlet 的部署

#### 4.4.1. Servlet 2.x Container

* 作为 Servlet

```

	<web-app>
		<servlet>
			<servlet-name>MyApplication</servlet-name>
			<servlet-class>org.glassfish.jersey.servlet.ServletContainer</servlet-class>
			<init-param>
				...
			</init-param>
		</servlet>
		...
		<servlet-mapping>
			<servlet-name>MyApplication</servlet-name>
			<url-pattern>/myApp/*</url-pattern>
		</servlet-mapping>
		...
	</web-app>

```

* 作为 Servlet Filter

```

	<web-app>
		<filter>
			<filter-name>MyApplication</filter-name>
			<filter-class>org.glassfish.jersey.servlet.ServletContainer</filter-class>
			<init-param>
				...
			</init-param>
		</filter>
		...
		<filter-mapping>
			<filter-name>MyApplication</filter-name>
			<url-pattern>/myApp/*</url-pattern>
		</filter-mapping>
		...
	</web-app>

```

`<init-param>` 的内容可以如下定义.

1. 自定义 Application 子类

```

	<init-param>
		<param-name>javax.ws.rs.Application</param-name>
		<param-value>org.foo.MyApplication</param-value>
	</init-param>

```

2. 扫描Jersey包

```

	<init-param>
		<param-name>jersey.config.server.provider.packages</param-name>
		<param-value>
			org.foo.myresources,org.bar.otherresources
		</param-value>
	</init-param>
	<init-param>
		<param-name>jersey.config.server.provider.scanning.recursive</param-name>
		<param-value>false</param-value>
	</init-param>

```

3. 指定具体的 resource 和 provider 类

```

	<init-param>
		<param-name>jersey.config.server.provider.classnames</param-name>
		<param-value>
			org.foo.myresources.MyDogResource,
			org.bar.otherresources.MyCatResource
		</param-value>
	</init-param>

```

#### 4.4.2. Servlet 3.x Container

	// TODO 待整理

## 5. 表述与响应

### 5.1. 表述与 Java 类型

1. All media types (\*/\*)

	- byte[]

	- java.lang.String

	- java.io.Reader (inbound only)

	- java.io.File

	- javax.activation.DataSource

	- javax.ws.rs.core.StreamingOutput (outbound only)

2. XML media types (text/xml, application/xml and application/...+xml)

	- javax.xml.transform.Source

	- javax.xml.bind.JAXBElement

	- Application supplied JAXB classes (types annotated with @XmlRootElement or@XmlType)

3. Form content (application/x-www-form-urlencoded)

	- MultivaluedMap<String,String>

4. Plain text (text/plain)

	- java.lang.Boolean

	- java.lang.Character

	- java.lang.Number

### 5.2. 构造响应

可以通过 `Response` 和 `Response.ResponseBuilder` 来构造并返回响应的附加信息.

1. 返回 201 状态码

	@POST
	@Consumes("application/xml")
	public Response post(String content) {
	  URI createdUri = ...
	  create(content);
	  return Response.created(createdUri).build();
	}

2. 自定义天添加 Entity body 响应

	@POST
	@Consumes("application/xml")
	public Response post(String content) {
	  URI createdUri = ...
	  String createdContent = create(content);
	  return Response.created(createdUri).entity(Entity.text(createdContent)).build();
	}

### 5.3. WebApplicationException 和 响应的异常映射

JAX-RS 允许定义 Java 异常与 HTTP 错误响应的直接映射.

通过抛出 CustomNotFoundException 来向客户端返回一个错误的 HTTP 响应.

	@Path("items/{itemid}/")
	public Item getItem(@PathParam("itemid") String itemid) {
	  Item i = getItems().get(itemid);
	  if (i == null) {
		throw new CustomNotFoundException("Item, " + itemid + ", is not found");
	  }

	  return i;
	}

具体应用程序异常的实现

	public class CustomNotFoundException extends WebApplicationException {

	  /**
	  * Create a HTTP 404 (Not Found) exception.
	  */
	  public CustomNotFoundException() {
		super(Responses.notFound().build());
	  }

	  /**
	  * Create a HTTP 404 (Not Found) exception.
	  * @param message the String that is the entity of the 404 response.
	  */
	  public CustomNotFoundException(String message) {
		super(Response.status(Responses.NOT_FOUND).
		entity(message).type("text/plain").build());
	  }
	}

另一情况,最好通过自定义异常映射 provider 来映射一个已存在的异常.这个 provider 必须继承 ExceptionMapper<E extends Throwable> 接口.

	@Provider
	public class EntityNotFoundMapper implements ExceptionMapper<javax.persistence.EntityNotFoundException> {
	  public Response toResponse(javax.persistence.EntityNotFoundException ex) {
		return Response.status(404).
		  entity(ex.getMessage()).
		  type("text/plain").
		  build();
	  }
	}

若 Throwable 类是 WebApplicationException 的实例，并且 Response.hasEntity() 为真,将不执行 ExceptionMapper.toResponse 函数.

### 5.4. Conditional GETs 和 304 响应

	public SparklinesResource(
	  @QueryParam("d") IntegerList data,
	  @DefaultValue("0,100") @QueryParam("limits") Interval limits,
	  @Context Request request,
	  @Context UriInfo ui) {
	  if (data == null) {
		throw new WebApplicationException(400);
	  }

	  this.data = data;
	  this.limits = limits;

	  if (!limits.contains(data)) {
		throw new WebApplicationException(400);
	  }

	  this.tag = computeEntityTag(ui.getRequestUri());

	  if (request.getMethod().equals("GET")) {
		Response.ResponseBuilder rb = request.evaluatePreconditions(tag);
		if (rb != null) {
		  throw new WebApplicationException(rb.build());
		}
	  }
	}


## 15. 安全

### 15.1. SecurityContext


## 16. 对 WADL 的支持

默认情况下 jersey 是自动开启 WADL 的支持的.默认 `Path("application.wadl")`

要禁用 WADL ,请在应用中(web.xml 或 Application.getProperties())进行如下配置:

	jersey.config.server.wadl.disableWadl=true




## . MVC Templates

	// TODO 待整理

***

## 参考

[JAX-RS解析][lnkJaxRS]

[使用 Jersey 和 Apache Tomcat 构建 RESTful Web 服务][lnkJerseySample]


***

[lnkHome]: https://jersey.java.net/
[lnkDoc]: https://jersey.java.net/documentation/latest/index.html
[lnkJaxRS]: http://warm-breeze.iteye.com/blog/1578271
[lnkJerseySample]: https://www.ibm.com/developerworks/cn/web/wa-aj-tomcat/

