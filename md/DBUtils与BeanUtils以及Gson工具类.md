## DBUtils

### 核心功能介绍

* QueryRunner中提供对SQL语句操作的API
* ResultSetHandler接口，用于定义select操作后，怎样封装结果集
* DBUtils类，它就是一个工具类，定义了关闭资源与事务处理的方法

### jar包

* 核心包：commons-dbutils-1.4.jar
* 依赖jar包：mysql-connector-java-5.0.8-bin.jar

### QueryRunner核心类

* 配置方案一：直接传入数据源，连接对象connection不由用户创建，由DBUtils底层自动维护连接connection对象
  * QueryRunner(DataSource ds)，提供数据源(连接池)，
  * update(String sql,Object... params)，执行更新数据(增删改)
  * query(String sql ,ResultSetHandler\<T> rsh,Object...  params)，执行查询(查)

* 配置方案二：在执行更新或查询时由用户手动指定connection连接对象

  * QueryRunner()，因为由用户手动指定连接对象，因此此处不需要提供数据源
  * update(Connection connection,String sql,Object...  params)，手动指定连接对象，更新数据(增删改)
  * query(Connection connection,String sql,ResultSetHandler\<T> rsh,Object...  params),手动指定连接对象，执行查询(查)

  **注意：当采用配置方案一的时候，由于connection对象由DBUtils全程维护，因此不需要用户自己手动关闭连接资源，DBUtils底层就内置了关流操作，但是当采用配置方案二时，因为connection连接对象由用户自己定义，因此关流操作交给用户自己决定，DBUtils不提供自动关流操作**

  ### ResultSetHandler结果集处理类

  | 实现类                 | 说明                                       |
  | ------------------- | ---------------------------------------- |
  | ArrayHandler        | 将结果集中的第一条记录封装到一个Object[]数组中，数组中的每一个元素就是这条记录中的每一个字段的值 |
  | ArrayListHandler    | 将结果集中的每一条记录都封装到一个Object[]数组中，将这些数组再封装到List集合中 |
  | **BeanHandler**     | 将结果集中第一条记录封装到一个指定的JavaBean中              |
  | **BeanListHandler** | 将结果集中每一条记录封装到指定的JavaBean中，将这些JavaBean再封装到List集合中 |
  | ColumnListHandler   | 将结果集中指定的列的字段值，封装到一个List集合中               |
  | KeyedHandler        | 将结果集中每一条记录封装到Map\<String,Object>,再将这个map集合作为另一个Map的value，另一个Map的集合的key是指定的字段的值 |
  | MapHandler          | 将结果集中第一条记录封装到了Map\<String,Object>集合中，key就是字段名称，value就是字段值 |
  | **ScalarHandler**   | 它用于单数据。例如select count(*) from 表操作        |

###其他常用方法

> 当用户传递的是自定义connection对象的时候，需要进行手动关流，DBUtils中也提供了几种关流的方法，具体如下

* `closeQuietly(Connection conn)` 关闭连接，如果有异常try后不抛
* `commitAndCloseQuietly(Connection conn)` 提交并关闭连接
* `rollbackAndCloseQuietly(Connection conn)` 回滚并关闭连接

### 示例代码

```java
public class StudentDao {
    public Student getStudent(String sname,String gender) throws SQLException {
        //当在QueryRunner中引入数据源后不需要手动关流
        QueryRunner queryRunner = new QueryRunner(new ComboPooledDataSource());
        String sql = "SELECT * FROM day13.stu WHERE sname=? AND gender=?";
        Student student = queryRunner.query(sql,new BeanHandler<Student>(Student.class),"ww","女");
        return student;
    }

    public void save(Student student) throws SQLException {
        QueryRunner queryRunner = new QueryRunner();
        String sql = "INSERT INTO day13.stu VALUES(NULL,?,?)";
        Connection connection = new ComboPooledDataSource().getConnection();
        //返回值，当添加一列成功返回1，添加失败返回0
        int update = queryRunner.update(connection, sql, "zs", "男");
        DbUtils.close(connection);
    }
}
```

## BeanUtils

### 核心功能介绍

* 主要用来将前端表单提交的数据封装到对应的JavaBean中。

### jar包依赖

* commons-beanutils-1.8.3.jar
* commons-logging-1.1.1.jar

### 常用方法

* `BeanUtils.populate(Object bean,Map<String,String[]> properties)`
  * 将Map数据封装到指定JavaBean中，一般用于将表单的所有数据封装到JavaBean中
  * 经常先通过`request.getParameterMap`获取map集合，再利用此方法将map中的数据对应着存储到提供好的bean对象中
  * 注意：若Map中的key在Object中找不到对应的，会造成数据存储丢失，若Object中存在的属性在Map中没有对应那么此属性值为null
* `ConverUtils.register(Converter converter,Class clazz)`
  * 注册类型转换器
  * 经常利用它来处理BeanUtils不能自动转换的情况，如一个对象中的birthday属性若为java.util.Date类型，那么前端对应日期数据过来后在默认情况下是无法自动转换的，需要借助ConverUtils进行手动转换

### 示例代码

```java
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  Map<String, String[]> properties = request.getParameterMap();
  User user = new User();
  //创建BeanUtils提供的时间转换器
  DateConverter dateConverter = new DateConverter();
  //设置需要转换的格式
  dateConverter.setPattern("yyyy-MM-dd");
  //注册转换器
  ConvertUtils.register(dateConverter,java.util.Date.class);
  //封装数据
  BeanUtils.populate(user,properties);
}
```

## Gson

### 核心功能介绍

* 提供对象或者集合与对应的JSON格式的字符串的相互转换

### jar包

* gson-2.5.jar

**注意：为什么此处不说json-lib的jar包而说Gson包呢？因为若是将含有java.util.Date类型的JavaBean转换为对应的JSON字符串的话会报异常，当然，json-lib有对应的解决方式，但是解决方式比较复杂，实用性不强，因此这里介绍了简单易用的Gson**

### 示例代码

```java
@Test
public void testGson_Object2String(){
//gson由对象转json字符串
Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
String json = gson.toJson(user);
System.out.println(json);
//gson由json字符串转对象
User user2 = gson.fromJson(json, User.class);
System.out.println(user2);
}
//gson 对json数组的处理
@Test
public void testGson_JsonArray(){
List<User> users = new ArrayList<>();
users.add(user);
Gson gson = new Gson();
String json = gson.toJson(users);
System.out.println(json);
List list = gson.fromJson(json,List.class);
System.out.println(list);
}
```

