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
  <h4>Displayed the top 5 agents with the highest amount of experience. </h4>
  <%
    String query = "select e.Employee_id, e.Fname, e.Lname, e.Email_id, a.SSN, a.Years_of_Experience, a.No_of_Sales from Employee as e INNER JOIN Agent as a on a.employee_id = e.Employee_id order by a.Years_of_Experience desc LIMIT 5";
    ResultSet rs = stmt.executeQuery(query);

  %>
  <%

    if(rs.next() == true)  {
  %>
  <table class="table col-sm-10">
    <thead class="thead-dark">
    <tr>
      <th>Employee Id</th>
      <th>First Name</th>
      <th>Last Name</th>
      <th>Email Id</th>
      <th>SSN</th>
      <th>Years of Experience</th>
      <th>Number of Sales</th>
    </tr>
    </thead>
    <tbody>
    <%do  {
      String empId=rs.getString("Employee_id");
      String fname=rs.getString("Fname");
      String lname=rs.getString("Lname");
      String enail=rs.getString("Email_id");
      String ssn=rs.getString("SSN");
      String years_of_experience=rs.getString("Years_of_Experience");
      String no_of_sales=rs.getString("No_of_Sales");
    %>

    <tr>

      <td><%=empId%></td>
      <td><%=fname%></td>
      <td><%=lname%></td>
      <td><%=enail%> </td>
      <td><%=ssn%> </td>
      <td><%=years_of_experience%> </td>
      <td><%=no_of_sales%> </td>
    </tr>
    <%} while(rs.next());%>
    </tbody>
    <%
    %></table>
  <hr><%
    }  else
%> <h6> No Records Found</h6><%    }

  }catch(Exception ex){
    System.out.println("Unable to connect to database"+ex);
  }

%>
</div>
</body>
</html>