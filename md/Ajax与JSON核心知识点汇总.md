### 给初学者的建议

> 对于Ajax技术，初学者总是会觉得它比较难，完全独立着很难迅速的写出来，造成这种问题的原因有两个：一是对ajax中方法内的各个参数代表什么意思理解不清楚，二是写的少。学到这里时可以多尝试几种状况，以自己的方式摸索每个参数到底可以起到什么作用。另外可以学一段新知识后有时间可以经常复习，多敲下。对于JSON，最重要的还是要明白JSON到底包括哪些格式。这点是JSON中的重中之重，毕竟在工作中，有很多时候，自己写的代码是要按照JSON格式的要求来实现的。

## JSON

* JSON建构于两种结构：
  * “名称/值” 对的集合。
  * 值的有序列表。在大部分语言中，它被理解为数组。
* JSON对象
  * 对象是一个无序的“ ‘名称/值’ ”对集合。一个对象以"{" 开始，"}"结束。每个“名称” 后跟 一个“:” ; “ ‘名称/值’ ”对之间使用","分隔
  * 例如：` {string:value,string:value,string:value,...}` 。
* JSON数组
  * 数组是值的有序集合。一个数组以"[" 开始，"]" 结束。值之间使用","分隔。
  * 值可以是双引号括起来的字符串、数值、true、false、null、对象或者数组。这些结构可以嵌套。
  * 例如：` [1,2,3,4]` 、 ` ["aa","cc","bb"]` 、` [true,"tt",8,"bb"]` 、`[{"username":"zs","password":123},{"username":"ls"}]` 。

**注意：初学者最容易出现的问题：认为JSON数组只有**`[{"username":"zs","password":123},{"username":"ls"}]`  **一种状况,一定要注意这点，中括号中不止有对象，还有其他很多种状况的。**

## Ajax

### 常用格式

> "[]"中的参数代表该参数可写可不写。

#### $.get(url,[data],[fn],[type])

* 参数解释(来自jQuery的api文档)
  * url:待载入页面的URL地址
  * data:待发送Key/value参数
  * callback:载入成功时回调函数
  * type：返回内容格式，xml，html，script, json, text, _default


* 以GET携带着请求数据发出请求，再按照type规定的类型对服务器传回的数据进行转换，若转换失败则不会进入回调函数。

* 示例代码：

  ```javascript
  $.get("/servlet","username=zs&age=23",function(data){
    console.log(data);
  },"JSON");
  ```

* 注意事项：url,data,fn,type的顺序是固定的，必须在正确的位置填入正确的参数。

* 其他：还有一个方法叫做`$.getJSON(url,[data],[callback])` 就等效于当$.get的type为JSON时的情况。

#### $.post(url,data,callback,type)

* 参数解释

  * url:发送请求地址
  * data:待发送Key/value参数
  * callback:发送成功时回调函数
  * type:返回内容格式，xml，html,script,json,text,_default

* 以POST携带着请求数据发出请求，再按照type规定的类型对服务器传回的数据进行转换，若转换失败则不会进入回调函数。

* 示例代码：

  ```javascript
  $.post("/servlet1","username=zs&age=23",function(data){
  	console.log(data)
  },"JSON");

  ```

* 注意事项：url,data,fn,type的顺序是固定的，必须在正确的位置填入正确的参数。

#### $.ajax(url,[settings])

* 参数解释
  * url：一个包含发送请求的URL字符串

  * settings:AJAX请求设置。所有选项都是可选的(下面只列举常用属性，全部属性请查看API文档)
    * data：发送到服务的数据。将自动转换为请求字符串格式。
    * dataType:预期服务器返回的数据类型。如果不指定，jQuery将自动根据HTTP包MIME信息来智能判断，比如XML MIME类型就被识别为XML。
    * success(data,textStatus,jqXHR)：请求成功后的回调函数。
    * type：(默认：“GET")请求方式(”POST"或"GET")，默认为"GET"，注意：其他HTTP请求方法，如PUT和DELETE也可以使用，但仅部分浏览器支持
    * async：(默认：true)默认设置下，所有请求均为异步请求，如果需要发送同步请求，请将此选项设置为false。注意，同步请求将锁住浏览器，用户其他操作必须等待请求完成后才可以执行。

  * 示例代码：

    ```JavaScript
    $.ajax({
    	url:"/servlet1",
    	type:"GET"(或者"POST"),
    	data:"name=aa&age=23",
    	dataType:"JSON",  (或不写，默认"text")
    	success:function(data){
    	}
    })

    ```

  * 注意：ajax中，在此处，url，type，data等等他们是无序的，可以任意调换他们的位置。

### 难点理解

#### ajax异步代码执行的流程

> 执行流程中最难理解的两个点我觉得无外乎就是异步体现在哪里、回调函数如何理解了，这两点直到我到了黑马之后才真正的理解清楚，之前工作的时候也仅仅知道如何去用，但是始终对它不理解。

* 请看如下代码，分析浏览器弹窗最后弹出的数据是什么

  ```html
  --test.json文件内容
  {
    "username":"zs",
    "password":123
  }

  --ajax_test.html文件内容
  <!DOCTYPE html>
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <title>Ajax异步与同步测试</title>
      <script src="../jquery-1.11.3.js" type="text/javascript"></script>
      <script>
          $(function () {
              var a = "aaa";
              $.ajax({
                	url:'test.json',
                  dataType:'JSON',
                  type:'GET',
                  async:true,//异步执行，当为false时，同步执行
                  success:function (data) {
                      a = data.username;
                  }
              });
            alert(a);
          })
      </script>
  </head>
  <body>
  </body>
  </html>
  ```

* 代码分析，程序流从上往下走，走到js代码后执行文档加载事件，加载文档，文档加载完毕后进入事件函数中，执行js代码，首先给变量a赋初始值`"aaa"` ，接着执行`$.ajax() ` 方法，根据ajax中定义的参数发送请求，**注意，关键点来了：** 发出请求时，会根据参数async的对应参数决定下面的程序走向，当为true也就是异步执行时，**程序在发出请求后不管服务器有没有给浏览器返回数据就接着执行下面的代码** ，体现在本程序中也就是不管程序有没有走success回调函数都会接着执行$.ajax()函数下面的代码，又因为程序从发出一个请求到服务器做出反应的时间较慢，所以通常都是当js代码全部执行完毕后才接收到服务器响应，然后进入成功的回调函数(success)，这一步又该如何理解呢？浏览器向服务器发出请求，服务器接收到请求后通过response.getWriter().write()的方式向浏览器写回数据，若响应成功就会进入success回调函数中，按照dataType指定的类型，封装到回调函数的data参数中，若返回的数据不符合dataType指定的类型，将无法封装到data参数中(例如dataType指定类型为'JSON'，若返回的数据格式不符合要求就无法进入成功的回调函数)。因此，在默认异步(async:true)的情况下，上面的程序会先执行alert(a)，之后才走成功的回调函数，因此浏览器弹窗中a的值应该仍然为"aaa".

* 如果我将上面代码中的async:true改为async:false，又会出现什么状况呢？ 更改之后就等于是同步执行了，程序走到ajax后，向服务器发出请求，然后程序会停在这里知道服务器响应回来，接着走成功的回调函数，ajax代码块中的逻辑完全执行完毕后才会接着往下走，因为在成功的回调函数中对a重新赋值为"zs"，因此当浏览器弹窗的时候a的值也会对应着变为zs。