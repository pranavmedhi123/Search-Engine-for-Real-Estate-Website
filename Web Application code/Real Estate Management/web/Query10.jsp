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
  <h4>Displayed all the employees who have the same first names with respect to any other employee and display them in alphabetical order of their first names.</h4>
  <%
    String query = "select * from employee where fname IN (select fname from employee group by fname having count(fname) > 1) order by fname";
    ResultSet rs = stmt.executeQuery(query);

  %>
  <%

    if(rs.next() == true)  {
  %>
  <table class="table col-sm-10">
    <thead class="thead-dark">
    <tr>
      <th>SSN</th>
      <th>Employee Id</th>
      <th>First Name</th>
      <th>Last Name</th>
      <th>Joining Date</th>
      <th>Email Id</th>
      <th>Sex</th>
      <th>DOB</th>
    </tr>
    </thead>
    <tbody>
    <%do  {
      String ssn=rs.getString("ssn");
      String empid=rs.getString("employee_Id");
      String fname=rs.getString("fname");
      String lname=rs.getString("lname");
      String jd=rs.getString("joining_date");
      String email=rs.getString("email_Id");
      String sex=rs.getString("sex");
      String dob=rs.getString("date_of_birth");

    %>

    <tr>

      <td><%=ssn%></td>
      <td><%=empid%></td>
      <td><%=fname%></td>
      <td><%=lname%> </td>
      <td><%=jd%> </td>
      <td><%=email%> </td>
      <td><%=sex%> </td>
      <td><%=dob%> </td>
    </tr>
    <%} while(rs.next());%>
    </tbody>
    <%

    %></table>
  <hr><%
    }} else
%> <h6> No Records Found</h6><%
  }catch(Exception ex){
    System.out.println("Unable to connect to database"+ex);
  }

%>
</div>
</body>
</html>