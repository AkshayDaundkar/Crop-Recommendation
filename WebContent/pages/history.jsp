<%@page import="com.model.CropHistoryModel"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- <title>Insert title here</title> -->
  <jsp:include page="../tiles/inc.jsp"></jsp:include>	
</head>
<body>
    <!-- partial:partials/_navbar.html -->
     <jsp:include page="../tiles/topmenu.jsp"></jsp:include>
     <div class="container-fluid page-body-wrapper">
     <jsp:include page="../tiles/leftmenu.jsp"></jsp:include>
      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">

        <div class="row w-100">
          <div class="col-lg-4 mx-auto">
            <h2 class="text-center mb-4">Enter Details</h2>
            <div class="auto-form-wrapper">
              <form name="myform" id="myform" action="javascript:fnSubmit();" method="post">
              
                     <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Select State</label>
                          <div class="col-sm-9">
                           <select name="state" class="form-control">
                    <%=ConnectionManager.getCombo("SELECT dataid as ke, name as val FROM cropdataset where datatype like 'state'")%>
                  </select>
                          </div>
                        </div>  
                         <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Select District</label>
                          <div class="col-sm-9">
                           <select name="dist" class="form-control">
                    <%=ConnectionManager.getCombo("SELECT dataid as ke, name as val FROM cropdataset where datatype like 'district'")%>
                  </select>
                          </div>
                        </div>
                        <div class="form-group">
                  <button class="btn btn-primary submit-btn btn-block">Add</button>
                </div>
              </form>
            </div>
          </div>
      
        
<%UserModel um = (UserModel)session.getAttribute("USER_MODEL");
if(um!=null){
List list = ConnectionManager.getHistoryDataSet();
String[] collumnName = {"chid","State","District","Crop","Season","Crop","Area","Production"};
%>
         
          
          <div class="row">
            <div class="col-lg-12 grid-margin">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title"> Analysis Data</h4>
                  <div class="table-responsive">
                    <table class="table table-bordered" id="myTable">
                      <thead>
                        <tr>
                        <%  
                       	for(int i=0;i<collumnName.length;i++){
                                           
                       %>
                          <th><%=collumnName[i] %></th>
<%} %>
                        </tr>
                      </thead>
                      <tbody>
                       <%  
                       	for(int i=0;i<list.size();i++){
                       		System.out.println("list size : "+list.size());
                       		CropHistoryModel agent=(CropHistoryModel)list.get(i);
                       		System.out.println("agent : "+agent.getDistrict_Name());
                       %>
                    	<tr>
                    	   
				            <td><%=i+1%></td>
							<td><%=agent.getState_Name()%></td>
							<td><%=agent.getDistrict_Name()%></td>
							<td><%=agent.getCrop_Year()%></td>
							<td><%=agent.getSeason()%></td>
							<td><%=agent.getCrop()%></td>
							<td><%=agent.getArea()%></td>
							<td><%=agent.getProduction()%></td>
 
                       </tr>
                       <%  
                       }}
                       %>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
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
  <script>
	  $(function () {
	    $('input').iCheck({
	      checkboxClass: 'icheckbox_square-blue',
	      radioClass: 'iradio_square-blue',
	      increaseArea: '20%' // optional
	    });
	  });
	  function fnSubmit(){	
			 var str = $("#myform" ).serialize();
			 $.post("<%=request.getContextPath()%>/tiles/ajax.jsp?methodId=getHistory",
					str,
					function(data) {
				data=$.trim(data);  
				$("#myTable").html(data);
				alert(data);
					});
		}
  </script>

</body>
</html>