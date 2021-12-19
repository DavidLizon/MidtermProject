<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<jsp:include page="bootstrapHead.jsp"/>
<nav>
	<ul class="navbar">
		<li><a class="logo">Eternity<span>GameHub</span></a></li>
		<!-- <li><a href="displayAllActiveGameListings.do">Active Listings</a></li> -->
		<li><a href="passToChangeUserEnableStatusListingPage.do">Active Users</a></li>
		<li><a href="passToRemoveListingPage.do">Active Listings</a></li>
		<li><a href="logout.do">Log Out</a></li>
	</ul>
</nav>

<tbody class="adminDisableUser">
		<c:choose>
			<c:when test="${! empty activeUsers}">
			<h2>All Users</h2>
				<ul class="adminDisableUser-user">
					<c:forEach var="item" items="${activeUsers}">
						<li>First Name: ${item.firstName}</li>
						<li>Last Name: ${item.lastName}</li>
						<li>Username: ${item.username}</li>
						<li>Email: ${item.email}</li>
						<li>Account Created: ${item.accountCreated}</li>
						<li>Role: ${item.role}</li>
						<li>Enabled Status: ${item.enabled}</li>
						<li><a href="http://mail.google.com/mail/u/1/?view=cm&fs=1&to=${item.email}&tf=1">CONTACT</a></li>
						<div class="adminDisableUserDelete">
								<form action="disableUser.do" method="GET">
									<input type="submit" value="Change Enabled">
									<input type="hidden" value="${item.id}" name="id">
								</form>	</div>				
					</c:forEach>
				</ul>
			</c:when>
		</c:choose>	
</tbody>
</html>