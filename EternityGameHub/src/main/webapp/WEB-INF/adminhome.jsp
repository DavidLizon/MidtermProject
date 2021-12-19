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

<section class="adminHomeHeader">
      <div class="container">
	 	     <div>
	        	<h2> WELCOME ADMIN</h2>
	        </div>
	   </div>
</section>

  <!-- displays all active listings  -->
  <%-- <form class="admin-all-listings" action="displayAllActiveGameListings.do" method="GET" id="activelistings">
		<c:choose>
			<c:when test="${! empty allGames}">
			<h2>Active Listings</h2>
				<ul>
					<c:forEach var="item" items="${allGames}">
						<c:choose>
							<c:when test="${item.available}">
								<li><a href="displayGameInventoryItem.do?Id=${item.id}">${item.game.title} <fmt:formatNumber type="currency" value="${item.salePrice}"/> Seller ${item.user.username}</a></li>
								<li><input type="submit" value="Remove" name="removeGameInventoryItem.do"><input type="hidden" value="${item.id}" name="id"></li>
							</c:when>
						</c:choose>
					</c:forEach>
				</ul>
			</c:when>
		</c:choose>
</form>

<!-- displays all users  -->
 <form class="admin-all-users" action="displayAllUsers.do" method="GET" id="allUsers">
		<c:choose>
			<c:when test="${! empty allUsers}">
			<h2>All Users</h2>
				<ul>
					<c:forEach var="item" items="${allUsers}">
						<li>First Name: ${item.firstName}</li>
						<li>Last Name: ${item.lastName}</li>
						<li>Username: ${item.username}</li>
						<li>Email: ${item.email}</li>
						<li>Account Created: ${item.accountCreated}</li>
						<li>Role: ${item.role}</li>
						<li>Enabled Status: ${item.enabled}</li>
						<li><a href="http://mail.google.com/mail/u/1/?view=cm&fs=1&to=${item.email}&tf=1">CONTACT</a></li>
						<li><input type="submit" value="Remove" name="changeEnabledStatusOfUser.do"></li>
					</c:forEach>
				</ul>
			</c:when>
		</c:choose>
</form> --%>
</body>
</html>