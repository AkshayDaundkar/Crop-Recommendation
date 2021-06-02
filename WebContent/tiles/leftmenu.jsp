 <%@page import="com.model.UserModel"%>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
          <li class="nav-item nav-profile">
            <div class="nav-link">
              <div class="user-wrapper">
                <div class="profile-image">
                  <img src="<%=request.getContextPath()%>/theme/images/faces/face1.jpg" alt="profile image">
                </div>
                <%UserModel um = (UserModel)session.getAttribute("USER_MODEL"); 
                
                if(um!=null){
                	
                %>
                
                <div class="text-wrapper"> 
                  <p class="profile-name"><%=um.getName() %></p>
                  <div>
                    <small class="designation text-muted">Analyst</small>
                    <span class="status-indicator online"></span>
                  </div>
                </div>
              </div>
              <button class="btn btn-success btn-block">Farming Analysis 
                <i class="mdi mdi-plus"></i>
              </button>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/pages/dashboard.jsp">
              <i class="menu-icon mdi mdi-television"></i>
              <span class="menu-title">Dashboard</span>
            </a>
          </li>

          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/pages/history.jsp">
              <i class="menu-icon mdi mdi-backup-restore"></i>
              <span class="menu-title">History Data</span>
            </a>
          </li>
        
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/pages/prediction.jsp">
              <i class="menu-icon mdi mdi-backup-restore"></i>
              <span class="menu-title">Crop Recommendation</span>
            </a>
          </li>
          
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/pages/predictAll.jsp">
              <i class="menu-icon mdi mdi-backup-restore"></i>
              <span class="menu-title">Crop Recommendation(India)</span>
            </a>
          </li>
<%} %>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
              <i class="menu-icon mdi mdi-restart"></i>
              <span class="menu-title">User Pages</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="auth">
              <ul class="nav flex-column sub-menu">
<!--                 <li class="nav-item"> -->
<!--                   <a class="nav-link" href="pages/samples/blank-page.html"> Blank Page </a> -->
<!--                 </li> -->
                <li class="nav-item">
                  <a class="nav-link" href="login.jsp"> Login </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="register.jsp"> Register </a>
                </li>
                 <li class="nav-item">
                  <a class="nav-link" href="<%=request.getContextPath()%>/tiles/ajax.jsp?methodId=logout"> Logout </a>
                </li>
<!--                 <li class="nav-item"> -->
<!--                   <a class="nav-link" href="pages/samples/error-404.html"> 404 </a> -->
<!--                 </li> -->
<!--                 <li class="nav-item"> -->
<!--                   <a class="nav-link" href="pages/samples/error-500.html"> 500 </a> -->
<!--                 </li> -->
              </ul>
            </div>
          </li>
        </ul>
      </nav>