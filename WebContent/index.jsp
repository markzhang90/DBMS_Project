<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fi" lang="fi">
<head>
<!-- META -->
<meta charset="utf-8" />
<title>Database Management</title>
<!-- /META -->

<link rel="stylesheet" href="css/IndexStyle.css" />

<script type="text/javascript">

	function searched() {
		var xmlhttp;
		var findit = document.getElementById("findit").value;
		
		var check=null;
		if(document.getElementById("A").checked==true){
			check = "A";
		}else if(document.getElementById("M").checked==true){
			check = "M";
		}else if(document.getElementById("F").checked==true){
			check = "F";
		}
		if(check==null){
			alert("choose a option");
			return false;
		}
		
		
		var con = document.getElementById("selectcon").value;
		
		
		//alert(con); 
		
 		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
 		
 		xmlhttp.onreadystatechange=function()
		  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    {
		    document.getElementById("show").innerHTML=xmlhttp.responseText;			    
		    }
		  }
		
		xmlhttp.open("GET", "getrequest.jsp?findit=" + findit + "&check=" + check + "&con=" +con, true);
	
		xmlhttp.send(); 
	

	}
</script>




</head>


<body>


	<header><!-- BEGIN HEADER -->
	<div id="top_header">
		<!-- begin top header -->
		<h1>Database Management Project</h1>
	</div>
	<!-- end top header --> </header>
	<!-- END HEADER -->

	<div id="main_frame" class="wrap">
		<!-- BEGIN CONTENT -->
		<section id="main">


		<h1>Choose</h1>


		<form id="contact" name="contact" action="" method="post">
			<div id="searcharea">
				<div class="left">
					<label for="search"><b>Search</b></label>
					<div id="searchoption">
						<input type="text" name="name" value="" id="findit" autofocus="OFF" /> <span class="alert"></span>
						<input type="radio" id="A" name="radio-btn" value="Author" />Author
					
						<input type="radio" id="M" name="radio-btn" value="PC member" />PC Member
					
						<input type="radio" id="F" name="radio-btn" value="Affiliation" />Affiliation
					</div>
					
					<!-- 
					<label ><b>Search Option</b></label> -->
					
						
					
				</div>
				
					
				
				<div class="left">
					<label for="name"><b>Conference</b></label>
					<div class="select-outer select-wh200">
						<div class="select-inner">
							<select class="select-h" name="selectcon" id="selectcon">
								<option value="0">Default</option>
								<option value="1">Sigmod 2011</option>
								<option value="2">Sigmod 2012</option>
								<option value="3">Sigmod 2014</option>

							</select>
						</div>
					</div>
				</div>
			</div>


			<div id="searchbt">
				<div id="bt1" src="" class="btn gradient blue_light center" onclick="searched();">Submit</div>
			</div>

		</form>

		<div id="result">
			<h1>Here shows the Result</h1>
			<div id="show"></div>

		</div>

		</section>
	</div>
	<!-- end main content -->


	<footer><!-- BEGIN FOOTER -->
	<div id="top_footer">
		<!-- begin top footer -->

	</div>
	<!-- end top footer --> </footer>
	<!-- END FOOTER -->

</body>


</html>
