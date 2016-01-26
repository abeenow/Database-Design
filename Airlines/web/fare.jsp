<%-- 
    Document   : Fare
    Created on : Mar 29, 2015, 3:42:39 PM
    Author     : abinav
--%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="table.css" type="text/css">
        <title>Fare Details</title>
    </head>
    <%
        if (request.getParameter("flightno") == null) {
    %>
    <jsp:forward page="index.jsp"/>
    <%
        }
        if (request.getParameter("flightno") != null && request.getParameter("flightno").equals("")) {
    %>
    <jsp:forward page="index.jsp"/>
    <%
        }
    %>
    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
                       url="jdbc:mysql://localhost/AIRLINE_RESERVATION"
                       user="root"  password=""/>
    <sql:query dataSource="${snapshot}" var="result">
        SELECT Flight_number,
        Fare_code,
        Amount,
        Restrictions 
        FROM FARE
        WHERE Flight_number = <%= request.getParameter("flightno")%>
    </sql:query>
    <body>
        <table>
            <tr  id="firstrow">
                <th>Number</th>
                <th>Fare Code</th>
                <th>Amount</th>
                <th>Restrictions</th>
            </tr>
            <c:choose>
                <c:when test="${result.rowCount == 0}">
                    <jsp:forward page="index.jsp"/>
                </c:when>
                <c:otherwise>
                    <c:forEach var="row" items="${result.rows}">
                        <tr>
                            <td><c:out value="${row.Flight_number}"/></td>
                            <td><c:out value="${row.Fare_code}"/></td>
                            <td><c:out value="${row.Amount}"/></td>
                            <td><c:out value="${row.Restrictions}"/></td>
                        </tr>    
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            <tr><td colspan="4"><a href="index.jsp"><h3>HOME</h3></a></td></tr>            
        </table>
    </body>
</html>