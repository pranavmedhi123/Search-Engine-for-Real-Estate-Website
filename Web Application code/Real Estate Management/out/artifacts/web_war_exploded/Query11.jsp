<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Real Estate Management</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</head>
<body>
<div class="col-sm-10">
  <%
    try {
      Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
      Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/rem", "root", "123456");
      if(!connection.isClosed()) {
        System.out.println("Successfully connected to " + "MySQL server using TCP/IP...");
        Statement stmt = connection.createStatement();

        String facilities = request.getParameter("facilities");
        String city = request.getParameter("city");
        String rentCost = request.getParameter("rentCost");

        if(facilities == null)
            facilities = "SOFT_WATER";
        if(city == null)
            city = "Dallas";
        if(rentCost == null)
            rentCost = "2000";

  %>
  <h1>Real Estate Management</h1>
  <hr>
  <h4>Displayed the apartments available in Dallas with abundant soft water with a maximum rent of 2000$ per month.</h4>
  <h5>We can also select city, facilities and rent as per our preference. </h5>
  <form class="form-horizontal" action="Query11.jsp" method="post">
    <div class="dropdown">
      <div class="form-group col-md-4">
        <label for="city">Choose City</label>
        <select id="city" class="form-control" name="city">
          <option <% if(("Dallas").equals(request.getParameter("city"))) { %> selected <% }%>>Dallas</option>
          <option <% if(("San Jose").equals(request.getParameter("city"))) { %> selected <% }%>>San Jose</option>
          <option <% if(("San Franscisco").equals(request.getParameter("city"))) { %> selected <% }%>>San Franscisco</option>
          <option <% if(("Arlington").equals(request.getParameter("city"))) { %> selected <% }%>>Arlington</option>
          <option <% if(("Seattle").equals(request.getParameter("city"))) { %> selected <% }%>>Seattle</option>
          <option <% if(("Missouri").equals(request.getParameter("city"))) { %> selected <% }%>>Missouri</option>
          <option <% if(("Chicago").equals(request.getParameter("city"))) { %> selected <% }%>>Chicago</option>
        </select>
      </div>
    </div>
    <div class="dropdown">
      <div class="form-group col-md-4">
        <label for="facilities">Choose Facilities</label>
        <select id="facilities" class="form-control" name="facilities">
          <option value="SOFT_WATER" <% if(("SOFT_WATER").equals(request.getParameter("facilities"))) { %> selected <% }%> >Soft Water</option>
          <option value="GYM" <% if( ("GYM").equals(request.getParameter("facilities"))) { %> selected <% }%>>Gym</option>
          <option value="POOL" <% if(("POOL").equals(request.getParameter("facilities"))) { %> selected <% }%>>Pool</option>
          <option value="PARKING" <% if(("PARKING").equals(request.getParameter("facilities"))) { %> selected <% }%> >Parking</option>
        </select>
      </div>
    </div>
    <div class="form-group col-md-4">
      <label for="cost">Enter Maximum Rent Cost</label>
      <input type="number" class="form-control" id="cost" name="cost" placeholder="Enter Maximum Cost" value="<%=rentCost%>">
    </div>
    <button class="btn btn-primary" type="submit">Submit</button>
  </form>
  <%
    String query = "select Apt_Id, No_of_Bedrooms, Street, City, Apt_No from apartments where apt_id IN (select apt_Id from facilities where "+facilities+" LIKE 'Y' AND apt_id IN (select apt_Id from seller where rent_cost < "+rentCost+")) AND city LIKE '"+city+"'";
    ResultSet rs = stmt.executeQuery(query);

  %>
  <%

    if(rs.next() == true)  {
  %>
  <table class="table col-sm-10">
    <thead class="thead-dark">
    <tr>
      <th>Id</th>
      <th>No. of Bedrooms</th>
      <th>Street</th>
      <th>City</th>
      <th>Apartment no.</th>
    </tr>
    </thead>
    <tbody>
    <%do  {
      String aptid=rs.getString("apt_id");
      String nbd=rs.getString("no_of_bedrooms");
      String street=rs.getString("street");
      String aptno=rs.getString("apt_no");

    %>

    <tr>

      <td><%=aptid%></td>
      <td><%=nbd%> </td>
      <td><%=street%> </td>
      <td><%=city%> </td>
      <td><%=aptno%> </td>
    </tr>
    <%} while(rs.next());%>
    </tbody>
    <%

    %></table>
  <hr><%
    }  else
%> <h6> No Records Found </h6><%  }
  }catch(Exception ex){
    System.out.println("Unable to connect to database"+ex);
  }

%>
</div>
</body>
</html>