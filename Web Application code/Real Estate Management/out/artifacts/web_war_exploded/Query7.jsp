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
  <h4>Displayed apartments with a height of the ceiling of 8 feet.</h4>
  <h5>We can also select height as per our preference. </h5>
  <form class="form-horizontal" action="Query7.jsp" method="post">
    <div class="form-group col-md-4">
      <label for="ceiling_height">Enter Ceiling Height (in feet)</label>
      <input type="number" class="form-control" id="ceiling_height" name="ceiling_height" placeholder="Enter ceiling height" value="<%=request.getParameter("ceiling_height") != null ? request.getParameter("ceiling_height") : 8%>">
    </div>
    <button class="btn btn-primary" type="submit">Submit</button>
  </form>
  <%
    String height = request.getParameter("ceiling_height");
    if(height == null)
      height = "8";
    String query = "select * from apartments where apt_id IN (select apt_id from interiors where ceiling_height = "+height+")";
    ResultSet rs = stmt.executeQuery(query);

  %>
  <%

    if(rs.next() == true)  {
  %>
  <table class="table col-sm-10">
    <thead class="thead-dark">
    <tr>
      <th>Apartment Id</th>
      <th>Area</th>
      <th>Cost</th>
      <th>No. of Bedrooms</th>
      <th>Floor No.</th>
      <th>Street</th>
      <th>City</th>
      <th>Apartment no.</th>
    </tr>
    </thead>
    <tbody>
    <%do  {
      String apt=rs.getString("apt_id");
      String area=rs.getString("area");
      String cost=rs.getString("cost");
      String nbd=rs.getString("no_of_bedrooms");
      String fno=rs.getString("floor_no");
      String street=rs.getString("street");
      String aptno=rs.getString("apt_no");
      String city=rs.getString("city");

    %>

    <tr>

      <td><%=apt%></td>
      <td><%=area%>  sq. ft</td>
      <td> $ <%=cost%></td>
      <td><%=nbd%> </td>
      <td><%=fno%> </td>
      <td><%=street%> </td>
      <td><%=city%> </td>
      <td><%=aptno%> </td>
    </tr>
    <%} while(rs.next());%>
    </tbody>
    <%
    %></table>
  <hr><%
    }   else
%> <h6> No Records Found </h6><%   }

  }catch(Exception ex){
    System.out.println("Unable to connect to database"+ex);
  }

%>
</div>
</body>
</html>