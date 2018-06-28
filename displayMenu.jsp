<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

     <div id='cssmenu'>  
   <ul>
            <c:forEach var="menu" items="${menuLevel}">
       		<li>Menu
       			
       				<ul>
       					
		                	<li><a href='#'>Submenu1</a></li>
		               
			        </ul>
       			
       		
       		</li>
            </c:forEach>
       
   </ul>
</div>
     <%-- <table height="80%" width="80%" border="1">
		 <tr>
	         <td>
	        	 <table height="50%" width="50%" border="0" align="center">
	        	     <tr>
	        	       <% 
	        	       		for(MenuObject menuObject:listOfMenu){
	        	       %> 
						<td>
							<%= menuObject.getMenuNm()  %>
						</td>
						<%  if(menuObject.getListOfMenu()!=null) {
							for(MenuObject subMenuObject:menuObject.getListOfMenu()){
						%>
						<td>
							<%= subMenuObject.getMenuNm()  %>
						</td>
						<%}}} %>
					<tr>
				</table>	
	</table> --%>
</body>
</html>



