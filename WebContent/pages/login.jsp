<!DOCTYPE html>
<html lang="en">

<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- <title>Insert title here</title> -->
  <jsp:include page="../tiles/inc.jsp"></jsp:include>	
</head>

<body>
  <div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper auth-page">
      <div class="content-wrapper d-flex align-items-center auth auth-bg-1 theme-one">
        <div class="row w-100">
          <div class="col-lg-4 mx-auto">
            <div class="auto-form-wrapper">
              <form name="myform" id="myform" action="javascript:fnSubmit();">
                <div class="form-group">
                  <label class="label">Username</label>
                  <div class="input-group">
                    <input type="text" class="form-control" name="uname" placeholder="Username">
                    <div class="input-group-append">
                      <span class="input-group-text">
                        <i class="mdi mdi-check-circle-outline"></i>
                      </span>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="label">Password</label>
                  <div class="input-group">
                    <input type="password" name="password" class="form-control" placeholder="*********">
                    <div class="input-group-append">
                      <span class="input-group-text">
                        <i class="mdi mdi-check-circle-outline"></i>
                      </span>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <button type="submit" class="btn btn-primary submit-btn btn-block">Login</button>
                </div>
                
                <div class="text-block text-center my-3">
                  <span class="text-small font-weight-semibold">Not a member ?</span>
                  <a href="register.jsp" class="text-black text-small">Create new account</a>
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
   <jsp:include page="../tiles/footer.jsp"></jsp:include>	
        <!-- partial -->
      <!-- main-panel ends -->
    <!-- page-body-wrapper ends -->
  <!-- container-scroller -->

  <!-- plugins:js -->
  <jsp:include page="../tiles/footerinc.jsp"></jsp:include>	
  <script type="text/javascript">
  
  </script>
  <!-- endinject -->
</body>
<script>

function fnSubmit(){	

	
	
	 var str = $("#myform" ).serialize();
	$.post("<%=request.getContextPath()%>/tiles/ajax.jsp?methodId=checkLogin",  
			str,
			function(data) {
data=$.trim(data);

if (data==1) {
	window.location.href="<%=request.getContextPath()%>/pages/dashboard.jsp";
} else {
alert("Please Enter Valid credentials");
}

$('#myform')[0].reset();

			});


}


</script>
</html>