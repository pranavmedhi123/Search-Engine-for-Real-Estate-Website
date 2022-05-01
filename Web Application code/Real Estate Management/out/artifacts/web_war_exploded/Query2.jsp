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
        String cost = request.getParameter("cost");
        if(cost == null)
            cost = "50000";


  %>
  <h1>Real Estate Management</h1>
  <hr>
  <h4>Displayed sellers who has a fixed price for his property and cost less than 50k$.</h4>
    <h5>We can also select the cost as per our preference.</h5>
  <form class="form-horizontal" action="Query2.jsp" method="post">
    <div class="form-group col-md-4">
      <label for="cost">Enter the cost </label>
      <input type="number" class="form-control" id="cost" name="cost" placeholder="Enter the cost" value="<%=cost%>">
    </div>
    <div class="form-group col-md-4">
      <button class="btn btn-primary" type="submit">Submit</button>
    </div>
  </form>
  <%
    String query = "select user.FName, user.LName, user.Contact_No, seller.Fixed_Price, seller.Apt_Id from user INNER JOIN seller ON user.SSN = seller.SSSN AND seller.fixed_price < "+cost;
    ResultSet rs = stmt.executeQuery(query);

  %>
  <%

    if(rs.next() == true)  {
  %>
  <table class="table col-sm-10">
    <thead class="thead-dark">
    <tr>
      <th>First Name</th>
      <th>Last Name</th>
      <th>Contact number</th>
      <th>Price</th>
      <th>Apartment Id</th>
    </tr>
    </thead>
    <tbody>
    <%do  {
      String fname = rs.getString("fname");
      String lname = rs.getString("lname");
      String contact_no =rs.getString("contact_no");
      String price=rs.getString("fixed_price");
      String aptId=rs.getString("apt_Id");
    %>

    <tr>

      <td><%=fname%> </td>
      <td><%=lname%> </td>
      <td><%=contact_no%> </td>
      <td>$ <%=price%> </td>
      <td><%=aptId%> </td>
    </tr>
    <%} while(rs.next());%>
    </tbody>
    <%
    %></table>
  <hr><%
    }    else
%> <h6> No Records Found</h6>  <% }

  }catch(Exception ex){
    System.out.println("Unable to connect to database"+ex);
  }

%>
</div>
</body>
</html>