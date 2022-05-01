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


  %>
  <h1>Real Estate Management</h1>
  <hr>
  <h4> Displayed Sellers whose apartment has an architecture type of Japanese and facilities such as gym.</h4>
  <h5>We can also select the architecture type and facility as per our preference.</h5>
  <form class="form-horizontal" action="Query6.jsp" method="post">
    <div class="dropdown">
      <div class="form-group col-md-4">
        <label for="archType">Choose Architecture type</label>
        <select id="archType" class="form-control" name="archType">
          <option <% if(("Japanese").equals(request.getParameter("archType"))) { %> selected <% }%>>Japanese</option>
          <option <% if(("French").equals(request.getParameter("archType"))) { %> selected <% }%>>French</option>
        </select>
      </div>
    </div>
    <div class="dropdown">
      <div class="form-group col-md-4">
        <label for="facilities">Choose Facilities</label>
        <select id="facilities" class="form-control" name="facilities">
          <option value="GYM" <% if( ("GYM").equals(request.getParameter("facilities"))) { %> selected <% }%>>Gym</option>
          <option value="SOFT_WATER" <% if(("SOFT_WATER").equals(request.getParameter("facilities"))) { %> selected <% }%> >Soft Water</option>
          <option value="POOL" <% if(("POOL").equals(request.getParameter("facilities"))) { %> selected <% }%>>Pool</option>
          <option value="PARKING" <% if(("PARKING").equals(request.getParameter("facilities"))) { %> selected <% }%> >Parking</option>
        </select>
      </div>
    </div>
    <button class="btn btn-primary" type="submit">Submit</button>
  </form>
  <%
    String facilities = "GYM";
    String archType = "Japanese";
    if(request.getParameter("archType") != null)
      archType = request.getParameter("archType");
    if(request.getParameter("facilities") != null)
       facilities = request.getParameter("facilities");
    String query = "select U.SSN, U.FName, U.LName, U.Contact_no, S.Max_Price, S.Min_Price, S.Fixed_Price, S.Rent_Cost, S.Apt_Id, S.Lease_Duration from user as U INNER JOIN Seller as S on U.SSN = S.SSSN AND S.Apt_Id IN (select apt_id from facilities where " + facilities + " LIKE 'Y' AND apt_id IN( select apt_id from interiors where Architecture_type LIKE '"+archType+"'))";
    ResultSet rs = stmt.executeQuery(query);

  %>
  <%

    if(rs.next() == true)  {
  %>
  <table class="table col-sm-12">
    <thead class="thead-dark">
    <tr>
      <th>SSN</th>
      <th>First Name</th>
      <th>Last Name</th>
      <th>Contact No.</th>
      <th>Max Price</th>
      <th>Min Price</th>
      <th>Fixed Price</th>
      <th>Rent Cost</th>
      <th>Apartment Id</th>
      <th>Lease Duration</th>
    </tr>
    </thead>
    <tbody>
    <%do  {
      String ssn=rs.getString("ssn");
      String fname=rs.getString("fname");
      String lname=rs.getString("lname");
      String contact_no=rs.getString("contact_no");
      String max_price=rs.getString("max_price");
      String min_price=rs.getString("min_price");
      String fixed_price=rs.getString("fixed_price");
      String rent_cost=rs.getString("rent_cost");
      String apt_id=rs.getString("apt_id");
      String lease_duration=rs.getString("lease_duration");

    %>

    <tr>

      <td><%=ssn%></td>
      <td><%=fname%></td>
      <td><%=lname%></td>
      <td><%=contact_no%> </td>
      <td> <% if(max_price != null) {%>$ <%=max_price%> <%} else { %> - <% }%></td>
      <td> <% if(min_price != null) {%>$ <%=min_price%> <%} else { %> - <% }%></td>
      <td> <% if(fixed_price != null) {%>$ <%=fixed_price%> <%} else { %> - <% }%></td>
      <td> <% if(rent_cost != null) {%>$ <%=rent_cost%> <%} else { %> - <% }%></td>
      <td><%=apt_id%> </td>
      <td><%=lease_duration%> months</td>
    </tr>
    <%} while(rs.next());%>
    </tbody>
    <%
    %></table>
  <hr><%
    }    else
%> <h6> No Records Found </h6><%  }

  }catch(Exception ex){
    System.out.println("Unable to connect to database"+ex);
  }

%>
</div>
</body>
</html>