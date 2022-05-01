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
  <h4>Displayed all the branches where more than two employees work in ascending order of number of employees.</h4>
  <%
    String query1 = "create view No_of_Employees as select COUNT(employee_id) as No_of_Employees , Branch_Id from works_at group by branch_id having COUNT(employee_id) > 2 order by COUNT(employee_id)";
    int result = stmt.executeUpdate(query1);
    String query = "select B.Branch_Id, B.Street, B.Contact_no, B.City, B.State, N.No_of_Employees from Branch as B INNER JOIN No_of_Employees as N on B.branch_Id=N.branch_Id order by N.No_of_Employees asc";
    ResultSet rs = stmt.executeQuery(query);

  %>
  <%

    if(rs.next() == true)  {
  %>
  <table class="table col-sm-10">
    <thead class="thead-dark">
    <tr>
      <th>Branch Id</th>
      <th>Street</th>
      <th>Contact No.</th>
      <th>City</th>
      <th>State</th>
      <th>No. of Employees</th>
    </tr>
    </thead>
    <tbody>
    <%do  {
      String branchId=rs.getString("Branch_Id");
      String street=rs.getString("Street");
      String contact_no=rs.getString("Contact_no");
      String city=rs.getString("City");
      String state=rs.getString("State");
      String no_of_employees=rs.getString("No_of_Employees");

    %>

    <tr>

      <td><%=branchId%></td>
      <td><%=street%> </td>
      <td><%=contact_no%></td>
      <td><%=city%> </td>
      <td><%=state%></td>
      <td><%=no_of_employees%> </td>
    </tr>
    <%} while(rs.next());%>
    </tbody>
    <%
    %></table>
  <hr><%
      String query2 = "drop view No_of_Employees";
      result = stmt.executeUpdate(query2);
    }   else
%> <h6> No Records Found </h6><%   }

  }catch(Exception ex){
    System.out.println("Unable to connect to database"+ex);
  }

%>
</div>
</body>
</html>