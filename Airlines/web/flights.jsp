<%-- 
    Document   : Flights
    Created on : Mar 29, 2015, 4:08:55 PM
    Author     : abinav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Flight Connectivity</title>
    <link rel="stylesheet" href="table.css" type="text/css">
</head>
<%
    if (request.getParameter("conn_flights") == null || request.getParameter("dep_code") == null || request.getParameter("arr_code") == null) {
%>
<jsp:forward page="index.jsp"/>
<%
    }
%>
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost/AIRLINE_RESERVATION"
                   user="root"  password=""/>
<sql:query dataSource="${snapshot}" var="result0">
    SELECT Flight_number,
    Weekdays,
    Departure_airport_code,
    Arrival_airport_code
    FROM FLIGHT
    WHERE 
    Departure_airport_code = '<%=request.getParameter("dep_code")%>'
    AND
    Arrival_airport_code = '<%=request.getParameter("arr_code")%>' 
    ORDER BY Flight_number;
</sql:query>

<table>
    <tr>
        <th>Flight</th>
        <th>Days</th>
        <th>Description</th>
    </tr>
    <%
        int conn_flights = Integer.parseInt(request.getParameter("conn_flights"));
    %>
    <tr><td colspan='3'>Direct Flights</td></tr>
    <c:if test="${result0.rowCount == 0}">
        <jsp:forward page="index.jsp"/>
    </c:if>
    <c:forEach var="row" items="${result0.rows}">
        <tr>
            <td><c:out value="${row.Flight_number}"/></td>
            <td><c:out value="${row.Weekdays}"/></td>
            <td><c:out value="${row.Departure_airport_code}"/>&#8594;<c:out value="${row.Arrival_airport_code}"/></td>
        </tr>    
    </c:forEach>

    <%
        if (conn_flights > 0) {
    %>
    <tr><td colspan='3'>1 Connecting Flight</td></tr>
    <sql:query dataSource="${snapshot}" var="result1">
        SELECT CONCAT(a.Flight_number,'') AS fa,
        CONCAT(b.Flight_number,'') AS fb,
        CONCAT(a.Weekdays,'') AS wk,
        CONCAT(a.Departure_airport_code,'') as ta,
        CONCAT(b.Departure_airport_code,'') as tb,
        CONCAT(b.Arrival_airport_code,'') as tc
        FROM FLIGHT a INNER JOIN FLIGHT b ON (a.Arrival_airport_code = b.Departure_airport_code)
        WHERE 
        a.Departure_airport_code = '<%=request.getParameter("dep_code")%>'
        AND
        b.Arrival_airport_code = '<%=request.getParameter("arr_code")%>' 
        AND
        HOUR(TIMEDIFF(b.Scheduled_departure_time , a.Scheduled_arrival_time)) > 1
        AND
        HOUR(TIMEDIFF(b.Scheduled_departure_time , a.Scheduled_arrival_time)) < 3
        ORDER BY a.Flight_number,b.Flight_number;
    </sql:query>
    <c:if test="${result0.rowCount + result1.rowCount == 0}">
        <jsp:forward page="index.jsp"/>
    </c:if>    
    <c:forEach var="row" items="${result1.rows}">
        <tr>
            <td><c:out value="${row.fa}"/>&#8594;<c:out value="${row.fb}"/></td>
            <td><c:out value="${row.wk}"/></td>
            <td><c:out value="${row.ta}"/>&#8594;<c:out value="${row.tb}"/>&#8594;<c:out value="${row.tc}"/></td>
        </tr>    
    </c:forEach>
    <%
        }
    %>
    <%
        if (conn_flights > 1) {
    %>
    <tr><td colspan='3'>2 Connecting Flights</td></tr>
    <sql:query dataSource="${snapshot}" var="result2">
        SELECT CONCAT(a.Flight_number,'') AS fa,
        CONCAT(b.Flight_number,'') AS fb,
        CONCAT(c.Flight_number,'') AS fc,
        CONCAT(a.Weekdays,'') AS wk,
        CONCAT(a.Departure_airport_code,'') as ta,
        CONCAT(b.Departure_airport_code,'') as tb,
        CONCAT(c.Departure_airport_code,'') as tc,
        CONCAT(c.Arrival_airport_code,'') as td
        FROM FLIGHT a INNER JOIN FLIGHT b ON (a.Arrival_airport_code = b.Departure_airport_code) 
        INNER JOIN FLIGHT c ON (b.Arrival_airport_code = c.Departure_airport_code)
        WHERE 
        a.Departure_airport_code = '<%=request.getParameter("dep_code")%>'
        AND
        c.Arrival_airport_code = '<%=request.getParameter("arr_code")%>' 
        AND
        HOUR(TIMEDIFF(b.Scheduled_departure_time , a.Scheduled_arrival_time)) > 1
        AND
        HOUR(TIMEDIFF(b.Scheduled_departure_time , a.Scheduled_arrival_time)) < 3
        AND
        HOUR(TIMEDIFF(c.Scheduled_departure_time , b.Scheduled_arrival_time)) > 1
        AND
        HOUR(TIMEDIFF(c.Scheduled_departure_time , b.Scheduled_arrival_time)) < 3
        ORDER BY a.Flight_number,b.Flight_number,c.Flight_number;
    </sql:query>
    <c:if test="${result0.rowCount + result1.rowCount + result2.rowCount == 0}">
        <jsp:forward page="index.jsp"/>
    </c:if>
    <c:forEach var="row" items="${result2.rows}">
        <tr>
            <td><c:out value="${row.fa}"/>&#8594;<c:out value="${row.fb}"/>&#8594;<c:out value="${row.fc}"/></td>
            <td><c:out value="${row.wk}"/></td>
            <td><c:out value="${row.ta}"/>&#8594;<c:out value="${row.tb}"/>&#8594;<c:out value="${row.tc}"/>&#8594;<c:out value="${row.td}"/></td>
        </tr>    
    </c:forEach>
    <%
        }
    %>

    <%
        if (conn_flights > 2) {
    %>
    <tr><td colspan='3'>3 Connecting Flights</td></tr>
    <sql:query dataSource="${snapshot}" var="result3">
        SELECT CONCAT(a.Flight_number,'') AS fa,
        CONCAT(b.Flight_number,'') AS fb,
        CONCAT(c.Flight_number,'') AS fc,
        CONCAT(d.Flight_number,'') AS fd,
        CONCAT(a.Weekdays,'') AS wk,
        CONCAT(a.Departure_airport_code,'') as ta,
        CONCAT(b.Departure_airport_code,'') as tb,
        CONCAT(c.Departure_airport_code,'') as tc,
        CONCAT(d.Departure_airport_code,'') as td,
        CONCAT(d.Arrival_airport_code,'') as te
        FROM FLIGHT a INNER JOIN FLIGHT b ON (a.Arrival_airport_code = b.Departure_airport_code) 
        INNER JOIN FLIGHT c ON (b.Arrival_airport_code = c.Departure_airport_code)
        INNER JOIN FLIGHT d ON (c.Arrival_airport_code = d.Departure_airport_code)
        WHERE 
        a.Departure_airport_code = '<%=request.getParameter("dep_code")%>'
        AND
        d.Arrival_airport_code = '<%=request.getParameter("arr_code")%>' 
        AND
        HOUR(TIMEDIFF(b.Scheduled_departure_time , a.Scheduled_arrival_time)) > 1
        AND
        HOUR(TIMEDIFF(b.Scheduled_departure_time , a.Scheduled_arrival_time)) < 3
        AND
        HOUR(TIMEDIFF(c.Scheduled_departure_time , b.Scheduled_arrival_time)) > 1
        AND
        HOUR(TIMEDIFF(c.Scheduled_departure_time , b.Scheduled_arrival_time)) < 3
        AND
        HOUR(TIMEDIFF(d.Scheduled_departure_time , c.Scheduled_arrival_time)) > 1
        AND
        HOUR(TIMEDIFF(d.Scheduled_departure_time , c.Scheduled_arrival_time)) < 3
        ORDER BY a.Flight_number,b.Flight_number,c.Flight_number,d.Flight_number;   
    </sql:query>
    <c:if test="${result0.rowCount + result1.rowCount + result2.rowCount + result3.rowCount == 0}">
        <jsp:forward page="index.jsp"/>
    </c:if>    
    <c:forEach var="row" items="${result3.rows}">
        <tr>
            <td><c:out value="${row.fa}"/>&#8594;<c:out value="${row.fb}"/>&#8594;<c:out value="${row.fc}"/>&#8594;<c:out value="${row.fd}"/></td>
            <td><c:out value="${row.wk}"/></td>
            <td><c:out value="${row.ta}"/>&#8594;<c:out value="${row.tb}"/>&#8594;<c:out value="${row.tc}"/>&#8594;<c:out value="${row.td}"/>&#8594;<c:out value="${row.te}"/></td>
        </tr>    
    </c:forEach>
    <%
        }
    %>
    <tr><td colspan="3"><a href="index.jsp"><h3>HOME</h3></a></td></tr>
</table>