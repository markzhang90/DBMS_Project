<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="org.json.JSONObject" %>
<jsp:useBean id="Query" class="ConnectDB.Query"></jsp:useBean>
<%
  
        ResultSet rs = null;
        List empdetails3 = new LinkedList();
        JSONObject responseObj = new JSONObject();

		rs = Query.getfun3();
           JSONObject empObj3 = null;

        while (rs.next()) {
            String year = rs.getString("A.year");
            int count = rs.getInt("count(distinct(A.paperid))");
            empObj3 = new JSONObject();
            empObj3.put("year", year);
            empObj3.put("count", count);
            empdetails3.add(empObj3);
        }
        responseObj.put("empdetails3", empdetails3);
    out.print(responseObj.toString());
    System.out.println(responseObj.toString());
   %>