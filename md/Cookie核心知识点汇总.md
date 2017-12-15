### 给初学者的建议

> Cookie属于较难理解的知识点，如果只是记住怎么去调用方法，但是不知道服务器处理cookie的大概原理，那么在使用时很容易遇到问题，因此这一章节理清其原理是至关重要的。

### 常用方法★★★★★

* 构造器，常用于创建Cookie对象
  * Cookie（String name,String value)
    * 用一个指定的name和value去构造一个cookie实例对象。
* String getName()
  * 返回cookie对象的名称
* String getValue()
  * 返回Cookie对象的值
* void setMaxAge(int expiry)
  * 设置cookie的最大生命周期(单位为秒)
* void setPath(String uri)
  * 指定客户端应该在返回cookie时的cookie的路径
* cookie的创建(附带对中文进行编码):

```java
String username = us.getUsername();
Cookie cookie = new Cookie("username", URLEncoder.encode(username, "UTF-8") );//对中文进行转码
cookie.setPath("/");
cookie.setMaxAge(Integer.MAX_VALUE);
response.addCookie(cookie);
```

* cookie的获取(对中文进行解码):

```java
Cookie[] cookies = Request.getCookies();
if(cookies!=null){
	for (Cookie cookie : cookies) {
		if("username".equals(cookie.getName())){
			username = URLDecoder.decode(cookie.getValue(), "UTF-8");
			checked = "checked";
		}
	}
}
```
### Cookie从创建到死亡的过程★★★★★

1. 浏览器发出请求

2. 服务器接收请求,创建request对象和Response对象,并把请求中的内容设置到request属性中.(一次会话的开始)

3. 将request对象与Response对象传给对应的servlet

4. 在servlet内部创建一个cookie对象并给其设置name与value及其最大生命值和其在浏览器缓存文件中的虚拟路径

5. 调用response的addCookie(cookie)方法将cookie放入response对象中

6. response响应回页面,在响应头中设置Set-Cookie: test3=test3 响应头,浏览器接收到后就会对其进行解释操作进而生成一个对应的缓存文件存储在硬盘上.

7. 当该浏览器再次向服务器发出请求时,服务器就会将其根目录及相关web应用下面的cookie全部放到request对象里,传至对应的servlet.**注意，在从浏览器将cookie传回服务器时，仅仅传回了cookie的name及value值，它的最大生命周期maxAge，路径Path属性均未带回**

8. servlet若需要用到cookie,需要调用request.getCookies()方法获取所有的cookie,再遍历配合cookie.getName()和cookie.getValue()方法获取cookie中的属性.

9. 若是cookie的maxAge()及setPath()均未设置,那么将采用默认值,maxAge()默认值为-1,代表着若浏览器关闭,那么就会自动清理该cookie的缓存数据.也就是说该cookie只存在于一次会话中.setPath()若是采用默认值,那么该cookie在浏览器中生成的对应的缓存文件中的虚拟路径就是当前服务器下当前web应用的路径,那么当前服务器下其他的web应用就获取不到这个cookie    若是设置maxAge()中的值为0,当服务器响应给浏览器后就会直接干掉对应的cookie.若是设置maxAge()中的值为正数比如为60,那么一分钟后就会干掉该cookie.若是setPath("/"),在浏览器生成的该cookie的对应缓存文件中,就会将里面的虚拟路径设置为当前服务器的路径.若是该服务器下面有多个web应用,那么其他的web应用也将能够获取该cookie.

   * 举例:

     当前服务器地址:localhost:8080

     当前web应用:test1

     若setPath为默认,那么缓存文件中存储的虚拟路径就为localhost:8080/test1

     若setPath("/"),那么缓存文件中存储的虚拟路径就为localhost:8080/

     若存在session的话，那么session的默认路径为localhost:8080/test1/

