<%@page import="com.model.UserModel"%>
<%@page import="com.constants.ServerConstants"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="com.database.ConnectionManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.helper.StringHelper"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
	String sMethod = StringHelper.n2s(request.getParameter("methodId"));
	String returnString = "";
	System.out.println("HIIIII");
	boolean bypasswrite = false;
	HashMap parameters = StringHelper.displayRequest(request);
	HashMap hm = null;

	
	
	 if(sMethod.equalsIgnoreCase("registerNewUser")){

		returnString = ConnectionManager.insertUser(parameters);
		if(returnString.length()>6){
			returnString = "2";
		}else{
			returnString = "1";
		}
		
		}else if (sMethod.equalsIgnoreCase("addNewCrop")) {
		
			
			returnString = ConnectionManager.addNewCrop(parameters);
		}else if (sMethod.equalsIgnoreCase("predictcrop")) {
		
			returnString = ConnectionManager.predictCrop(parameters);
		}  else if (sMethod.equalsIgnoreCase("getProduct"))
		{   
			returnString = ConnectionManager.getProductName(parameters);
		} else if (sMethod.equalsIgnoreCase("getHistory"))
		{   
			returnString = ConnectionManager.getHistory(parameters);
		} 
		else if (sMethod.equalsIgnoreCase("checkLogin")) {
			UserModel um= ConnectionManager.checkLogin(parameters);
			if(um!=null){
		session.setAttribute("USER_MODEL", um);    
		returnString="1";
			}else{
		returnString="2";
			}
		}
	else if (sMethod.equalsIgnoreCase("logout")) {
	session.removeAttribute("USER_MODEL");
	bypasswrite=true;
	%>
			<script>  
			window.location.href='<%=request.getContextPath()%>/pages/login.jsp';
			</script>   
	<%
	}
	if(!bypasswrite){
	out.println(returnString);
	}
%>
