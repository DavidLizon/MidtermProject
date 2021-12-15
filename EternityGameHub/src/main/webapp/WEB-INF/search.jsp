<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eternity Game Hub</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />

	<div>
		<c:choose>

			<c:when test="${! empty result}">
				<ul>
					<c:forEach var="item" items="${result}">
						<!-- Need to confirm these names are correct  -->
						<li><a href="goToItemListing.do?inventoryItemId=${item.id}">${item.game.title}</a></li>
						<!-- Need to confirm href is correct -->
					</c:forEach>
				</ul>
				<!-- Not seeing what you're looking for? -->

			</c:when>



		</c:choose>

	</div>
</body>
</html>