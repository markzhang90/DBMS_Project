<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="org.json.JSONObject" %>
<jsp:useBean id="Query" class="ConnectDB.Query"></jsp:useBean>
<%
  
        ResultSet rs = null;
        List empdetails4 = new LinkedList();
        JSONObject responseObj = new JSONObject();

		rs = Query.getfun4();
           JSONObject empObj4 = null;

        while (rs.next()) {
            String org = rs.getString("OM.Orgnization");
            int count = rs.getInt("count(distinct(A.paperid))");
            int count2 = rs.getInt("count(distinct(M2.Nameid))");
            empObj4 = new JSONObject();
            empObj4.put("org", org);
            empObj4.put("count", count);
            empObj4.put("count2", count2);
            empdetails4.add(empObj4);
        }
        responseObj.put("empdetails4", empdetails4);
    out.print(responseObj.toString());
    System.out.println(responseObj.toString());
   %>