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
        String nearby = request.getParameter("place");
        if(nearby == null)
            nearby = "PLAY_SCHOOL";

  %>
  <h1>Real Estate Management</h1>
  <hr>
  <h4>Displayed the total number of apartments near play school. </h4>
  <h5>We can also select the nearby place as per our preference.</h5>
  <form class="form-horizontal" action="Query4.jsp" method="post">
    <div class="dropdown">
      <div class="form-group col-md-4">
        <label for="place">Choose nearby place</label>
        <select id="place" class="form-control" name="place">
          <option value="PLAY_SCHOOL" <% if(("PLAY_SCHOOL").equals(request.getParameter("place"))) { %> selected <% }%> >Play School</option>
          <option value="PLAYGROUND" <% if( ("PLAYGROUND").equals(request.getParameter("place"))) { %> selected <% }%>>Playground</option>
          <option value="GROCERY_STORE" <% if(("GROCERY_STORE").equals(request.getParameter("place"))) { %> selected <% }%> >Grocery Store</option>
          <option value="MUSEUM" <% if(("MUSEUM").equals(request.getParameter("place"))) { %> selected <% }%>>Museum</option>
        </select>
      </div>
    </div>
    <button class="btn btn-primary" type="submit">Submit</button>
  </form>
  <%
    String query = "select COUNT(Apt_Id) as Apartments_Near_Playschool from APARTMENT_NEARBY_PLACES group by places having places LIKE '"+nearby+"'";
    ResultSet rs = stmt.executeQuery(query);

  %>
  <%
    if(("PLAY_SCHOOL").equals(nearby))
      nearby = "Play School";
    else if(("MUSEUM").equals(nearby))
      nearby = "Museum";
    else if(("PLAYGROUND").equals(nearby))
      nearby = "Playground";
    else if(("GROCERY_STORE").equals(nearby)) {
      nearby = "Grocery Store";
    }
    if(rs.next() == true)  {
  %>
  <table class="table col-sm-10">
    <thead class="thead-dark">
    <tr>
      <th>Number of Apartments Near <%=nearby%></th>
    </tr>
    </thead>
    <tbody>
    <%do  {
      String count=rs.getString("Apartments_Near_Playschool");
    %>

    <tr>

      <td><%=count%> </td>
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