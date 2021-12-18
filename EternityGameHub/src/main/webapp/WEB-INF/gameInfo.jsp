<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${game.title} | Eternity GameHub</title>
<!-- How can we pull title from the game to display in the title? -->
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />

	<div>
		<h2>${gameItem.game.title}</h2>
		<br> 
		<img src="${gameItem.game.gameImageUrl}" alt="${gameItem.game.title} Cover Art">
	</div>

	<!-- Rental code, for when we decide to implement it
	 
	<div>
	Rent for $${GameInventory.rentPrice} per night
	</div>
	
	<div>
	
	<!-- Have to confirm action & method type
	
	<form action="addRentalToCart.do" method="GET">
	<label for="rentalDuration">Rental Duration:</label>
	<input type="number" id="rentalDuration" name="rentalDuration" min="3" max="14" placeholder="Min 3, Max 14">
	<input type="submit" value="Add Rental to Cart">
	</form>
	</div>
	
	-->

	<div>
	Buy for <fmt:formatNumber type="currency" value="${gameItem.salePrice}"/>  
	</div>

	<div>
		<!-- Have to confirm action & method type -->
		<form action="addToCart.do" method="GET">
			<input type="submit" value="Add Purchase to Cart">
			<input type="hidden" name="addToCartByInventoryId" value="${gameItem.id}"/>
		</form>
	</div>
		<c:choose>
			<c:when test="${!empty gameAlreadyInCart}">
				<h5>${gameAlreadyInCart}</h5>
			</c:when>
		</c:choose>
	<div>
		<!-- this can be wrapped in a box, these are instructions how  https://www.w3schools.com/css/css_boxmodel.asp -->
		${gameItem.game.description} <br><br> User description: ${gameItem.description } <br>
			
	</div>

	<!-- Seller description/rating/history, for when we decide to implement it -->

	<!-- <div>
		<!-- need to be sure the user name is of the seller, not the buyer -->
		<!-- need to add if/choose logic in case the seller has no history
		<ol>
			<c:forEach var="sale" items="${sale.seller_id}">
				<!-- ${sale.name} is temporary, I have to figure out how to map the game 
					title to sale object (sale.game_inventory_id >> game_inventory.game_id >> game.title 
				<li>${sale.game_inventory_id.name}<br> Rating:
					${sale.rating_by_buyer} <br> ${sale.comment_by_buyer}
				</li>
			</c:forEach>
		</ol>
	</div>
	  -->

</body>
</html>