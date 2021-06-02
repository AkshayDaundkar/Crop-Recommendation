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
 <%UserModel um = (UserModel)session.getAttribute("USER_MODEL");
 String ui = um.getUid();%> 
	<div class="container-scroller">
		<!-- partial:partials/_navbar.html -->
		<jsp:include page="../tiles/topmenu.jsp"></jsp:include>
		<div class="container-fluid page-body-wrapper">
			<jsp:include page="../tiles/leftmenu.jsp"></jsp:include>
			<!-- partial -->
			<div class="row w-100">
				<div class="col-lg-4">
					<h2 class="mb-4">Enter Details</h2>
					<div class="">
						<form name="myform" id="myform" action="javascript:fnSubmit();"
							method="post">

							<div class="form-group row">
								<label class="col-sm-3 col-form-label">Select State</label>
								<div class="col-sm-9">
									<select name="state" class="form-control">
										<%=ConnectionManager
					.getCombo("SELECT dataid as ke, name as val FROM cropdataset where datatype like 'state'")%>
									</select>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3 col-form-label">Select District</label>
								<div class="col-sm-9">
									<select name="dist" class="form-control">
										<%=ConnectionManager
					.getCombo("SELECT dataid as ke, name as val FROM cropdataset where datatype like 'district'")%>
									</select>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3 col-form-label">Production Cost</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" name="cost"
										placeholder="Production Cost">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3 col-form-label">Area in Acres</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" name="area"
										placeholder="Area in Acres">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-3 col-form-label">Select Season</label>
								<div class="col-sm-9">
									<select name=season class="form-control">
										<%=ConnectionManager
					.getCombo("SELECT dataid as ke, name as val FROM cropdataset where datatype like 'season'")%>
									</select>
								</div>
							</div>
							<div class="form-group">
								<button class="btn btn-primary submit-btn btn-block">Predict</button>
							</div>
						</form>

					</div>


				</div>
				<div class="col-lg-6" id="out" style="display: none;">
					Recommended Crops <br>
					<br>
					<br>
					<p id="output"></p>

				</div>
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
		$.post("<%=request.getContextPath()%>/tiles/ajax.jsp?methodId=predictcrop&uid="+<%=ui%>,
							str,
							function(data) {
								// 			data=$.trim(data);  

								// 			alert(data);
								document.getElementById('out').style.display = "block";
								document.getElementById('output').innerHTML = data;

							});

		}
  
		
		
	
	</script>
</body>
</html>