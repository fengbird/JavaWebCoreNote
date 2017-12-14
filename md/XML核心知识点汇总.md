### 给初学者的建议

* XML这一章节,在教学内容中也对dtd以及schema两种格式的进行了讲解说明,在辅导过程中发现有学生把很多精力花在了研究这上面,不推荐过早的研究这块,因为在平常的学习及工作中通常都是直接写配置文件,很少会真正需要自己去定义一些dtd或者schema规则,而知识不学就会忘记,现在专研那么深,但是这块知识点更多的都是一些规范,需要去记忆的东西,等到过了几年当上架构师了,这些东西还是会遗忘,这块内容目前阶段了解即可.

### SaxReader解析XML文档★★★

SAX:是一种速度更快,更有效的方法.它逐行扫描文档,一边扫描一边解析.并以事件驱动的方式进行具体解析,每执行一行,都将触发对应的事件.

* 优点:处理速度快,可处理大文件.
* 缺点:只能读,逐行后将释放资源.

常用API:

1. SaxReader对象

   * read\(...\) 加载执行xml文档

2. Document对象

   * getRootElement\(\) 获得根元素

3. Element对象

   * elements\(...\)获得指定名称的所有子元素.可以不指定名称

   * element\(...\)获得指定名称第一个子元素.可以不指定名称

   * getName\(\) 获得当前元素的元素名

   * attributeValue\(...\)获得指定属性名的属性值

   * elementText\(...\)获得指定名称子元素的文本值

   * getText\(...\) 获得当前元素的文本内容

     ```java
     /**
      * 采用sax方式解析xml文件
      *
      * @author heima
      * @create 2017-12-07-16:17.
      */
     public class SaxDemo {
         @Test
         public void demo() throws DocumentException {
             //1 获得document
             SAXReader saxReader = new SAXReader();
             Document document = saxReader.read(new File("src/web.xml"));
             //2 获得根元素
             Element rootElement = document.getRootElement();
             //打印version属性值
             String version = rootElement.attributeValue("version");
             System.out.println(version);
             //3 获得所有子元素.
             List<Element> allChildElement = rootElement.elements();
             //4 遍历所有
             for (Element childElement : allChildElement) {
                 //5.1 打印元素名
                 String childName = childElement.getName();
                 System.out.println(childName);
                 //5.2 处理<Servlet>,并获得子标签的内容.例如:<servlet-name>等
                 if ("servlet".equals(childName)) {
                     //方式1:获得元素对象,然后获得文本.
                     Element servletNameElement = childElement.element("servlet-name");
                     String servletName = servletNameElement.getText();
                     System.out.println("\t"+servletName);
                     //方式2:获得元素文本值
                     String servletClass = childElement.elementText("servlet-class");
                     System.out.println("\t"+servletClass);
                 }
                 //5.3 处理<servlet-mapping>...
             }
         }
     }
     ```

     ​

### Xpath解析XML文档★★★

* 由上面的示例代码可以看出,直接使用SaxReader解析xml文件对于层次简单的节点获取还行,若是层次复杂的节点,在获取的时候就会异常复杂,Xpath解析可以通过规定的层级节点查询规则快速方便的查询相关节点对象.

* 注意:若想使用xpath的方式解析文档,除了需要导入`dom4j-1.6.1`之外,还需要导入`jaxen-1.1-beta-6.jar` 包才行.

* 使用案例代码如下:

  ```Java
      @Test
      public void demo1() throws DocumentException {
          SAXReader saxReader = new SAXReader();
          Document document = saxReader.read(new File("src/Book.xml"));
          //获取节点对象集合
          List<Element> list = document.selectNodes("/书架/书/书名");
          for (Element element : list) {
              System.out.println(element.getText());
          }
          //获取单个节点对象
          Node node = document.selectSingleNode("/书架/书/书名");
          System.out.println(node.getText());
      }
  ```

* xpath具体规范看此链接:[xpath规范](../XPathTutorial/General_chi/examples.html)



