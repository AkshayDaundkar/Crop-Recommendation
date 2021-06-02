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
      <div class="content-wrapper d-flex align-items-center auth register-bg-1 theme-one">
        <div class="row w-100">
          <div class="col-lg-4 mx-auto">
            <h2 class="text-center mb-4">Register</h2>
            <div class="auto-form-wrapper">
              <form name="myform" id="myform" action="javascript:fnSubmit();">
              <div class="form-group">
                  <div class="input-group">
                    <input type="text" class="form-control" name ="fname" placeholder="First Name" required>
                    <div class="input-group-append">
                      <span class="input-group-text">
                        <i class="mdi mdi-check-circle-outline"></i>
                      </span>
                    </div>
                  </div>
                </div>
                
                <div class="form-group">
                  <div class="input-group">
                    <input type="text" class="form-control" name="lname" placeholder="Last Name" required>
                    <div class="input-group-append">
                      <span class="input-group-text">
                        <i class="mdi mdi-check-circle-outline"></i>
                      </span>
                    </div>
                  </div>
                </div>
                
                <div class="form-group">
                  <div class="input-group">
                    <input type="text" class="form-control" name="phone" placeholder="Mobile Number" pattern=[789][0-9]{9}>
                    <div class="input-group-append">
                      <span class="input-group-text">
                        <i class="mdi mdi-check-circle-outline"></i>
                      </span>
                    </div>
                  </div>
                </div>
                
                <div class="form-group">
                  <div class="input-group">
                    <input type="text" class="form-control" name="email" placeholder="Email" pattern="[a-z0-9._]+@[a-z0-9.-]+\.[a-z]{2,}$">
                    <div class="input-group-append">
                      <span class="input-group-text">
                        <i class="mdi mdi-check-circle-outline"></i>
                      </span>
                    </div>
                  </div>
                </div>
               <div class="form-group">
                  <div class="input-group">
                    <input type="text" class="form-control" name="address" placeholder="Address" required>
                    <div class="input-group-append">
                      <span class="input-group-text">
                        <i class="mdi mdi-check-circle-outline"></i>
                      </span>
                    </div>
                  </div>
                </div>
                
                <div class="form-group">
                  <div class="input-group">
                    <input type="text" class="form-control"  name="uname" placeholder="Username" required>
                    <div class="input-group-append">
                      <span class="input-group-text">
                        <i class="mdi mdi-check-circle-outline"></i>
                      </span>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <div class="input-group">
                    <input type="password" class="form-control" name="password" placeholder="Password" required>
                    <div class="input-group-append">
                      <span class="input-group-text">
                        <i class="mdi mdi-check-circle-outline"></i>
                      </span>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <div class="input-group">
                    <input type="password" class="form-control" placeholder="Confirm Password" required>
                    <div class="input-group-append">
                      <span class="input-group-text">
                        <i class="mdi mdi-check-circle-outline"></i>
                      </span>
                    </div>
                  </div>
                </div>
                
                <div class="form-group">
                  <button class="btn btn-primary submit-btn btn-block">Register</button>
                </div>
                <div class="text-block text-center my-3">
                  <span class="text-small font-weight-semibold">Already have and account ?</span>
                  <a href="login.jsp" class="text-black text-small">Login</a>
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
   <jsp:include page="../tiles/footer.jsp"></jsp:include>	
        <!-- partial -->
     
      <!-- main-panel ends -->
  <!-- page-body-wrapper ends -->
  <!-- container-scroller -->

  <!-- plugins:js -->
  <jsp:include page="../tiles/footerinc.jsp"></jsp:include>	
  <script type="text/javascript">
  
  </script>
</body>
<script type="text/javascript">

function fnSubmit(){	

	if($('#password').val()!=$('#cpass').val()){
		alert('Password and confirm password do not match!');
		return;
	}
	
	 var str = $("#myform" ).serialize();
	$.post("<%=request.getContextPath()%>/tiles/ajax.jsp?methodId=registerNewUser",
			str,
			function(data) {
data=$.trim(data); 
if(data=="1")
	alert("Registration Unsuccessful");
else
	alert("Registration Successful");
$('#myform')[0].reset();
window.location.href='<%=request.getContextPath()%>/pages/login.jsp';
			});


}

</script>
</html>