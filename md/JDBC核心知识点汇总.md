### 给初学者的建议

* 先说下JavaWeb后台服务器,JavaWeb后台服务器主要做的事情其实就是从用户那里接收到数据,然后按照需求,经过一系列逻辑处理存储将数据存储到数据库,或者是按照需求从数据库中取出数据并进行处理后展示到前台页面.由此可见采用Java语言做到与数据库之间的交互是非常重要的,而JDBC是Java为了操作数据库定义的一套规范.就包括之后要学的Hibernate框架以及Mybatis框架都是在JDBC的基础上再次进行封装的,可以说要想通过Java去操作数据库,必须用到JDBC规范,因此理解并掌握JDBC相关知识是至关重要的.

### JDBC开发步骤★★★★★

> JDBC开发步骤必须牢记!!!

1. 注册驱动
2. 获得连接
3. 获取执行SQL语句的对象
4. 执行SQL语句
5. 处理结果
6. 释放资源

**注意:注册驱动这块即` Class.forName("com.mysql.jdbc.Driver")`在MySQL驱动jar包驱动版本为5.1以上后也是可以省略的,但是jar包版本为5.0及其以下必须要手动声明,因此为了更好的兼容性,建议在开发过程中还是将` Class.forName("com.mysql.jdbc.Driver")` 加上.**

```java
代码实现:
package com.itheima;
import java.sql.*;
public class Jdbc_Base {
    public static void main(String[] args) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            //1.注册驱动
            Class.forName("com.mysql.jdbc.Driver");
            //2.获取连接
            String url = "jdbc:mysql://localhost:3306/test1";
            String username = "root";
            String password = "123";
            connection = DriverManager.getConnection(url, username, password);
          	System.out.println("Connection接口在此处的实际实现类为:"+connection.getClass().getName());
            //3.获取执行SQL语句的对象
            String sql = "SELECT * FROM user";
            statement = connection.prepareStatement(sql);
            //4.执行SQL语句
            resultSet = statement.executeQuery();
            //5.处理结果
            while (resultSet.next()) {
                Object username1 = resultSet.getObject("username");
                Object password1 = resultSet.getObject("password");
                System.out.println(username1+":"+password1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            //6.关闭资源
            try {
                resultSet.close();
                statement.close();
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
```

### Connection接口★★★

* 思考:在上面的代码中` DriverManager.getConnection()` 的返回值是用` java.sql.Connection`这个接口接收的,因此此处肯定用到了多态,可以确定返回的对象肯定是实现了Connection接口的,那么这个返回的对象到底是谁呢?
  * 答:若你不清楚,可以将上述代码复制一份到开发工具中进行运行,然后控制台会输出如下一句话:` Connection接口在此处的实际实现类为:com.mysql.jdbc.JDBC4Connection` 查看代码不难发现这句话得输出是` System.out.println("Connection接口在此处的实际实现类为:"+connection.getClass().getName());` 控制的,由此可以看出Connection接口的实际实现类为` com.mysql.jdbc.JDBC4Connection` 根据类的全限定类名可以看出该类是在MySQL的驱动包中实现的.
* 接着上面的思考题接着思考:` java.sql.Connection connection = DriverManager.getConnection()` 接收返回值的时候并不是采用一个实际类的类型进行接收的,而是采用接口进行接收的,这样子做有什么意义或者好处呢?
  * 答:请你思考这样一个场景,公司一开始做项目的时候是把数据存储在了MySQL数据库中,但是后来由于业务需要,要将数据迁移到Oracle数据库中,MySQL数据库弃置,那么,若是在此处开发的时候若是采用一个具体实现类来接收`DriverManager.getConnection()` 返回的对象的话,由于这个实际类存在于mysql-connector-java-bin.jar包中,开发者肯定要在当前类里导入该包,现在业务变更,那么开发者不得不重新重新打开当前页面重新进行导包操作....
* 综合思考: JAVA中定义JDBC接口规范的重要性及其意义到底在哪里?
  * 若Java没有定义一套JDBC接口规范,那么诸如Oracle,MySQL,SQLserver等等数据库厂商在提供操作数据驱动的时候由于没有一个官方的统一文档,它们就会按照自己的想法去定义类名,定义方法名,定义它们自己的一套实现逻辑....当开发人员要进行数据库操作的时候,不得不记忆好几套开发逻辑,好多种方法....若是项目后期要进行数据库的更改,由于各个数据库厂商所定义的方法名都不相同,开发人员便不得不大段大段的修改代码...有了JDBC接口规范后,所有的数据库厂商全部实现接口规范,按照一套开发逻辑走,只要在实现具体功能的时候提供自家的方案就可以了,对于开发人员来讲,不用管每个数据库厂商是如何实现` getConnection()`方法,如何实现` connection.prepareStatement(sql);` 的,只需要按照JDBC的规范就可以很方便的操作多种数据库了.深入想下就会发现:多态这个特性在Java语言中是多么的重要~

### ResultSet接口★

* 思考: ` resultset.next()` 的意义?
  * 答:通过jdbc操作获取结果集resultset后，可以认为结果集即为一个数据表，对结果集进行操作，可以认为结果集中存在一个“虚拟指针”，虚拟指针起初停在数据库的第0行。此行是一个特殊行，没有数据（），当执行一次rs.next()方法，指针就会往下移动一行，当遍历完所有行后rs.next()就会返回false。
* 思考:通过resultset结果集可以获取查询的数据的每一列的列名吗?可以获取查询出数据的总条数吗?如果能,应该怎么获取
  * 答:是可以获取的,通过`resultset.getMetaData()`来获取,`getMetaData` 方法可以获取结果集对象列的个数,类型,参数. `metaData.getColumnCount() ` 获取总列数,`metaData.getColumnName(int column)` 获取列名,`metaData.getColumnType(int column)` 获取每列字段的类型.

### JDBC事务★★★

* 确保多个对数据库的操作(比如对数据库增加一条数据,对数据库删除一条数据)在同一个事务中可以同时提交,同时回滚的注意事项
  * 必须保证多个操作用的是同一个connection对象.
  * 必须要开启事务` connection.setAutoCommit(false)` .
* JDBC进行事务操作的主要方法
  * 开启事务` connection.setAutoCommit(false)`
  * 提交事务` connection.commit()`
  * 回滚事务` connection.rollback()`
* 提问:为什么要保证多个操作使用同一个connection对象?
  * 答:我们都知道,使用Navicat或者sqlyog(小海豚)都可以对数据库进行操作,那么Navicat或者sqlyog是什么呢?它们都是连接数据库的客户端,我们在打开这些客户端后需要输入用户名和密码,如果正确就可以连接成功并且进行数据的查询了,现在,类比于Java,我们每打开一个客户端,就等于与数据库建立了一个连接,也就等于在Java中获取了一个connection对象.也就是说一个connection对象就相当于打开了一个客户端然后和数据库建立了一条连接.现在,试想一下,若是你打开了一个sqlyog,然后开启事务,再然后插入一条数据,现在你再打开一个Navicat,然后开启事务,再然后删除一条数据,这时候,当你在sqlyog中提交事务后,Navicat中的数据会同步提交吗?答案是不会的,不相信的话,自己尝试下~~