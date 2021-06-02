<%@page import="com.model.CropHistoryModel"%>
<%@page import="com.helper.DBUtils"%>
<%@page import="org.apache.commons.dbutils.handlers.ColumnListHandler"%>
<%@page import="com.model.DataModel"%>
<%@page import="com.model.UserModel"%>
<%@page import="com.database.ConnectionManager"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>  
<script src="http://code.highcharts.com/maps/highmaps.js"></script>
<script src="https://code.highcharts.com/maps/modules/exporting.js"></script>
<script src="https://code.highcharts.com/mapdata/countries/in/in-all.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- <title>Insert title here</title> -->
  <jsp:include page="../tiles/inc.jsp"></jsp:include>	
  <style type="text/css">
  
  #container {
    height: 500px; 
    min-width: 310px; 
    max-width: 800px; 
    margin: 0 auto; 
}
.loading {
    margin-top: 10em;
    text-align: center;
    color: gray;
}
  
  </style>
</head>
<body>
<div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
     <jsp:include page="../tiles/topmenu.jsp"></jsp:include>
     <div class="container-fluid page-body-wrapper">
     <jsp:include page="../tiles/leftmenu.jsp"></jsp:include>
      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
<%
String query="SELECT GROUP_CONCAT(CONCAT('\"', Crop, '\"')) AS `Crop`,State FROM cropsdetails group by State";
List list = DBUtils.getBeanList(CropHistoryModel.class, query);
String data = "";

for(int i=0;i<list.size();i++){
	CropHistoryModel cm = (CropHistoryModel) list.get(i);
	data += "{data: data,name: '"+cm.getCrop()+"',states: {    hover: {        color: '#BADA55'    }},dataLabels: {    enabled: true,    format: '{point.name}'}}\n";
	if(i<list.size()-1){
		data+=",";
	}
	System.out.println(data);
}
%> 
         
          
          <div class="row">
            <div class="col-lg-12 grid-margin">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title"> Analysis Data</h4>
                  <h1>Welcome to Crop Recommendation System</h1>
                </div>
              </div>
            </div>
          </div>
          <div id="container"></div>
        </div>
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
         <jsp:include page="../tiles/footer.jsp"></jsp:include>	
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->

  <!-- plugins:js -->
  <jsp:include page="../tiles/footerinc.jsp"></jsp:include>	
  <script type="text/javascript">
//Prepare demo data
//Data is joined to map using value of 'hc-key' property by default.
//See API docs for 'joinBy' for more info on linking data and map.
var data = [
   ['in-py', 0],
   ['in-ld', 1],
   ['in-wb', 2],
   ['in-or', 3],
   ['in-br', 4],
   ['in-sk', 5],
   ['in-ct', 6],
   ['in-tn', 7],
   ['in-mp', 8],
   ['in-2984', 9],
   ['in-ga', 10],
   ['in-nl', 11],
   ['in-mn', 12],
   ['in-ar', 13],
   ['in-mz', 14],
   ['in-tr', 15],
   ['in-3464', 16],
   ['in-dl', 17],
   ['in-hr', 18],
   ['in-ch', 19],
   ['in-hp', 20],
   ['in-jk', 21],
   ['in-kl', 22],
   ['in-ka', 23],
   ['in-dn', 24],
   ['in-mh', 25],
   ['in-as', 26],
   ['in-ap', 27],
   ['in-ml', 28],
   ['in-pb', 29],
   ['in-rj', 30],
   ['in-up', 31],
   ['in-ut', 32],
   ['in-jh', 33]
];

//Create the chart
Highcharts.mapChart('container', {
   chart: {
       map: 'countries/in/in-all'
   },

   title: {
       text: ''
   },

   subtitle: {
     //  text: 'Source map: <a href="http://code.highcharts.com/mapdata/countries/in/in-all.js">India</a>'
   },

   mapNavigation: {
       enabled: true,
       buttonOptions: {
           verticalAlign: 'bottom'
       }
   },

   colorAxis: {
       min: 0
   },
   series: [
            <%=data %>
            ]
   
//    series: [{
//        data: data,
//        name: 'Random data',
//        states: {
//            hover: {
//                color: '#BADA55'
//            }
//        },
//        dataLabels: {
//            enabled: true,
//            format: '{point.name}'
//        }
//    },{
//        data: data,
//        name: 'Random 1 data',
//        states: {
//            hover: {
//                color: '#BADA55'
//            }
//        },
//        dataLabels: {
//            enabled: true,
//            format: '{point.name}'
//        }
//    }]
});
  </script>
</body>
</html>