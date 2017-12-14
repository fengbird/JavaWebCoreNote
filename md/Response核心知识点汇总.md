### 给初学者的建议

* Response响应对象是JAVA用于处理HTTP响应信息的一个最重要的对象，它与Servlet、Request、Session、Cookie等技术组成JavaWeb核心阶段最最重要的一环，初学者必须在这些技术上下功夫，知道这些技术的核心API及其核心工作原理，以便为之后框架的学习打下扎实的基础。

### HttpServletResponse

> 在Servet API中，定义了一个HttpServletResponse接口，它继承自ServletResponse接口，专门用来封装HTTP响应消息。由于HTTP响应消息分为状态行、响应消息头、消息体三部分，因此，在HttpServletResponse接口中定义了向客户端发送响应状态吗、响应消息头、响应消息体的方法。该对象将HTTP响应消息在服务器端全部封装好后，当需要往浏览器端进行响应时就会解析该响应对象，将响应数据从中全部输出到浏览器端。

#### JavaWeb核心阶段最常用的方法★★★★★

> 在这里我将与Response相关的最常用的方法总结到一处，对这些方法进行详细的讲解，初学者必须要掌握并理解这些方法。

##### response.sendRedirect(String url)重定向

* 作用：当请求从客户端到达服务器后，服务器设置了重定向程序，那么服务器就会先响应回浏览器，然后更改浏览器的地址栏为sendRedirect(url)中设置的url，再次由服务器发出请求。
* `String url` 的理解：设置重定向的路径，当路径为相对路径时，比如`jsp/index.jsp`，注意"相对"指的是相对于谁，相对指的是相对于当前Servlet所处的层级路径，假如说当前Servlet的层级路径为`localhost:8080/项目名/ttt/test` 那么重定向后浏览器再次发送的请求就为` localhost:8080/项目名/ttt/jsp/index.jsp` ； 当路径设置为绝对路径时（以"/"开头的路径就叫绝对路径），比如`/jsp/index.jsp`, 注意"绝对"的概念,绝对是以当前服务器为根本进行路径拼接的，当前服务器就为` localhost:8080`  ,那么重定向后浏览器再次发送的请求路径就为` localhost:8080/jsp/index.jsp` 。这时候就会造成项目名的丢失，因此进行绝对路径拼接时，不要忘记从项目名开始拼接。

##### response.setContentType("text/html;charset=utf-8")

* 该方法主要用于设置Servlet输出内容的MIME类型，即"text/html"这一块，若响应内容为文本，可以在这里面追加字符编码，即"text/html;charset=utf-8"，通常用此方法指定服务器输出内容时使用的字符编码及浏览器解析输出内容时使用的字符编码，这句话就可以指定服务器以"UTF-8"的方式对输出内容进行编码，再指定浏览器以"UTF-8"的方式进行解码。以此保证编解码一致，杜绝响应回数据的乱码问题。

##### response.getWriter()

* 该方法所获取的字符输出流对象为PrintWriter类型。由于PrinWriter类型对象可以直接输出字符文本内容，因此，要想输出内容全为字符文本的网页文档，需要使用getWriter()方法。
* `getWriter().write()` ：当写出类型为字符串时，程序会报空指针异常
* ` getWriter().print()`  : 当写出类型为字符串时，程序会先检查是否为null，若为null，则将其转为"null"字符串，接着调用write()方法。(推荐使用此方法)
* ` getWriter().println()`  ：在输出指定内容后，会自动在内容后添加"\r\n"，比如输出内容为"hello world" 那么在输出到前台就会变为"hello world\r\n"。

##### response.addCookie(cookie)

* 该方法可以将在服务器端设置好的cookie对象添加到response对象中，然后带回浏览器对浏览器进行cookie的存入，若是只是在服务器端创建cookie对象，但是不将其添加到response对象带回浏览器的话，那么cookie对象就不会又任何的用处，毕竟cookie是存在于浏览器端的。

#### 其他地方还有涉及的方法★★★

> 这些方法属于不经常用到，但是需要熟悉的方法。

##### response.setHeader("key","value")

* 这个方法用于设置响应回浏览器的响应头，例如，在进行文件下载时，可以通过设置` response.setHeader("Content-Disposition","attachment;filename=aaa.txt")` 来设置响应头Content-Dispostion的值为attachment（附件）实现将文本文档通过附件的方式下载下来。

##### response.setCharacterEncoding("utf-8")

* 这个方法只能对于服务器输出内容编码进行指定，但是无法对浏览器接收到数据后进行解码的方式进行指定。