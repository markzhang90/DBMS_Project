<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<jsp:useBean id="Query" class="ConnectDB.Query"></jsp:useBean>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fi" lang="fi">
<head>
<!-- META -->
<meta charset="utf-8" />
<title>Database Management</title>
<!-- /META -->

<link rel="stylesheet" href="css/IndexStyle.css" />
 <script type="text/javascript" src="https://www.google.com/jsapi"></script>
 <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript">

var queryObject="";
var queryObjectLen="";
var queryObject2="";
var queryObjectLen2="";
$.ajax({
    type : 'POST',
    url : 'getdata.jsp',
    dataType:'json',
    success : function(data) {
        queryObject = eval('(' + JSON.stringify(data) + ')');
        queryObjectLen = queryObject.empdetails.length;
    },
        error : function(xhr, type) {
        alert('server error occoured')
    }
});

$.ajax({
    type : 'POST',
    url : 'getdata2.jsp',
    dataType:'json',
    success : function(data) {
        queryObject2 = eval('(' + JSON.stringify(data) + ')');
        queryObjectLen2 = queryObject2.empdetails2.length;
    },
        error : function(xhr, type) {
        alert('server error occoured')
    }
});

$.ajax({
    type : 'POST',
    url : 'getdata3.jsp',
    dataType:'json',
    success : function(data) {
        queryObject3 = eval('(' + JSON.stringify(data) + ')');
        queryObjectLen3 = queryObject3.empdetails3.length;
    },
        error : function(xhr, type) {
        alert('server error occoured')
    }
});

$.ajax({
    type : 'POST',
    url : 'getdata4.jsp',
    dataType:'json',
    success : function(data) {
        queryObject4 = eval('(' + JSON.stringify(data) + ')');
        queryObjectLen4 = queryObject4.empdetails4.length;
    },
        error : function(xhr, type) {
        alert('server error occoured')
    }
});
// Load the Visualization API and the piechart package.
google.load('visualization', '1.0', {'packages':['corechart']});


function drawChart() {


// Create the data table.
var data = new google.visualization.DataTable();
data.addColumn('string', 'org');
data.addColumn('number', 'count');
for(var i=0;i<queryObjectLen;i++)
{
    var org = queryObject.empdetails[i].org;
    var count = queryObject.empdetails[i].count;
    data.addRows([
        [org,parseInt(count)]
    ]);
}

// Set chart options
var options = {'title':'Distribution of papers in each conference by affiliation 2011',
               'width':950,
               'height':500};

// Instantiate and draw our chart, passing in some options.
var chart = new google.visualization.ColumnChart(document.getElementById('chart'));
chart.draw(data, options);
}

function drawChart2() {


	// Create the data table.
	var data = new google.visualization.DataTable();
	data.addColumn('string', 'name');
	data.addColumn('number', 'count');
	for(var i=0;i<queryObjectLen2;i++)
	{
	    var name = queryObject2.empdetails2[i].name;
	    var count = queryObject2.empdetails2[i].count;
	    data.addRows([
	        [name,parseInt(count)]
	    ]);
	}

	// Set chart options
	var options = {'title':'Member who publish paper',
					pieHole: 0.4,
					is3D: true,
	               'width':950,
	               'height':500};

	// Instantiate and draw our chart, passing in some options.
	var chart = new google.visualization.PieChart(document.getElementById('chart'));
	chart.draw(data, options);
	}


function drawChart3() {


	// Create the data table.
	var data = new google.visualization.DataTable();
	data.addColumn('string', 'year');
	data.addColumn('number', 'count');
	for(var i=0;i<queryObjectLen3;i++)
	{
	    var year = queryObject3.empdetails3[i].year;
	    var count = queryObject3.empdetails3[i].count;
	    data.addRows([
	        [year,parseInt(count)]
	    ]);
	}

	// Set chart options
	var options = {'title':'The total number of paper accepted each year',
	               'width':950,
	               'height':500};

	// Instantiate and draw our chart, passing in some options.
	var chart = new google.visualization.BarChart(document.getElementById('chart'));
	chart.draw(data, options);
	}
	
function drawChart4() {
	

	// Create the data table.
	var data = new google.visualization.DataTable();
	data.addColumn('string', 'Orgnization');
	data.addColumn('number', 'PaperNum');
	data.addColumn('number', 'MemberNum');
	for(var i=0;i<queryObjectLen4;i++)
	{	
		
		 var org = queryObject4.empdetails4[i].org;
		 var count1 = queryObject4.empdetails4[i].count;
		 var count2 = queryObject4.empdetails4[i].count2;
		 
		    data.addRows([
		        [org,parseInt(count1),parseInt(count2)]
		    ]);
	}

	// Set chart options
	var options = {'title':'The Relation with Member Number and Paper Number by affiliation 2011 ',
					curveType: 'function',
	               'width':950,
	               'height':500};

	// Instantiate and draw our chart, passing in some options.
	var chart = new google.visualization.LineChart(document.getElementById('chart'));
	chart.draw(data, options);
	}
function choose(){
	if(document.getElementById("A").checked==true){
		drawChart();
	}else if(document.getElementById("B").checked==true){
		drawChart2();
	}else if(document.getElementById("C").checked==true){
		drawChart3();
	}else if(document.getElementById("D").checked==true){
		drawChart4();
	}else{
		alert("choose from option please");
	}
}
</script>





</head>


<body>


	<header><!-- BEGIN HEADER -->
	<div id="top_header">
		<!-- begin top header -->
		<h1>Fun WIth The Data</h1>
	</div>
	<!-- end top header --> 
	<div id="bottom_header" class="wrap"><!-- begin bottom header -->
            <nav>
                <ul id="top_nav">
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="funwithdata.jsp">Have Fun</a> </li>

                </ul>
            </nav>
            

        </div><!-- end bottom header -->
	
	</header>
	<!-- END HEADER -->

	<div id="main_frame" class="wrap">
		<!-- BEGIN CONTENT -->
		<section id="main">


		<h1>Choose</h1>


		<form id="contact" name="contact" action="" method="post">
			<div id="searcharea">
				<div class="left">
					<label for="search"><b>Draw</b></label>
					<div id="searchoption" style="width:440px;">						
						<input type="radio" id="A" name="radio-btn" value="Author" />Distribution of papers in each conference by affiliation 2011
					</div>
					<div id="searchoption" style="width:440px;">
						<input type="radio" id="B" name="radio-btn" value="PC member" />Member who publish paper
					</div>
					<div id="searchoption" style="width:440px;">
						<input type="radio" id="C" name="radio-btn" value="Affiliation" />The total number of paper accepted each year
					</div>
					<div id="searchoption" style="width:440px;">
						<input type="radio" id="D" name="radio-btn" value="Affiliation" />The Relation with Member Number and Paper Number by affiliation 2011
					</div>
					<!-- 
					<label ><b>Search Option</b></label> -->	
				</div>
			</div>

			<div id="searchbt">
				<div id="bt1" src="" class="btn gradient blue_light center" onclick="choose();">Submit</div>
			</div>

		</form>

		<div id="result">
			<h1>Here shows the Result</h1>
			
			<div id="chart" style="width:1200; height:500"></div>

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
