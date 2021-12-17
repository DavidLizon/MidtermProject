<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eternity Game Hub</title>
<jsp:include page="bootstrapHead.jsp"/>
</head>
<body>
<jsp:include page="navBar.jsp" />


<c:choose>
<c:when test="${empty gamesInCart }" >
	<h3>Your cart is empty.</h3>
</c:when>
<c:otherwise>
		<table id="cart" >
			<thead>
				<tr>
					<th></th>
					<th><h6>Title</h6></th>
					<th><h6>Description</h6></th>
					<th><h6>Condition</h6></th>
					<th><h6>Price</h6></th>
				</tr>
			</thead>
				<!-- <label for="cartList"> -->
				<tr>
					<c:forEach items="${gamesInCart.id}" var="genres">
				
						<td>${gamesInCart.game.title}</td>
						<td>${gamesInCart.game.description}</td>
						<td>${game.condition}</td>
						<td>${game.price}</td>
					</c:forEach>
				</tr>
		<!-- </label> -->
		</table>
		<br>
</c:otherwise>
</c:choose>







</body>
</html>