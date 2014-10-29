<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<jsp:useBean id="Query" class="ConnectDB.Query"></jsp:useBean>
<%
String findit = request.getParameter("findit");
String check = request.getParameter("check");
String con = request.getParameter("con");
String conference = null;
String findRlt=null;

if(con.equals("0")){
	conference= "";
}else{
	conference = " and L.Lid ="+con;
}

System.out.println(conference);
if(check.equals("A")){
ResultSet getr1= null;
	findRlt = "Select PM.Paper, NP.Name, C.Conference, A.Year, L.Location From article AS A, papermap AS PM, namemap AS NP, conference AS C, location AS L where NP.Name like '%"+ findit +"%' and NP.Nid=A.Nameid and PM.Pid=A.Paperid and C.Cid=A.Confid and A.Lid =L.Lid ";
	findRlt = findRlt+conference;
	response.getWriter().println("<table><tbody><tr><th>Name</th><th>Paper</th><th>Conference</th><th>Location</th><th>Year</th></tr>");	
	 getr1 = Query.getRlt(findRlt);
		 while(getr1.next()){
	
		  //System.out.println(getr1.getInt("Nid"));
		 response.getWriter().println("<tr><td><b>"+getr1.getString("NP.Name")+"</b></td>"+
										"<td><b>"+getr1.getString("PM.Paper")+"</b></td>"+
										"<td><b>"+getr1.getString("C.Conference")+"</b></td>"+
										"<td><b>"+getr1.getString("L.Location")+"</b></td>"+
										"<td><b>"+getr1.getString("A.Year")+"</b></td></tr>");
		 

		 
	}  
	
	response.getWriter().println("</tbody></table>");
}

if(check.equals("M")){
ResultSet getr1= null;
	findRlt = "Select OM.Orgnization, NP.Name, C.Conference, A.Year, L.Location From member AS A, orgnizationmap AS OM, namemap AS NP, conference AS C, location AS L where NP.Name like '%"+ findit +"%' and NP.Nid=A.Nameid and OM.Oid=A.Orgid and C.Cid=A.Confid and A.Lid =L.Lid ";
	findRlt = findRlt+conference;
	response.getWriter().println("<table><tbody><tr><th>Name</th><th>Affiliation</th><th>Conference</th><th>Location</th><th>Year</th></tr>");	
	 getr1 = Query.getRlt(findRlt);
		 while(getr1.next()){
	
		  //System.out.println(getr1.getInt("Nid"));
		 response.getWriter().println("<tr><td><b>"+getr1.getString("NP.Name")+"</b></td>"+
										"<td><b>"+getr1.getString("OM.Orgnization")+"</b></td>"+
										"<td><b>"+getr1.getString("C.Conference")+"</b></td>"+
										"<td><b>"+getr1.getString("L.Location")+"</b></td>"+
										"<td><b>"+getr1.getString("A.Year")+"</b></td></tr>");
		 

		 
	}  
	
	response.getWriter().println("</tbody></table>");
}

if(check.equals("F")){
ResultSet getr1= null;
	findRlt = "Select P.Paper, NP.Name, C.Conference, A.Year, L.Location From article AS A, member AS M, orgnizationmap AS OM, namemap AS NP, conference AS C, papermap AS P, location AS L where P.Pid = A.Paperid and OM.Orgnization like '%"+ findit +"%' and NP.Nid=A.Nameid and A.Nameid=M.Nameid and OM.Oid=M.Orgid and C.Cid=A.Confid and A.Lid =L.Lid ";
	findRlt = findRlt+conference;
	response.getWriter().println("<table><tbody><tr><th>Name</th><th>Paper</th><th>Conference</th><th>Location</th><th>Year</th></tr>");	
	 getr1 = Query.getRlt(findRlt);
		 while(getr1.next()){
	
		  //System.out.println(getr1.getInt("Nid"));
		 response.getWriter().println("<tr><td><b>"+getr1.getString("NP.Name")+"</b></td>"+
										"<td><b>"+getr1.getString("P.Paper")+"</b></td>"+
										"<td><b>"+getr1.getString("C.Conference")+"</b></td>"+
										"<td><b>"+getr1.getString("L.Location")+"</b></td>"+
										"<td><b>"+getr1.getString("A.Year")+"</b></td></tr>");
		 

		 
	}  
	
	response.getWriter().println("</tbody></table>");
}
%>

