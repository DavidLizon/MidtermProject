<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<jsp:include page="bootstrapHead.jsp"/>

<head>
<style>
	body {
		margin: 1em; 
	}
	.box {
		display:inline-block;
		width: 100px;
		height: 24px;
		background-color: black; 
	}
</style>
</head>
<nav>
	<ul class="navbar">
		<li><a class="logo">Eternity<span>GameHub</span></a></li>
		<!-- <li><a href="displayAllActiveGameListings.do">Active Listings</a></li> -->
		<li><a href="passToChangeUserEnableStatusListingPage.do">Active Users</a></li>
		<li><a href="passToRemoveListingPage.do">Active Listings</a></li>
		<li><a href="logout.do">Log Out</a></li>
	</ul>
</nav>

<body>
	<table class = "admin-disable-user-table">
		<c:choose>
				<c:when test="${! empty activeUsers}">
				<h2>All Users</h2>
					<thead><tr>
							<th>First Name: </th>
							<th>Last Name: </th>
							<th>Username: </th>
							<th>Email: </th>
							<th>Account Created: </th>
							<th>Role: </th>
							<th>Enabled Status:</th>
							<th>Contact</th>
							<th>Change Status:</th> 
					</tr></thead>
					<c:forEach var="item" items="${activeUsers}">
					<tbody>
						<tr>
							<td>${item.firstName}</td>
							<td>${item.lastName}</td>
							<td>${item.username}</td>
							<td>${item.email}</td>
							<td>${item.accountCreated}</td>
							<td>${item.role}</td>
							<td>${item.enabled}</td>
							<td><a href="http://mail.google.com/mail/u/1/?view=cm&fs=1&to=${item.email}&tf=1">EMAIL</a></td>
							<td><div class="adminDisableUserDelete">
									<form action="disableUser.do" method="GET">
										<input type="submit" value="${!item.enabled}">
										<input type="hidden" value="${item.id}" name="id">
									</form></div></td>
						</tr>
					</tbody>			
				</c:forEach>
				</c:when>
		</c:choose>	
	</table>
</body>
</html>