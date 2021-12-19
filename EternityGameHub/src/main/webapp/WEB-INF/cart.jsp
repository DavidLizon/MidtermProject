<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
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
		<div>
			<c:when test="${empty gamesInCart}" >
				<h3>Your cart is empty.</h3>
			</c:when>
		</div>
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
			<tbody>
				<!-- <label for="cartList"> -->
				<c:set var="total" value="0"></c:set>
				<c:forEach items="${gamesInCart}" var="cartItem">
					<c:set var="total" ><fmt:formatNumber type="number" value="${total + cartItem.salePrice}"/></c:set>
					<tr>
						<img src="${cartItem.game.gameImageUrl}" alt="${game.title} Cover Art">
						<td>${cartItem.game.title}</td>
						<td>${cartItem.description}</td>
						<td><fmt:formatNumber type="currency" value="${cartItem.salePrice}"/></td>
						<td>
							<div>
								<!-- Have to confirm action & method type -->
								<form action="removeItemFromCart.do" method="GET">
									<input type="submit" value="Remove">
									<input type="hidden" value="${cartItem.id}" name="removeItemId">
								</form>
							</div>						
						</td>
					</tr>
				</c:forEach>
			</tbody>	
			<tfoot>
				<tr>
					<td colspan="3" align="right">Total: </td>
					<td><fmt:formatNumber type="currency" value="${total}"/></td>
				</tr>
			</tfoot>
		<!-- </label> -->
		</table>
		<br>
		<div>
			<!-- Have to confirm action & method type -->
			<form action="completePurchase.do" method="GET">
				<input type="submit" value="Complete Transaction">
			</form>
		</div>
		
</c:otherwise>
</c:choose>







</body>
</html>