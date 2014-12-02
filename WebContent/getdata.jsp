<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="org.json.JSONObject" %>
<jsp:useBean id="Query" class="ConnectDB.Query"></jsp:useBean>
<%
  
        ResultSet rs = null;
        List empdetails = new LinkedList();
        JSONObject responseObj = new JSONObject();

		rs = Query.getfun1();
           JSONObject empObj = null;

        while (rs.next()) {
            String org = rs.getString("OM.Orgnization");
            int count = rs.getInt("count(distinct(A.paperid))");
            empObj = new JSONObject();
            empObj.put("org", org);
            empObj.put("count", count);
            empdetails.add(empObj);
        }
        responseObj.put("empdetails", empdetails);
    out.print(responseObj.toString());
    System.out.println(responseObj.toString());
   %>