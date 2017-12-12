### 给初学者的建议

* 不知道你有没有考虑过这个问题，为什么在浏览器里面输入一个链接就可以看到对应的页面？自己在页面内输入内容后点击提交按钮，页面就会有相应的变化？当你学过Servlet后就会有所了解。
* 在发送数据时，我们通常将浏览器称为客户端，通过链接访问的地址称为服务器端，Java是通过Socket以及ServletSocket对象按照HTTP协议来控制数据的发送与接收的，但是，发送以及接收的数据都是流数据，需要对其进行各种解析后才能获取到各种有价值的信息，于是JDK就又发明了HttpServlet来应对这一问题。对Socket进一步封装，将解析流的方法全部实现好，这样子用户要发送数据或者接收数据的时候直接调用HttpServlet里面的方法就可以进行了，而且也可直接采用HttpServlet里面定义好的方法来解析数据。
* 上面两点扯了那么多，不管你有没有看懂，你都应该明白：Servlet的相关技术对于JavaWeb开发者来说是基础、是核心，基本原理必须要清楚。而且Servlet是JavaWeb三大组件之一(Servlet、Filter、Listener)，且最为重要。

### Servlet之层次浅析★★★

> Servlet的整个继承实现体系比较复杂，这里只对Servlet的体系结构中比较重要几个接口及抽象类做简要介绍。

#### Servlet接口

* 全名:Server Applet,意为服务器上运行的小程序.它只是定义了一个小程序的接口,若是想要做任何需要该接口提供支持的类只需要重新实现即可,它本身与Http数据传输没有关系。

#### GenericServlet抽象类

* 实现了Servlet的接口,并且又扩充了打印日志及获取当前ServletName名字的方法,但是它并未对Service()方法进行具体的实现.若是想要使用其中的其它方法并且自己写实现的话可以继承该类.它里面实现的方法主要用来获取一些与Servlet配置相关的参数.

#### HttpServlet抽象类

* 继承了GenericServlet,实现了具体的service()方法,并且根据Http协议定义了获取及响应用户请求的一系列方法,真正的在使用服务器与客户端进行数据的传输时使用的是它.除了它自己扩展的一些方法外,其他的方法全部继承自其父类的方法,并没有加以重写.

#### 综合

* 由上面的介绍可知，我们想要获取客户发送过来的数据，并对其进行响应，主要用到的还是HttpServlet抽象类及其下的具体实现类的逻辑方法。

### 根据URL找到并实例化Servlet的流程★★★★★

> 带每一期学员的时候都会重点强调这个流程，但是班里面老是会有很大一部分人根本不在乎，一旦自己遇到程序报错直接束手无策，没有一点解决问题的思路，虽然这个思路也说了很多遍。。。无奈

当在浏览器中输入http://localhost:8080/Project/test 之后，当请求到达服务器之后如何能确保实例化服务器内的TestServlet呢？

```xml
web.xml配置文件：

<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" id="WebApp_ID" version="2.5">
 <display-name>ServletTest</display-name>
 <servlet>
  	<servlet-name>TestServlet</servlet-name>
  	<servlet-class>com.itheima.servlet.TestServlet</servlet-class>
 </servlet>
 <servlet-mapping>
  	<servlet-name>TestServlet</servlet-name>
  	<url-pattern>/test</url-pattern>
  </servlet-mapping>
</web-app>
```



1. 首先根据主机名：localhost找到对应的服务器地址，再根据8080端口号找到服务器对应端口映射出的程序，再根据Project找到当前服务器下对应的project应用，最后根据/test到应用中的web.xml中去匹配
2. 根据/test到应用中的web.xml中去找寻存在`<servlet-mapping><servlet-mapping>`标签，其内的子标签 `<url-pattern><url-pattern>` 中是否有包含/test
3. 若找到对应的`<servlet-mapping></servlet-mapping>` 标签，接下来会根据其子标签`<servlet-name></servlet-name>` 标签里的内容(此处是TestServlet) 去找寻是否存在一个`<servlet>`标签，其内部`<servlet-name>` 标签里的内容也为相同的内容(TestServlet)
4. 若找到对应的`<servlet>`标签后，会根据其子标签`<servlet-class>` 里面的内容实例化该类对象并执行它的init() 方法以及service()方法。

**注意：1.一个url-pattern标签里的内容只能映射到一个servlet-class，若映射了多个，项目启动就会报错：The servlets named [TestServlet] and [TestServlet1] are both mapped to the url-pattern [/test] which is not permitted  提示两个Servlet类都映射到了同一个url-pattern是不被允许的。  2. 一定要注意，url-pattern中配置路径的话，一定要以"/"开头，假如配置的时候忘加"/"，会直接导致项目启动报错，且整个项目都启动不起来，报错信息通常是这样的：A child container failed during start** 

> 为什么要这么的重点强调这个根据url找对应的Servlet的流程呢？原因就是因为在编程中特别容易遇到404报错(找不到资源)，很多初学者遇到这种问题完全的毫无头绪，不知道怎么去分析，更有甚者一直卡在这个地方好久，当要通过一个url去找对应的Servlet并执行，首先就应该看控制台是否有报错信息，若是项目启动时期报错，是很有可能导致服务器完全无法加载此项目资源的，项目启动时期的报错有极大的可能是我上面说的那些情况造成的，若项目启动时期未报错，然后就应该根据上面所说的流程，一步一步的查找对应关系是否有问题。唉，我觉得有些初学者身上存在的最大问题就是自己不知道，还不愿意听别人的意见，无知者无畏啊。。。

### Servlet的生命周期★★★★★

1. 第一次调用时，将执行初始化方法：init(ServletConfig)  (一定一定要注意，是第一次调用的时候Servlet对象才会实例化并且只执行一次init()方法并不是在服务器启动的时候就实例化！！！)。
2. 每一次调用，都将执行service(ServletReqeust req,ServletResponse resp) 方法。
3. 服务器关闭，或项目移除：执行destory()方法(也就是说，若是项目一直正常运行，那么Servlet实例就一直存在于服务器中！！！)

Servlet生命周期：Servlet从创建到销毁的过程。

* 何时创建：用户**第一次**访问Servlet创建Servlet的实例。
* 何时销毁：当项目从服务器中移除的时候，或者关闭服务器的时候。
* 详细讲解：用户第一次访问Servlet的时候，服务器会创建一个Servlet的实例，那么Servlet中init方法就会执行，任何一次请求服务器都会创建一个新的线程访问Servlet中的service的方法，在service方法内部根据请求的方式的不同调用doXxx的方法(get请求调用doGet,post请求调用doPost)。当Servlet从服务器中移除掉，或者关闭服务器，Servlet的实例就会被销毁，那么destroy方法就会执行。

### Servlet的线程安全问题★★★

从上面的讲解我们就可以注意到，Servlet只在第一次访问的时候被创建一次，也就是说以后无论访问多少次同一个Servlet，都是用的同一个Servlet对象，更专业点来说，Servlet是一个单例。然后我们又知道，每次请求过来的时候都会开一个新线程来去访问对应的Servlet对象，也就是说这里是单实例多线程的，单实例多线程必定会存在线程安全问题，因此可以说Servlet不是线程安全的。但是，Servlet不是线程安全，为什么从来没出现过问题呢？

* 关键是一定要明白线程安全问题出现的时机，很多情况下都是因为多个线程对同一个对象中的共享数据进行操作才会出现这种问题，在一个类中的共享数据通常表现为成员变量，若是在一个Servlet中存在成员变量并且还有其他方法对该成员变量进行操作的话，那么Servlet就会出现线程安全问题，但是，我们可以看到无论是HttpServlet还是其子类，均没有方法去调用成员变量，Servlet在用的时候也是直接调用的方法，而每个线程在进入方法时都会在栈上开辟一块新的空间，执行完毕后弹栈，根本不牵涉到共享数据的问题，所以Servlet虽然是单实例多线程的，但是不会出现线程安全问题。

### ServletConfig★★★

作用：当实例化一个Servlet时，容器(Tomcat)就会自动创建一个与Servlet实例对应的ServletConfig对象。可以通过该对象获取与当前Servlet相关的配置信息。

* 我们在配置Servlet时，想要给Servlet绑定一个初始化参数，为了便于该Servlet进行调用，该怎么办呢？我们无法直接将该参数赋值给Servlet的一个成员变量，因为上文提到过，这样子会出现线程安全问题，那么我们应该将该初始化参数放在哪里呢？

  * 答案是可以放在web.xml中与Servlet类对应的`<servlet>` 标签下，` <init-param>`标签内如下：

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" id="WebApp_ID" version="2.5">
      <display-name>ServletTest</display-name>
      <servlet>
        <description></description>
        <display-name>DemoServlet</display-name>
        <servlet-name>DemoServlet</servlet-name>
        <servlet-class>com.itheima.servlet.DemoServlet</servlet-class>
        <init-param>
          <param-name>username</param-name>
          <param-value>zs</param-value>
        </init-param>
        <init-param>
          <param-name>password</param-name>
          <param-value>123</param-value>
        </init-param>
      </servlet>
      <servlet-mapping>
        <servlet-name>DemoServlet</servlet-name>
        <url-pattern>/demo</url-pattern>
      </servlet-mapping>
    </web-app>
    ```

  * 然后就可以在对应的Servet类中，通过ServletConfig来获取参数了。如下代码：

    ```java
    public class DemoServlet extends HttpServlet {
    	private static final long serialVersionUID = 1L;
    	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    		//获取ServletConfig的一个实例对象
    		ServletConfig servletConfig = this.getServletConfig();
    		//通过getInitParameterNames方法获取所有的初始参数的名称(key)
    		Enumeration<String> parameterNames = servletConfig.getInitParameterNames();
    		//遍历获取其中的每一个初始参数的名称
    		while(parameterNames.hasMoreElements()){
    			String key = parameterNames.nextElement();
    			//根据已知的初始参数key获取其对应的value值
    			String value = servletConfig.getInitParameter(key);
    			System.out.println("初始参数的key值为："+key+",其对应的value值为："+value);
    		}
    	}

    	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    		doGet(request, response);
    	}

    }
    ```

### ServletContext★★★

> 服务器启动的时候，为每个WEB应用创建一个单独的ServletContext对象。一个WEB有且仅有一个ServletContext对象，在该应用中无论哪个Servlet通过调用`getServletContext()`方法获取ServletContext对象时均获取的是同一个对象。

#### 初始化参数的获取

上文讲ServletConfig时，讲到初始化参数的获取，只能在对应的Servlet下获取到对应的初始化参数，但是若是多个Servlet都要用到同样的初始化参数的时候要怎么办呢？

* 这时候就应该用ServletContext来处理了，首先，需要在web.xml配置文件中配置一个`<context-param>`标签，然后将初始化参数的键值对放入其中，如下：

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" id="WebApp_ID" version="2.5">
    <display-name>ServletTest</display-name>
    <context-param>
    	<param-name>username</param-name>
    	<param-value>zs</param-value>
    </context-param>
    <context-param>
    	<param-name>password</param-name>
    	<param-value>123</param-value>
    </context-param>
    <servlet>
      <description></description>
      <display-name>DemoServlet</display-name>
      <servlet-name>DemoServlet</servlet-name>
      <servlet-class>com.itheima.servlet.DemoServlet</servlet-class>
    </servlet>
    <servlet-mapping>
      <servlet-name>DemoServlet</servlet-name>
      <url-pattern>/demo</url-pattern>
    </servlet-mapping>
  </web-app>
  ```

* 然后就可以在Servlet类中，通过ServletContext来获取参数了，如下代码(获取参数的过程和ServletConfig相似度极高)：

  ```java
  //获取ServletContext对象
  		ServletContext servletContext = this.getServletContext();
  		//通过getInitParameterNames方法获取所有的初始参数的名称(key)
  		Enumeration<String> names = servletContext.getInitParameterNames();
  		//遍历获取其中的每一个初始参数的名称
  		while(names.hasMoreElements()){
  			String key = parameterNames.nextElement();
  			//根据已知的初始参数key获取其对应的value值
  			String value = servletContext.getInitParameter(key);
  			System.out.println("ServletContext的初始参数的key值为："+key+",其对应的value值为："+value);
  		}
  ```

#### ServletContext的域对象属性

> 除了上文ServletContext可以取出初始化参数供所有的Servlet使用外，ServletContext的还可以在程序运行过程中，供所有的Servlet动态的存取数据。

* 域对象是什么意思？域，是共享域的意思，指定数据的共享范围。

* ServletContext作为域对象，存入它里面的数据的共享范围为整个web应用，也就是说在当前web应用中，所有的Servlet都可以往其中存入、获取数据。这些数据在Servlet之间共享。(也就是AServlet往ServletContext域里面存入数据后可以通过BServlet直接获取到)。

* 那么ServletContext如何存取数据呢？请看代码：

  ```java
  //获取ServletContext对象
  ServletContext servletContext = this.getServletContext();
  //存入数据
  servletContext.setAttribute("username", "zs");
  //取出数据
  servletContext.getAttribute("username");
  //移除数据
  servletContext.removeAttribute("username");
  ```

  ​