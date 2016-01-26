<%-- 
    Document   : seatlist
    Created on : Mar 29, 2015, 4:31:58 PM
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
        <title>Seat Details</title>
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
    <body>
        <table>
            <tr  id="firstrow">
                <th>Flight Number</th>
                <th>Date</th>
                <th>Available Seats</th>
            </tr>
            <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
                               url="jdbc:mysql://localhost/AIRLINE_RESERVATION"
                               user="root"  password=""/>
            <sql:query dataSource="${snapshot}" var="result">
                SELECT
                (a.Total_number_of_seats - s.count) as seats
                FROM 
                FLIGHT_INSTANCE f INNER JOIN AIRPLANE a ON (f.Airplane_id = a.Airplane_id) INNER JOIN
                (
                SELECT COUNT(Seat_number) as count,
                Flight_number as Flight_number,
                Date as Date 
                FROM SEAT_RESERVATION 
                GROUP BY Flight_number,Date) s ON (s.Flight_number=f.Flight_number AND s.Date=f.Date
                )
                WHERE f.Flight_number = <%= request.getParameter("flightno")%>
                AND
                f.Date = '<%= request.getParameter("date")%>';
            </sql:query>
            <c:choose>
                <c:when test="${result.rowCount == 0}">
                    <jsp:forward page="index.jsp"/>
                </c:when>
                <c:otherwise>
                    <c:forEach var="row" items="${result.rows}">
                        <tr>
                            <td><%= request.getParameter("flightno")%></td>
                            <td><%= request.getParameter("date")%></td>
                            <c:set var="seats" scope="page" value="${row.seats}"/>
                            <td><c:out value="${seats}"/></td>
                        </tr>    
                    </c:forEach>
                </c:otherwise>
            </c:choose>  
            <sql:update dataSource="${snapshot}" var="result1">
                UPDATE FLIGHT_INSTANCE SET Number_of_available_seats = <c:out value="${seats}"/>
                WHERE Flight_number = <%= request.getParameter("flightno")%>
                AND
                Date = '<%= request.getParameter("date")%>';
            </sql:update>
            <tr><td colspan="3"><a href="index.jsp"><h3>HOME</h3></a></td></tr>
        </table>
    </body>
</html>
