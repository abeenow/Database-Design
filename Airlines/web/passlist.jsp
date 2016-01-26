<%-- 
    Document   : passlist
    Created on : Mar 29, 2015, 4:08:55 PM
    Author     : abinav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Passenger List</title>
        <link rel="stylesheet" href="table.css" type="text/css">
    </head>
    <%
        if (request.getParameter("flightno") == null || request.getParameter("date") == null) {
    %>
    <jsp:forward page="index.jsp"/>
    <%
        }
        if (request.getParameter("flightno") != null && request.getParameter("flightno").equals("")) {
    %>
    <jsp:forward page="index.jsp"/>
    <%
        }
        if (request.getParameter("date") != null && request.getParameter("date").equals("")) {
    %>
    <jsp:forward page="index.jsp"/>
    <%
        }
    %>
    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
                       url="jdbc:mysql://localhost/AIRLINE_RESERVATION"
                       user="root"  password=""/>

    <sql:query dataSource="${snapshot}" var="result">
        SELECT * 
        FROM 
        SEAT_RESERVATION 
        WHERE Flight_number = <%= request.getParameter("flightno")%>
        AND
        Date = '<%= request.getParameter("date")%>';
    </sql:query>
    <body>  
        <table>
            <tr  id="firstrow">
                <th>Number</th>
                <th>Date</th>
                <th>Seat Number</th>
                <th>Customer Name</th>
                <th>Customer Phone</th>
            </tr>
            <c:choose>
                <c:when test="${result.rowCount == 0}">
                    <jsp:forward page="index.jsp"/>
                </c:when>
                <c:otherwise>
                    <c:forEach var="row" items="${result.rows}">
                        <tr>
                            <td><c:out value="${row.Flight_number}"/></td>
                            <td><c:out value="${row.Date}"/></td>
                            <td><c:out value="${row.Seat_number}"/></td>
                            <td><c:out value="${row.Customer_name}"/></td>
                            <td><c:out value="${row.Customer_phone}"/></td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            <tr><td colspan="5"><a href="index.jsp"><h3>HOME</h3></a></td></tr>            
        </table>
    </body>
</html>