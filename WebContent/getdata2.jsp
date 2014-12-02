<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="org.json.JSONObject" %>
<jsp:useBean id="Query" class="ConnectDB.Query"></jsp:useBean>
<%
  
        ResultSet rs = null;
        List empdetails2 = new LinkedList();
        JSONObject responseObj = new JSONObject();

		rs = Query.getfun2();
           JSONObject empObj2 = null;

        while (rs.next()) {
            String name = rs.getString("NM.Name");
            int count = rs.getInt("count(A.Paperid)");
            empObj2 = new JSONObject();
            empObj2.put("name", name);
            empObj2.put("count", count);
            empdetails2.add(empObj2);
        }
        responseObj.put("empdetails2", empdetails2);
    out.print(responseObj.toString());
    System.out.println(responseObj.toString());
   %>