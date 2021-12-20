<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<jsp:include page="bootstrapHead.jsp"/>
<nav>
	<ul class="navbar">
		<li><a class="logo">Eternity<span>GameHub</span></a></li>
		<li><a href="passToChangeUserEnableStatusListingPage.do">Active Users</a></li>
		<li><a href="passToRemoveListingPage.do">Active Listings</a></li>
		<li><a href="logout.do">Log Out</a></li>
	</ul>
</nav>

<section>
	 <div class="adminHomeHeader">
	       <h2> WELCOME ADMIN</h2>
	 </div>
</section>

</body>
</html>