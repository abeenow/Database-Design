<%-- 
    Document   : index
    Created on : Mar 18, 2015, 2:26:06 PM
    Author     : Abinav
--%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
 
<html>
<head>
<title>SELECT Operation</title>
</head>
<body>
 
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/test"
     user="root"  password=""/>
 
<sql:query dataSource="${snapshot}" var="result">
SELECT a.id , a.id from Employees a;
</sql:query>
 
<table border="1" width="100%">
<tr>
   <th>Emp ID</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
   <td><c:out value="${row.result.getColumnNames()[0]}"/></td>
</tr>
</c:forEach>
</table>
 
</body>
</html>