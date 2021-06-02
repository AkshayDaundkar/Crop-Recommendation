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
<div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper auth-page">
      <div class="content-wrapper d-flex align-items-center auth register-bg-1 theme-one">
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
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Production Cost</label>
                          <div class="col-sm-9">
        <input type="text" class="form-control" name="cost" placeholder="Production Cost">
                          </div>
                        </div>
                         <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Area in Acres</label>
                          <div class="col-sm-9">
        <input type="text" class="form-control" name="area" placeholder="Area in Acres">
                          </div>
                        </div>
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Select Season</label>
                          <div class="col-sm-9">
                           <select name=season class="form-control">
                    <%=ConnectionManager.getCombo("SELECT dataid as ke, name as val FROM cropdataset where datatype like 'season'")%>
                  </select>
                          </div>
                        </div>
                        <div class="form-group">
                  <button class="btn btn-primary submit-btn btn-block">Add</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
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
		$.post("<%=request.getContextPath()%>/tiles/ajax.jsp?methodId=predictcrop",
				str,
				function(data) {
			data=$.trim(data);  
		
			alert(data);
		
		
	

				});


	}
</script>
</body>
</html>