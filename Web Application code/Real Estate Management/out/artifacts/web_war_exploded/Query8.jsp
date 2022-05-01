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
  <h4>Displayed the Names of All the Customer Service Officers that have joined the branch in year 1997.</h4>
  <h5>We can also select year as per our preference. </h5>
  <form class="form-horizontal" action="Query8.jsp" method="post">
    <div class="dropdown">
      <div class="form-group col-md-4">
        <label for="year">Choose Year</label>
        <select id="year" class="form-control" name="year">
          <option <% if(("1997").equals(request.getParameter("year"))) { %> selected <% }%>>1997</option>
          <option <% if(("2019").equals(request.getParameter("year"))) { %> selected <% }%>>2019</option>
          <option <% if(("2018").equals(request.getParameter("year"))) { %> selected <% }%>>2018</option>
          <option <% if(("2017").equals(request.getParameter("year"))) { %> selected <% }%>>2017</option>
          <option <% if(("2016").equals(request.getParameter("year"))) { %> selected <% }%>>2016</option>
          <option <% if(("2015").equals(request.getParameter("year"))) { %> selected <% }%>>2015</option>
          <option <% if(("2014").equals(request.getParameter("year"))) { %> selected <% }%>>2014</option>
          <option <% if(("2013").equals(request.getParameter("year"))) { %> selected <% }%>>2013</option>
          <option <% if(("2012").equals(request.getParameter("year"))) { %> selected <% }%>>2012</option>
          <option <% if(("2011").equals(request.getParameter("year"))) { %> selected <% }%>>2011</option>
          <option <% if(("2010").equals(request.getParameter("year"))) { %> selected <% }%>>2010</option>
          <option <% if(("2009").equals(request.getParameter("year"))) { %> selected <% }%>>2009</option>
          <option <% if(("2008").equals(request.getParameter("year"))) { %> selected <% }%>>2008</option>
          <option <% if(("2007").equals(request.getParameter("year"))) { %> selected <% }%>>2007</option>
          <option <% if(("2006").equals(request.getParameter("year"))) { %> selected <% }%>>2006</option>
          <option <% if(("2005").equals(request.getParameter("year"))) { %> selected <% }%>>2005</option>
          <option <% if(("2004").equals(request.getParameter("year"))) { %> selected <% }%>>2004</option>
          <option <% if(("2003").equals(request.getParameter("year"))) { %> selected <% }%>>2003</option>
          <option <% if(("2002").equals(request.getParameter("year"))) { %> selected <% }%>>2002</option>
          <option <% if(("2001").equals(request.getParameter("year"))) { %> selected <% }%>>2001</option>
          <option <% if(("2000").equals(request.getParameter("year"))) { %> selected <% }%>>2000</option>
          <option <% if(("1999").equals(request.getParameter("year"))) { %> selected <% }%>>1999</option>
          <option <% if(("1998").equals(request.getParameter("year"))) { %> selected <% }%>>1998</option>
          <option <% if(("1996").equals(request.getParameter("year"))) { %> selected <% }%>>1996</option>
          <option <% if(("1995").equals(request.getParameter("year"))) { %> selected <% }%>>1995</option>
          <option <% if(("1994").equals(request.getParameter("year"))) { %> selected <% }%>>1994</option>
          <option <% if(("1993").equals(request.getParameter("year"))) { %> selected <% }%>>1993</option>
          <option <% if(("1992").equals(request.getParameter("year"))) { %> selected <% }%>>1992</option>
          <option <% if(("1991").equals(request.getParameter("year"))) { %> selected <% }%>>1991</option>
          <option <% if(("1990").equals(request.getParameter("year"))) { %> selected <% }%>>1990</option>
        </select>
      </div>
    </div>
    <button class="btn btn-primary" type="submit">Submit</button>
  </form>
  <%
    String year =  request.getParameter("year");
    if(year == null) {
      year = "1997";
    }
    String query = "select FName, LName from employee where YEAR(Joining_Date) = "+year+" AND SSN IN (select SSN from customer_service_officer)";
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
    </tr>
    </thead>
    <tbody>
    <%do  {
      String fname=rs.getString("fname");
      String lname=rs.getString("lname");
    %>

    <tr>

      <td><%=fname%> </td>
      <td><%=lname%> </td>
    </tr>
    <%} while(rs.next());%>
    </tbody>
    <%

    %></table>
  <hr><%
    } else
%> <h6> No Records Found </h6><% }
  }catch(Exception ex){
    System.out.println("Unable to connect to database"+ex);
  }

%>
</div>
</body>
</html>