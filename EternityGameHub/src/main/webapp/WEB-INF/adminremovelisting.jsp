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

<tbody class="adminRemoveListingListings">
		<c:choose>
			<c:when test="${! empty allGames}">
			<h2>Active Listings</h2>
				<ul class="adminRemoveListingItems">
					<c:forEach var="item" items="${allGames}">
					<c:choose>
							<c:when test="${item.available}">
								<tr>
									<td>${item.game.title} </td>
									<td><fmt:formatNumber type="currency" value="${item.salePrice}"/> Seller ${item.user.username}</td>
									<td class="adminRemoveListingButton"><form action="removeGameInventoryItem.do" method="GET">
											<input type="submit" value="Remove">
											<input type="hidden" value="${item.id}" name="id">
										</form></td>
								</tr>
							</c:when>
							</c:choose>
					</c:forEach>
				</ul>
			</c:when>
		</c:choose>
</tbody>
</html>