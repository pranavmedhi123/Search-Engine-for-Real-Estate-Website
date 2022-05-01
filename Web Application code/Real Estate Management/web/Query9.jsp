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
  <h4>Displayed the Contact number of the Branch whose BranchID is 1000.</h4>
  <h5>We can also select branchId as per our preference. </h5>
  <form class="form-horizontal" action="Query9.jsp" method="post">
    <div class="form-group col-md-4">
      <label for="branchId">Enter Branch Id</label>
      <%
        String branchId = request.getParameter("branchId");
        if(branchId == null)
          branchId = "1000";
      %>
      <input type="number" class="form-control" id="branchId" name="branchId" placeholder="Enter branch Id" value="<%=branchId%>">
    </div>
    <button class="btn btn-primary" type="submit">Submit</button>
  </form>
  <%
    String query = "select * from branch where branch_id = "+branchId;
    ResultSet rs = stmt.executeQuery(query);

  %>
  <%

    if(rs.next() == true)  {
  %>
  <table class="table col-sm-10">
    <thead class="thead-dark">
    <tr>
      <th>Branch Id</th>
      <th>Contact number</th>
      <th>Street</th>
      <th>City</th>
      <th>State</th>
    </tr>
    </thead>
    <tbody>
    <%do  {
      String bid=rs.getString("branch_Id");
      String street=rs.getString("street");
      String contactno=rs.getString("contact_no");
      String city=rs.getString("city");
      String state=rs.getString("state");

    %>

    <tr>

      <td><%=bid%></td>
      <td><%=contactno%> </td>
      <td><%=street%> </td>
      <td><%=city%> </td>
      <td><%=state%> </td>

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