<%-- 
    Document   : index
    Created on : Mar 18, 2015, 2:26:06 PM
    Author     : Abinav
--%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<html lang="en" >
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="login.css" type="text/css">
    </head>
    <title>Airline reservation</title>
    <body>
        <br>
        <h2 align="center"><font color="White" size="6px"><b>ASDF Tours and Travel</b></font></h2>
        <ul class="pricing_table">
            <li class="price_block">
                <h3>Plan your Travel</h3>
                <div class="price">
                    <div class="price_figure">
                        <span class="price_number">Flights</span>
                    </div>
                </div>
                <ul class="features">
                    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
                                       url="jdbc:mysql://localhost/AIRLINE_RESERVATION"
                                       user="root"  password=""/>
                    <sql:query dataSource="${snapshot}" var="result1">
                        SELECT DISTINCT Arrival_airport_code FROM FLIGHT ORDER BY Arrival_airport_code;
                    </sql:query>

                    <sql:query dataSource="${snapshot}" var="result2">
                        SELECT DISTINCT Departure_airport_code FROM FLIGHT ORDER BY Departure_airport_code;
                    </sql:query>    

                    <form action="flights.jsp">
                        <div class="new_div">
                            <br><br><br><br> <p style="float: left; text-align: left;">Select Source:</p> 
                            <select style="float: right; text-align: right;" name="arr_code" id="arr_code">
                                <c:forEach var="row" items="${result1.rows}">
                                    <option value="${row.Arrival_airport_code}"><c:out value="${row.Arrival_airport_code}"/></option>
                                </c:forEach>
                            </select>

                            <br><br><br><br><br> <p style="float: left; text-align: left;">Select Destination:</p>
                            <select style="float: right; text-align: right;" name="dep_code" id="dep_code">
                                <c:forEach var="row" items="${result2.rows}">
                                    <option value="${row.Departure_airport_code}"><c:out value="${row.Departure_airport_code}"/></option>
                                </c:forEach>
                            </select>
                            <br><br><br><br><br> <p style="float: left; text-align: left;">Select Connectivity:</p>
                            <br><br><br><select style="float: center; text-align: center;" name="conn_flights" id="conn_flights">
                                <option value="0">Direct Flights</option>
                                <option value="1">One stop</option>
                                <option value="2">Two stops</option>
                                <option value="3">Three stops</option>
                            </select>
                            
                            <br><br><br><br><br><br><br><input type="submit" value="Search" class="action_button"
                        </div>
                    </form>
                </ul>
            </li>
            <li class="price_block">
                <h3>Seat Details</h3>
                <div class="price">
                    <div class="price_figure">
                        <span class="price_number">Vacancy</span>
                    </div>
                </div>
                <ul class="features">
                    <form action="seatlist.jsp">
                        <br><br> Enter Flight Number:  <input type="number" name="flightno"><br><br>
                        Enter Date:  <input type="Date" name="date" value="2015-05-31"><br><br>
                        <div class="footer"><input type="submit" value="Search" class="action_button"></div>
                    </form>
                </ul>
            </li>
            <li class="price_block">
                <h3>Fare Information</h3>
                <div class="price">
                    <div class="price_figure">
                        <span class="price_number">Flight Number</span>
                    </div>
                </div>
                <ul class="features">
                    <form action="fare.jsp">
                        <br><br> Enter Flight Number:  <input type="number" name="flightno"><br><br>
                        <br><br><br><div class="footer"><input type="submit" value="Search" class="action_button"></div>
                    </form>
                </ul>
            </li>
            <li class="price_block">
                <h3>Passenger Manifest</h3>
                <div class="price">
                    <div class="price_figure">
                        <span class="price_number">Passenger List</span>
                    </div>
                </div>
                <ul class="features">
                    <form action="passlist.jsp">
                        <br><br> Enter Flight Number:  <input type="number" name="flightno"><br><br>
                        Enter Date:  <input type="Date" name="date" value="2015-05-31"><br><br>
                        <div class="footer"><input type="submit" value="Search" class="action_button"></div>
                    </form>
                    <br><br>
                    <form action="flightlist.jsp">
                        Enter Passenger Name:  <input type="text" name="custname"><br><br>
                        <div class="footer"><input type="submit" value="Search" class="action_button"></div>
                    </form>

                </ul>
            </li>

            <ul class="skeleton pricing_table" style="margin-top: 100px; overflow: hidden;">
                <li class="label" style="margin: 0 none;">ul.pricing_table</li>
                <li class="price_block">
                    <span class="label">li.price_block</span>
                    <h3><span class="label">h3</span></h3>
                    <div class="price">
                        <span class="label">div.price</span>
                        <div class="price_figure">
                            <span class="label">div.price_figure</span>
                            <span class="price_number">
                                <span class="label">span.price_number</span>
                            </span>
                            <span class="price_tenure">
                                <span class="label">span.price_tenure</span>
                            </span>
                        </div>
                    </div>
                    <ul class="features">
                        <li class="label">ul.features</li>
                        <br /><br /><br />
                    </ul>
                    <div class="footer">
                        <span class="label">div.footer</span>
                    </div>
                </li>


                <li class="price_block" style="opacity: 0.5;">
                    <span class="label">li.price_block</span>
                    <h3><span class="label">h3</span></h3>
                    <div class="price">
                        <span class="label">div.price</span>
                        <div class="price_figure">
                            <span class="label">div.price_figure</span>
                            <span class="price_number">
                                <span class="label">span.price_number</span>
                            </span>
                            <span class="price_tenure">
                                <span class="label">span.price_tenure</span>
                            </span>
                        </div>
                    </div>
                    <ul class="features">
                        <li class="label">ul.features</li>
                        <br /><br /><br />
                    </ul>
                    <div class="footer">
                        <span class="label">div.footer</span>
                    </div>
                </li>
                <li class="price_block" style="opacity: 0.25;">
                    <span class="label">li.price_block</span>
                    <h3><span class="label">h3</span></h3>
                    <div class="price">
                        <span class="label">div.price</span>
                        <div class="price_figure">
                            <span class="label">div.price_figure</span>
                            <span class="price_number">
                                <span class="label">span.price_number</span>
                            </span>
                            <span class="price_tenure">
                                <span class="label">span.price_tenure</span>
                            </span>
                        </div>
                    </div>
                    <ul class="features">
                        <li class="label">ul.features</li>
                        <br /><br /><br />
                    </ul>
                    <div class="footer">
                        <span class="label">div.footer</span>
                    </div>
                </li>
            </ul>
            <script src="login.js" type="text/javascript"></script>
    </body>
</html>
